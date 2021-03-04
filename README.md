# minikube-kafka-cluster
Kubernetes Kafka cluster in minikube.

### How to Run

```bash
kubectl apply -f namespace.yaml

kubectl apply -f zookeeper-deployment.yaml # Wait until healthy

kubectl apply -f kafka-broker1-deployment.yaml
```

### Kafka Cluster
To run multiple brokers increase the replicas in ```kafka-broker1-deployment.yaml```

```yaml
spec:
  selector:
    matchLabels:
      app: kafka
  serviceName: "bootstrap"
  replicas: 3
```

