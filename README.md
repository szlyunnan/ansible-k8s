# ansible-k8s
> ansible 2.6.2 部署 kubernetes 版本

```
    整个过程依赖免密ssh登陆, 需要预先配置好.
    1、 修改group_vars下面的配置文件
    2、 安装ansible
        bash install_ansible.sh
    3、 生成ansible inventory 文件
        bash inventory_file.sh
    4、 安装kubernetes群集
        ansible-playbook k8s
```
