#deploy prometheus and grafana on K8s using Helm charts
#Author:Hala Mohamed Marzouk

#Run the following commands to add the Prometheus helm chart

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

#To install the Prometheus helm chart “helm install” command as below shown
helm install prometheus prometheus-community/prometheus
#run this command to show all service to expose it
kubectl get service
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-external
#prometheus-server-external>> can you use any name you wnat

#to show ip:port , use them on browser
minikube service prometheus-server-external

#------------------------------------
#install grafana
#To get the Grafana Helm chart, run this command
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install grafana grafana/grafana
kubectl get service
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-external
minikube service grafana-external
#Grafana Login page. To get the password for admin, run this command on a new terminal.
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | ForEach-Object { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }
