docker build -t mjhatamy/multi-client:latest -t mjhatamy/multi-client:"$GIT_SHA" -f ./client/Dockerfile ./client
docker build -t mjhatamy/multi-server:latest -t mjhatamy/multi-server:"$GIT_SHA" -f ./server/Dockerfile ./server
docker build -t mjhatamy/multi-worker:latest -t mjhatamy/multi-worker:"$GIT_SHA" -f ./worker/Dockerfile ./worker

docker push mjhatamy/multi-client:latest
docker push mjhatamy/multi-server:latest
docker push mjhatamy/multi-worker:latest

docker push mjhatamy/multi-client:"$GIT_SHA"
docker push mjhatamy/multi-server:"$GIT_SHA"
docker push mjhatamy/multi-worker:"$GIT_SHA"


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mjhatamy/multi-server:"$GIT_SHA"
kubectl set image deployments/client-deployment client=mjhatamy/multi-client:"$GIT_SHA"
kubectl set image deployments/worker-deployment worker=mjhatamy/multi-worker:"$GIT_SHA"
