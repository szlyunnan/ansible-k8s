#!/usr/bin/env bash


{% if groups.ingress_work|default(false) %}


# range(groups.ingress_work|length)


{% for key, value in SITE_INFO.k8s_work.items() %}
{% if value.ip in groups.ingress_work %}
kubectl label nodes {{ key }}.{{ DOMAIN }} {{ TRAEFIK.label_key }}={{ TRAEFIK.label_value }}
{% endif %}
{% endfor %}



{% elif groups.k8s_work.0 %}


{% for key, value in SITE_INFO.k8s_work.items() %}
{% if value.ip == groups.k8s_work.0 %}
kubectl label nodes {{ key }}.{{ DOMAIN }} {{ TRAEFIK.label_key }}={{ TRAEFIK.label_value }}
{% endif %}
{% endfor %}


{% endif %}



kubectl create secret generic {{ TRAEFIK.cert_name }} --from-file={{ APP_WORK }}/ssl/ca-key.pem --from-file={{ APP_WORK }}/ssl/ca.pem -n kube-system

kubectl create configmap {{ TRAEFIK.configmap_name }} --from-file={{ APP_WORK }}/config/traefik.toml -n kube-system
