# ansible-k8s
> ansible 2.6.2 部署 kubernetes 版本
- 依赖ansible 2.6.2 版本
- 使用的kubernetes是当前最新版本, 各个版本之间的差异; 对于维护人员来说首先是配置参数

- 安装使用的软件包, 需要提前下载到本地目录
- docker 是rpm包 按照binary目录来下载, 目前不能支持最新的(安装包不一样)

- etcd flanneld kubernetes 都是最新的

```
    整个过程依赖免密ssh登陆, 需要预先配置好.
    1、 修改group_vars下面的配置文件
    2、 安装ansible
        bash install_ansible.sh
    3、 生成ansible inventory 文件
        bash inventory_file.sh
    4、 安装kubernetes群集
        ansible-playbook k8s.yaml
```
