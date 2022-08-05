docker build -t guoxiny/multi-client:latest -t guoxiny/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t guoxiny/multi-server:latest -t guoxiny/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t guoxiny/multi-worker:latest -t guoxiny/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push guoxiny/multi-client:latest
docker push guoxiny/multi-server:latest
docker push guoxiny/multi-worker:latest
docker push guoxiny/multi-client:$SHA
docker push guoxiny/multi-server:$SHA
docker push guoxiny/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/client-deployment client=guoxiny/multi-client:$SHA
kubectl set image deployments/server-deployment server=guoxiny/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=guoxiny/multi-worker:$SHA