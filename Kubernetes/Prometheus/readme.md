##### Source
https://www.cloudforecast.io/blog/cadvisor-and-kubernetes-monitoring-guide/

## Deployment
The total deployment is split up into 4 manifest files. The cluster roles, configuration, deployment and the service.
```bash
kubectl apply -f clusterRole.yaml
kubectl apply -f config-map.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f prometheus-service.yaml
```