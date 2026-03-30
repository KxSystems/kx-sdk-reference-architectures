{{/*
Expand the name of the chart.
*/}}
{{- define "kxi-db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kxi-db.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kxi-db.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels - kxi-da
*/}}
{{- define "kxi-db.da.labels" -}}
helm.sh/chart: {{ include "kxi-db.chart" . }}
{{ include "kxi-db.da.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels - kxi-da
*/}}
{{- define "kxi-db.da.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kxi-db.name" . }}-da
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels - kxi-sm
*/}}
{{- define "kxi-db.sm.labels" -}}
helm.sh/chart: {{ include "kxi-db.chart" . }}
{{ include "kxi-db.sm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels - kxi-sm
*/}}
{{- define "kxi-db.sm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kxi-db.name" . }}-sm
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{- define "sidecar.configJson" -}}
{{- $param:= . }}
{{- $sideParam:= dict }}
{{- $ctx:= . }}

{{- if kindIs "slice" $param }}
  {{- $ctx = index $param 0 }}
  {{- $sideParam = index $param 1 }}
  {{- $_:= set $sideParam "ctx" $ctx }}
{{- else if hasKey $param "ctx" }}
  {{- $ctx = $param.ctx }}
{{- end }}
config.json: |-
{{ include "sidecar.buildConfigJson" $sideParam | indent 4 }}
{{- end }}

{{/*
Sidecar object
*/}}
{{- define "sidecar.values" -}}
{{- $sidecar:= dict }}
{{- if hasKey .Values "sidecar" -}}
  {{- $sidecar = .Values.sidecar }}
{{- end }}

{{- $sidecar | toYaml }}
{{- end }}


{{- define "sidecar.frequencySecs" -}}
{{- $freq := 5 -}}
{{- if and (hasKey .Values "sidecar") (hasKey .Values.sidecar "frequencySecs") (not (empty .Values.sidecar.frequencySecs)) -}}
  {{- $freq = (.Values.sidecar.frequencySecs | int) -}}
{{- end -}}
{{- printf "%d" $freq -}}
{{- end -}}


{{/*
Define Metric config
*/}}
{{- define "sidecar.metrics.config" -}}
{{- $metDict:= dict "enabled" "true" }}
{{- $hasConfig:= eq "true" ( include "metrics.hasLocal" . ) }}
{{- $valDict:= dict }}
{{- if $hasConfig }}
  {{- $valDict = .Values.metrics }}
{{- end }}

{{- $_:= set $metDict "frequency" ( $valDict.frequency | default 10 | int ) }}

{{- if ( kindIs "map" $valDict.handler ) }}
  {{- $_:= set $metDict "handler" ( $valDict.handler ) }}
{{- end }}

{{- if ( kindIs "map" $valDict.custom ) }}
  {{- $_:= set $metDict "custom" ( $valDict.custom ) }}
{{- end }}

{{- $metDict | toYaml }}
{{- end }}


{{- define "metrics.hasLocal" -}}
{{- kindIs "map" .Values.metrics }}
{{- end }}



{{/*
Build sidecar `config.json`.

Expected input: a dictionary, for example:
  (dict "ctx" . "metrics" true "connPort" 2001)

Parameters:
- `ctx`: chart context (`.`), required
- `metrics`: enable/disable `metrics` object (default: true)
- `connPort`: single port for `connection` (used when `connPortList` is not set)
- `connPortList`: list of ports for `connectionList` (takes precedence over `connPort`)

Defaults:
- Uses `.Values.sidecar.connPortList` when `connPortList` is not provided.
- Uses `.Values.port` or `.Values.service.port` for `connPort` fallback.
*/}}
{{- define "sidecar.buildConfigJson" -}}
{{- $param:= . }}
{{- $ctx:= .ctx }}
{{- $connDict:= dict }}
{{- $drawMetrics:= true }}
{{- $port:= 2001 }}
{{- $portList:= list }}
{{- $sideCar:= ( include "sidecar.values" $ctx | fromYaml ) -}}

{{- if hasKey $param "metrics" }}
  {{- $drawMetrics = $param.metrics }}
{{- end }}

{{- if hasKey $param "connPortList" }}
  {{- if kindIs "slice" $param.connPortList }}
    {{- $portList = $param.connPortList }}
  {{- end }}
{{- else if kindIs "slice" $sideCar.connPortList }}
  {{- $portList = $sideCar.connPortList }}
{{- end }}

{{- if ( $portList | empty | not ) -}}

  {{- $conList:= list -}}
  {{- range $p := $portList }}
    {{- $conList = append $conList ( printf ":unix://%s" ( $p | toString ) ) }}
  {{- end }}

  {{- $_:= set $connDict "connectionList" $conList }}

{{- else }}
  {{- if hasKey $param "connPort" }}
    {{- $port = ( $param.connPort | default $port ) }}
  {{- else if ( $portList | empty ) }}
    {{- $port = ( $ctx.Values.port | default $ctx.Values.service.port ) }}
  {{- end }}

  {{- $_:= set $connDict "connection" ( printf ":unix://%s" ( $port | toString ) ) }}
{{- end -}}

{{- $freq:= ( include "sidecar.frequencySecs" $ctx | int ) }}
{{- $_:= set $connDict "frequencySecs" $freq }}

{{- if  $drawMetrics }}
  {{- $_:= set $connDict "metrics" ( include "sidecar.metrics.config" $ctx | fromYaml ) }}
{{- end -}}

{{- $connDict | toPrettyJson }}
{{- end -}}
