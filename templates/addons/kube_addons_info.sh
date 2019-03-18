#!/usr/bin/env bash

KUBE_ADDONS_INFO={{ KUBE_ADDONS_INFO }}

echo "" > ${KUBE_ADDONS_INFO}
echo -e "traefik hosts info:" >> ${KUBE_ADDONS_INFO}
{% if groups.ingress_work|default(false) %}

{% for key, value in SITE_INFO.k8s_work.items() %}
{% if value.ip in groups.ingress_work %}
echo -e "\t{{ value.ip }} {{ key }}.{{ DOMAIN }}" >> ${KUBE_ADDONS_INFO}
{% endif %}
{% endfor %}

{% elif groups.k8s_work.0 %}

{% for key, value in SITE_INFO.k8s_work.items() %}
{% if value.ip == groups.k8s_work.0 %}
echo -e "\t{{ value.ip }} {{ key }}.{{ DOMAIN }}" >> ${KUBE_ADDONS_INFO}
{% endif %}
{% endfor %}

{% endif %}


echo -e "traefik info:" >> ${KUBE_ADDONS_INFO}
echo -e "\tURL: {{ TRAEFIK.web_url }}" >> ${KUBE_ADDONS_INFO} 
echo -e "\tVIP: {{ INGRESS_KP.vip }}\n" >> ${KUBE_ADDONS_INFO} 

echo -e "grafana info:" >> ${KUBE_ADDONS_INFO}
echo -e "\tURL: {{ GRAFANA.web_url }}" >> ${KUBE_ADDONS_INFO} 
echo -e "\tnodePort: {{ GRAFANA.nodePort }}\n" >> ${KUBE_ADDONS_INFO} 

{% if PRPMETHEUS.tag %}
echo -e "prometheus info:" >> ${KUBE_ADDONS_INFO}
echo -e "\tnodePort: {{ PRPMETHEUS.nodePort }}\n" >> ${KUBE_ADDONS_INFO} 
{% endif %}

{% if EFK.tag %}
echo -e "EFK info:" >> ${KUBE_ADDONS_INFO}
echo -e "\tURL: {{ EFK.web_url }}" >> ${KUBE_ADDONS_INFO} 
echo -e "\tnodePort: {{ EFK.nodePort }}\n" >> ${KUBE_ADDONS_INFO} 
{% endif %}

echo -e "kubernetes dashboard info:" >> ${KUBE_ADDONS_INFO}
echo -e "\tURL: {{ DASHBOARD.web_url }}" >> ${KUBE_ADDONS_INFO}
echo -e "\tnodePort: {{ DASHBOARD.nodeport }}\n" >> ${KUBE_ADDONS_INFO}
echo -e "kubernetes-dashboard-token: \n\t$(kubectl get secret $(kubectl get secret -n kube-system|grep admin-token|awk '{print $1}')  -o jsonpath={.data.token} -n kube-system |base64 -d)\n" >> ${KUBE_ADDONS_INFO}
