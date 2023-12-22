## Config Files
### K8s
```bash
kube-flannel.yaml = /etc/kubernetes/kube-flannel.yaml
kubeadm.yaml.j2 = /etc/kubernetes/kubeadm.yaml
containerd.toml.j2 = /etc/containerd/config.toml
```
### Load Balancer API
```bash
keepalived.conf = /etc/keepalived/keepalived.conf
haproxy.cfg = /etc/haproxy/haproxy.cfg
check_apiserver.sh = /etc/keepalived/check_apiserver.sh
```
### Manifest files
```bash
manifests/keepalived.yaml = /etc/kubernetes/manifests/keepalived.yaml
manifests/haproxy.yaml = /etc/kubernetes/manifests/haproxy.yaml
```

## Using kubectl locally
use the `kubeconfig.yaml` file.
```bash
export KUBECONFIG=/PATH/TO/YOUR/KUBECONFIG
```
verify the connection:
```bash
kubectl cluster-info
```

## Setup MetalLB
Apply the native metalLB manifest
```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.12/config/manifests/metallb-native.yaml
```
Apply the metallb-IPAddressPool.yaml
```bash
kubectl apply -f manifests/metallb-IPAddressPool.yaml
```