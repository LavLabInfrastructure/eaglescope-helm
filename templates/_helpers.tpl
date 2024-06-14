{{- define "eaglescope.name" -}}
{{- if .Values.nameOverride -}}
{{ .Values.nameOverride }}
{{- else -}}
{{ .Chart.Name }}
{{- end -}}
{{- end -}}

{{- define "eaglescope.fullname" -}}
{{- if .Values.fullnameOverride }}
{{ .Values.fullnameOverride }}
{{- else -}}
{{ include "eaglescope.name" . }}-{{ .Release.Name }}
{{- end -}}
{{- end -}}

{{- define "eaglescope.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "eaglescope.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "eaglescope.selectorLabels" -}}
app.kubernetes.io/name: {{ include "eaglescope.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "eaglescope.configMapName" -}}
{{- if .Values.config.name -}}
{{ .Values.config.name }}
{{- else -}}
{{ include "eaglescope.fullname" . }}-config
{{- end -}}
{{- end -}}