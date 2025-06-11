

SERVICE_SECRET
REGISTRY_USER = dbe81550-wise-chickadee
REGISTRY_PASSWORD
REDIS_PASSWORD
KUBE_CONFIG
DB_PASSWORD


# serverpod
docker compose up -d
serverpod generate --experimental-features=all
dart bin/main.dart --apply-migrations
serverpod create-migration --experimental-features=all --force


docker compose down -v

#kubernaties

[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('пароль'))

# Проверим поды
kubectl get pods
kubectl get pods -w

# Проверим сервисы
kubectl get svc
kubectl get svc ts4-server-service -o yaml 

# логи приложения
kubectl logs -f -l app=ts4-server

#kubectl logs serverpod-migration-job-ts3-6llg9

# Тестируем endpoint для получения списка TestData
Invoke-WebRequest -Uri "https://api5.my-points.ru/" -Method POST -ContentType "application/json" -Body '{"endpoint":"testData","method":"listTestDatas","params":{}}'

# Проверка доступности напрямую
Invoke-WebRequest -Uri "https://api5.my-points.ru/" -Method GET

# Проверим детали Ingress:
bashkubectl describe ingress sync2-server-ingress

docker login dbe81550-wise-chickadee.registry.twcstorage.ru
docker build -t dbe81550-wise-chickadee.registry.twcstorage.ru/ts4-server:latest -f Dockerfile.prod .
docker push dbe81550-wise-chickadee.registry.twcstorage.ru/ts4-server:latest

kubectl apply -f k8s/

kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/job.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/secret.yaml


#delete project
kubectl delete -f k8s/

kubectl delete service ts4-server-service
kubectl delete ingress ts4-server-ingress
kubectl delete configmap serverpod-config-ts4
kubectl delete job serverpod-migration-job-ts4
kubectl delete secret serverpod-secrets-ts4
kubectl delete deployment ts4-server-deployment

#restart deployment
kubectl rollout restart deployment ts4-server-deployment

kubectl create secret generic serverpod-secrets-ts4 --from-literal=database-password='ejx5-dGt-luSPI' --from-literal=redis-password='-$D%6g5==Z64y&' --from-literal=service-secret='rHrlyc4qbDq9PPdnXcauTlqGvyrD0BAS'


kubectl create secret docker-registry timeweb-registry-secret --docker-server=dbe81550-wise-chickadee.registry.twcstorage.ru --docker-username=dbe81550-wise-chickadee --docker-password=eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IjFrYnhacFJNQGJSI0tSbE1xS1lqIn0.eyJ1c2VyIjoiY2M1MDYyNSIsInR5cGUiOiJhcGlfa2V5IiwiYXBpX2tleV9pZCI6IjJiMWUyZmZjLTQzNDctNDhjZS1iOTc1LWE2MmMxNzc2Y2UyZSIsImlhdCI6MTc0OTQ1MTY4MH0.cihZsBq3N8UO3P0nHzEW5i2plEZpL4BqchKfaOgmTN53y3CgROFgYE-AUDFztbTK2M2yd1Zs7DkoNLRKCSJmm5bXkmr5ie8LaAzpx5IrT_uhZApHDIfpyh6xU0oGF6At48zAmzT-CWsQWxYgSVH4hYdM-A_Pqu9HJrXmWfUkYPVhhP-4Xh47Y2FPdzLbMNPGrFRe_T6kn8cdg4JJ9kjDMyNXGOTRXctlQqiNcIoj_X2uDV3GoXFsVIaZLI1JFvyvhXXcOr0IAOf2PMwb_6_kCQF_juuQInTy84wr0Nop9k6p5wHJ96eqacWFskU5_4YAW0MUBPQsLTTusow_YYdrSu8UVMX4ubw1UvNMIyOzN8-nB-95nMqR7aHIFDWAiRILaQ5KVDG2yYMi2wUHI5Ic8Iz2e1TrUUC5VsCWcxB2tGQAHMpoR5vIWkEjbx4ptewZv9HXbTW0EHu9rGX2BFKbEf_5clOsDO4EfG1G5LEv6CKnE1-Nh3lD7swyEIAQZHou