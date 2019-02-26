#!/usr/bin/env python
#
#
# ETCD_CLUSTER_URL: "etcd01=https://192.168.1.1,etcd02=https://192.168.1.2,etcd03=https://192.168.1.3"
# FLANNEL_ETCD_ENDPOINTS="https://172.20.0.113:2379,https://172.20.0.114:2379,https://172.20.0.115:2379"
# domain = "test.co"
# etcd = {'etcd01': {'ip': '127.0.0.1'}, 'etcd02': {'ip': '192.168.1.2'}, 'etcd03': {'ip': '192.168.1.3'}}

import sys
para = (sys.argv)[1]

def get_etcd_url(domain, etcd):
    etcd_url = ""
    i = 0
    for k, v in etcd.items():
        i += 1
        if i >= len(etcd):
            etcd_url += "%s=https://%s.%s:2380" % (k, k, domain)
        else:
            etcd_url += "%s=https://%s.%s:2380," % (k, k, domain)
    print(etcd_url)

def get_etcd_endpoints(domain, etcd):
    etcd_endpoints = ""
    i = 0
    for k, v in etcd.items():
        i += 1
        if i >= len(etcd):
            etcd_endpoints += "https://%s.%s:2379" % (k, domain)
        else:
            etcd_endpoints += "https://%s.%s:2379," % (k, domain)
    print(etcd_endpoints)

domain = "{{ DOMAIN }}"
etcd = {{ SITE_INFO.etcd }}

if __name__ == "__main__":
    if para == "ETCD_CLUSTER_URL":
        get_etcd_url(domain, etcd)
    else:
        get_etcd_endpoints(domain, etcd)
