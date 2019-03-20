#!/usr/bin/env bash

etcdctl --endpoints={{ FLANNEL_ETCD_ENDPOINTS }} \
  --ca-file={{ APP_WORK }}/ssl/etcd/ca-etcd.pem \
  --cert-file={{ APP_WORK }}/ssl/etcd/etcd-server.pem \
  --key-file={{ APP_WORK }}/ssl/etcd/etcd-server-key.pem \
  mkdir /kube-centos/network

etcdctl --endpoints={{ FLANNEL_ETCD_ENDPOINTS }} \
  --ca-file={{ APP_WORK }}/ssl/etcd/ca-etcd.pem \
  --cert-file={{ APP_WORK }}/ssl/etcd/etcd-server.pem \
  --key-file={{ APP_WORK }}/ssl/etcd/etcd-server-key.pem \
  mk /kube-centos/network/config '{"Network":"{{ FLANNEL_CNI }}","SubnetLen":24,"Backend":{"Type":"{{ FLANNEL_TYPE }}"}}'
