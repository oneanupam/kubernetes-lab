{{/*
Expand the name of the chart.
*/}}
{{- define "oneapp-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oneapp-ui.fullname" -}}
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
{{- define "oneapp-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "oneapp-ui.labels" -}}
helm.sh/chart: {{ include "oneapp-ui.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "oneapp-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "oneapp-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "oneapp-ui.name" . }}
app.kubernetes.io/instance: {{ .Values.instance }}
app.kubernetes.io/component: {{ .Values.component}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "oneapp-ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "oneapp-ui.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
