

docker build -t yutingcai11/multi-client:latest -t yutingcai11/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yutingcai11/multi-server:latest -t yutingcai11/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yutingcai11/multi-worker:latest -t yutingcai11/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push yutingcai11/multi-client:latest
docker push yutingcai11/multi-server:latest
docker push yutingcai11/multi-worker:latest
docker push yutingcai11/multi-client:$SHA
docker push yutingcai11/multi-server:$SHA
docker push yutingcai11/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yutingcai11/multi-server:$SHA
kubectl set image deployments/server-deployment server=yutingcai11/multi-client:$SHA
kubectl set image deployments/server-deployment server=yutingcai11/multi-worker:$SHA 