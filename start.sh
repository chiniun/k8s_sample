#!/bin/bash

# 第一步是安装minikube
brew install minikube && minikube start
# 第二步是编译golang镜像(酌情考虑是否需要上传到hub,镜像以及标签名自定义)
docker build . -t chiniun/xx-xx-xx:v1 
# 第三步是功能实例部署,此时已经能通过endpointsIp + 端口访问了
kubectl apply -f 1_deploy.yml 
# 第四步是部署功能实例对应的服务发现, 部署完成后可以通过 kubectl describe service xx-xx-xx 解析到上面的endpoints_ip
kubectl apply -f 1_service.yml 
# 第五步是部署ingressController (也就是nginx实例) 
kubectl apply -f 2_nginx_ingress_controller.yaml
# 第六步是部署ingress (nginx实例对应的路由规则),如果一直失败,建议等待10分钟,上面第五步部署成功后再部署,此时通过minikubeip + 80端口已经能正常访问到服务了
kubectl apply -f 2_ingress.yaml