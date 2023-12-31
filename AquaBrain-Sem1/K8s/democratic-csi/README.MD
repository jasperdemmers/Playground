```bash
helm upgrade --install --create-namespace --values nfs.yaml --namespace storage nfs democratic-csi/democratic-csi

helm upgrade --install --create-namespace --values iscsi.yaml --namespace storage iscsi democratic-csi/democratic-csi
```

# List State
```bash
helm ls -n storage

kubectl get all -n storage
```

# Test PVC
```bash
kubectl apply -f pvc-iscsi.yaml -f pvc-nfs.yaml

kubectl get pvc
```

## Cleanup Test
```bash
kubectl delete -f pvc-iscsi.yaml -f pvc-nfs.yaml
```