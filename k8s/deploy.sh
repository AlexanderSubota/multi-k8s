docker build -t alexandersubota/multi-client:latest -t -t alexandersubota/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexandersubota/multi-server:latest -t -t alexandersubota/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexandersubota/multi-worker:latest -t -t alexandersubota/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexandersubota/multi-client:latest
docker push alexandersubota/multi-server:latest
docker push alexandersubota/multi-worker:latest
docker push alexandersubota/multi-client:$SHA
docker push alexandersubota/multi-server:$SHA
docker push alexandersubota/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexandersubota/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexandersubota/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexandersubota/multi-worker:$SHA