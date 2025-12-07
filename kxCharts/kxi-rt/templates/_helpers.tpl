{{/*
Chart resources prefix.
*/}}
{{- define "kxi-rt.resourcePrefix" -}}
{{- "rt-" }}
{{- end }}

{{/*
RT Stream name.
*/}}
{{- define "kxi-rt.streamName" -}}
{{ .Release.Name | trimPrefix ( include "kxi-rt.resourcePrefix" . ) }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "kxi-rt.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kxi-rt.fullname" -}}
{{- $prefix:= include "kxi-rt.resourcePrefix" . -}}
{{- $releaseName:= .Release.Name -}}
{{- if ( hasPrefix $prefix $releaseName | not ) -}}
  {{- $releaseName = printf "%s%s" $prefix $releaseName -}}
{{- end -}}

{{- $releaseName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kxi-rt.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kxi-rt.labels" -}}
helm.sh/chart: {{ include "kxi-rt.chart" . }}
{{ include "kxi-rt.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kxi-rt.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kxi-rt.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
insights.kx.com/serviceName: {{ include "kxi-rt.fullname" . }}
insights_kx_com_app: {{ .Release.Name }}
insights_kx_com_pubTopic: {{ include "kxi-rt.streamName" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kxi-rt.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kxi-rt.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
