docker build -t zhilong1115/multi-client:latest -t zhilong1115/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zhilong1115/multi-server:latest -t zhilong1115/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zhilong1115/multi-worker:latest -t zhilong1115/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zhilong1115/multi-client:latest
docker push zhilong1115/multi-server:latest
docker push zhilong1115/multi-worker:latest

docker push zhilong1115/multi-client:$SHA
docker push zhilong1115/multi-server:$SHA
docker push zhilong1115/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zhilong1115/multi-server:$SHA
kubectl set image deployments/client-deployment client=zhilong1115/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zhilong1115/multi-worker:$SHA