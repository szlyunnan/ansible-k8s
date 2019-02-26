#!/usr/bin/env bash

etcdctl --endpoints={{ FLANNEL_ETCD_ENDPOINTS }} \
  --ca-file={{ APP_WORK }}/ssl/ca.pem \
  --cert-file={{ APP_WORK }}/ssl/kubernetes.pem \
  --key-file={{ APP_WORK }}/ssl/kubernetes-key.pem \
  mkdir /kube-centos/network

etcdctl --endpoints={{ FLANNEL_ETCD_ENDPOINTS }} \
  --ca-file={{ APP_WORK }}/ssl/ca.pem \
  --cert-file={{ APP_WORK }}/ssl/kubernetes.pem \
  --key-file={{ APP_WORK }}/ssl/kubernetes-key.pem \
  mk /kube-centos/network/config '{"Network":"{{ FLANNEL_CNI }}","SubnetLen":24,"Backend":{"Type":"{{ FLANNEL_TYPE }}"}}'
