#!/usr/bin/env bash

kubectl config set-cluster kubernetes \
  --certificate-authority=ca-kube.pem \
  --embed-certs=true \
  {% if not KUBE_MASTER_CLUSTER  %}
  {% if KUBE_APISERVER|default(false) %}
  --server=https://{{ KUBE_APISERVER }}:6443 \
  {% else %}
  --server=https://{{ groups.k8s_master.0 }}:6443 \
  {% endif %}
  {% else %}
  {% if KUBE_PROXY == "127.0.0.1"  or KUBE_PROXY == "localhost" %}
  --server=https://localhost.{{ DOMAIN }}:{{ KUBE_PROXY_PORT }} \
  {% else %}
  --server=https://{{ KUBE_PROXY }}:{{ KUBE_PROXY_PORT }} \
  {% endif %}
  {% endif %}
  --kubeconfig=bootstrap.kubeconfig

kubectl config set-credentials kubelet-bootstrap \
  --token={{ BOOTSTRAP_TOKEN }} \
  --kubeconfig=bootstrap.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes \
  --user=kubelet-bootstrap \
  --kubeconfig=bootstrap.kubeconfig

kubectl config use-context default --kubeconfig=bootstrap.kubeconfig

kubectl config set-cluster kubernetes \
  --certificate-authority=ca-kube.pem \
  --embed-certs=true \
  {% if not KUBE_MASTER_CLUSTER  %}
  {% if KUBE_APISERVER|default(false) %}
  --server=https://{{ KUBE_APISERVER }}:6443 \
  {% else %}
  --server=https://{{ groups.k8s_master.0 }}:6443 \
  {% endif %}
  {% else %}
  {% if KUBE_PROXY == "127.0.0.1"  or KUBE_PROXY == "localhost" %}
  --server=https://localhost.{{ DOMAIN }}:{{ KUBE_PROXY_PORT }} \
  {% else %}
  --server=https://{{ KUBE_PROXY }}:{{ KUBE_PROXY_PORT }} \
  {% endif %}
  {% endif %}
  --kubeconfig=kube-proxy.kubeconfig

kubectl config set-credentials kube-proxy \
  --client-certificate=kube-proxy.pem \
  --client-key=kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig

kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
