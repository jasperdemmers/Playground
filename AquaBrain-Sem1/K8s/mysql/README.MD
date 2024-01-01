### 1. Deploy CRDs
```bash
kubectl apply -f deploy-crds.yaml
```

### 2. Deploy Operator
```bash
kubectl apply -f deploy-operator.yaml
```

### 3. Deploy Secrets
```bash
kubectl apply -f deploy-secrets.yaml
```

### 4. Deploy Cluster
```bash
kubectl apply -f deploy-cluster.yaml
```

### 5. Deploy Load Balancer
```bash
kubectl apply -f deploy-loadbalancer.yaml
```