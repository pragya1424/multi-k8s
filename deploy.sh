docker build -t vishalcool1401/multi-client-k8s:latest -t vishalcool1401/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t vishalcool1401/multi-server-k8s-pgfix:latest -t vishalcool1401/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t vishalcool1401/multi-worker-k8s:latest -t vishalcool1401/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push vishalcool1401/multi-client-k8s:latest
docker push vishalcool1401/multi-server-k8s-pgfix:latest
docker push vishalcool1401/multi-worker-k8s:latest

docker push vishalcool1401/multi-client-k8s:$SHA
docker push vishalcool1401/multi-server-k8s-pgfix:$SHA
docker push vishalcool1401/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vishalcool1401/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=vishalcool1401/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=vishalcool1401/multi-worker-k8s:$SHA