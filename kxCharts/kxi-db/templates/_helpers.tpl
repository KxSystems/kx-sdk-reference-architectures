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