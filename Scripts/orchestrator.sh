#!/bin/bash

NAMESPACE="default"  # You can set a specific namespace if needed, or leave it as "default"

function create() {
    echo "Creating Kubernetes resources..."

    # Apply all YAML files in the specified directory
    kubectl create -f ./../Manifests/
    echo "Kubernetes resources created."
}

function start() {
    echo "Starting Kubernetes resources..."

    kubectl --namespace default scale deployment $(kubectl --namespace default get deployment | awk '{print $1}') --replicas 1
    kubectl --namespace default scale statefulset --replicas 1 $(kubectl --namespace default get statefulset  | awk '{print $1}')

    echo "Kubernetes resources started."
}

function stop() {
    echo "Stopping Kubernetes resources..."

    kubectl --namespace default scale deployment $(kubectl --namespace default get deployment | awk '{print $1}') --replicas 0
    kubectl --namespace default scale statefulset --replicas 0 $(kubectl --namespace default get statefulset  | awk '{print $1}')

    echo "Kubernetes resources stopped."
}

function delete() {
    echo "Deleting Kubernetes resources..."

    kubectl delete -f ./../Manifests/

    echo "Kubernetes resources deleted."
}

case "$1" in
    create)
        create
        ;;
    start)
        start
        ;;
    stop)
        stop
        ;;
    delete)
        delete
        ;;
    *)
        echo "Usage: $0 {create|start|stop|delete}"
        exit 1
esac