docker build -t ian035/k8s-client:latest -t ian035/k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t ian035/k8s-server:latest -t ian035/k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t ian035/k8s-worker:latest -t ian035/k8s-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ian035/k8s-client:latest
docker push ian035/k8s-server:latest
docker push ian035/k8s-worker:latest
docker push ian035/k8s-client:$SHA
docker push ian035/k8s-server:$SHA
docker push ian035/k8s-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ian035/k8s-server:$SHA
kubectl set image deployments/client-deployment client=ian035/k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=ian035/k8s-worker:$SHA