docker build -t superclass2016/multi-client:latest -t superclass2016/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t superclass2016/multi-server:latest -t superclass2016/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t superclass2016/multi-worker:latest -t superclass2016/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push superclass2016/multi-client:latest
docker push superclass2016/multi-server:latest
docker push superclass2016/multi-worker:latest

docker push superclass2016/multi-client:$SHA
docker push superclass2016/multi-server:$SHA
docker push superclass2016/multi-worker:$SHA

kubectl apply -f k8s

kubectl set deployments/client-deployment client=superclass2016/multi-client:$SHA
kubectl set deployments/server-deployment server=superclass2016/multi-server:$SHA
kubectl set deployments/worker-deployment worker=superclass2016/multi-worker:$SHA
