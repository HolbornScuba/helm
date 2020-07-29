{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "holborn-wordpress.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "holborn-wordpress.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "holborn-wordpress.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "holborn-wordpress.labels" -}}
helm.sh/chart: {{ include "holborn-wordpress.chart" . }}
{{ include "holborn-wordpress.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "holborn-wordpress.selectorLabels" -}}
app.kubernetes.io/name: {{ include "holborn-wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "holborn-wordpress.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "holborn-wordpress.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
==============   Web      Content   ==============
*/}}

{{- define "holborn-wordpress.webName" -}}
{{- printf "%s-web" (include "holborn-wordpress.name" .) -}}
{{- end -}}

{{- define "holborn-wordpress.webFullname" -}}
{{- printf "%s-web" (include "holborn-wordpress.fullname" .) -}}
{{- end -}}

{{- define "holborn-wordpress.webSelectorLabels" -}}
app.kubernetes.io/name: {{ include "holborn-wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}-web
{{- end -}}

{{- define "holborn-wordpress.webLabels" -}}
helm.sh/chart: {{ include "holborn-wordpress.chart" . }}
{{ include "holborn-wordpress.webSelectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
==============   App      Content   ==============
*/}}
{{- define "holborn-wordpress.appName" -}}
{{- printf "%s-app" (include "holborn-wordpress.name" .) -}}
{{- end -}}

{{- define "holborn-wordpress.appFullname" -}}
{{- printf "%s-app" (include "holborn-wordpress.fullname" .) -}}
{{- end -}}

{{- define "holborn-wordpress.appSelectorLabels" -}}
app.kubernetes.io/name: {{ include "holborn-wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}-app
{{- end -}}

{{- define "holborn-wordpress.appLabels" -}}
helm.sh/chart: {{ include "holborn-wordpress.chart" . }}
{{ include "holborn-wordpress.appSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
