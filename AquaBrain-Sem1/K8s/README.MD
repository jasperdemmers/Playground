## K8s
```bash
kube-flannel.yaml = /etc/kubernetes/kube-flannel.yaml
kubeadm.yaml.j2 = /etc/kubernetes/kubeadm.yaml
containerd.toml.j2 = /etc/containerd/config.toml
```
## Load Balancer API
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