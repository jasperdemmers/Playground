## Steps to produce K8s Cluster
### 1. Create VM's
Make sure to be able to access the NetLab when executing. ?? Cisco AnyConnect
```bash
cd Netlab
ansible-playbook Create-K8s-VMs.ansible.yaml
```
### 2. Populate known_hosts file
Make sure to be able to access the internal network (VM's created). ?? OpenVPN
Remove the previous known_hosts file if it exists.
```bash
cd ../K8s
rm known_hosts
touch known_hosts
ansible-playbook Populate-known-hosts.yaml
```
### 3. Install Packages on all hosts
Make sure to be able to access the internal network (VM's created). ?? OpenVPN
```bash
ansible-playbook K8s-install.yaml

```
### 4. Configure the control-plane nodes
Make sure to be able to access the internal network (VM's created). ?? OpenVPN
Copy all the templates with the correct variables
```bash
ansible-playbook K8s-configure.yaml
```
### 5. Initialize K8s Cluster
Make sure to be able to access the internal network (VM's created). ?? OpenVPN
Run the `kubeadm init` command, configure kubelet, apply Flannel CNI, add Masters, add Workers
```bash
ansible-playbook K8s-initialize.yaml
```