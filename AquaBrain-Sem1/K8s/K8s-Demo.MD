# K8s Demo

#### Deploy nginx-demo.yaml
```bash
kubectl apply -f nginx-demo.yaml
```

#### Display Pods & Service
```bash
kubectl get pods -o wide
kubectl get svc -o wide
```

#### Browse to site
[http://10.1.4.10](http://10.1.4.10) to visit the site.

#### Delete deployment
```bash
kubectl delete -f nginx-demo.yaml
```

#### Edit manifest
Uncomment line 6 `replicas: 5`

#### Redeploy nginx-demo.yaml
```bash
kubectl apply -f nginx-demo.yaml
```

#### Display Pods & Services
```bash
kubectl get pods -o wide
kubectl get svc -o wide
```

#### Browse to site
Site still works.
[http://10.1.4.10](http://10.1.4.10) to visit the site.

#### Delete a pod and check recreation
copy pod name
```bash
kubectl get pods
```
Delete pod
```bash
kubectl delete pod <INSERT_NAME>
```
Show Pods => check age
```bash
kubectl get pods -o wide
```

