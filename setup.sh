echo "Configurando ambiente"

echo "Criando imagens docker para todos os conteineres"
sudo docker build -t propensitymodelapi -f propensity-model/dockerbuilds/Dockerfile propensity-model/docker/
# sudo docker build -t customerclusteringapi -f part_2/dockerbuilds/Dockerfile part_2/docker/
sudo docker build -t modelmanager -f model-manager/dockerbuilds/Dockerfile model-manager/docker/
# sudo docker build -t frontendstreamlit -f part_4/dockerbuilds/Dockerfile part_4/docker/

echo "Criando rede"
docker network create plat_network

echo "Fazendo deploy de containeres para inferencia"
sudo docker run -d --restart always --network plat_network --name propensityapi propensityapi
# docker run -d --restart always --network plat_network --name clusteringapi clusteringapi

echo "Atualizando microservices.json para expor APIs de inferencia"
sudo bash ./model-manager/update_config.sh

echo "Configuracao model manager"
sudo docker run -d --restart always --network plat_network -v $(pwd)/model-manager/docker/config:/myServer/config -v $(pwd)/model-manager/docker/log:/myServer/log --name modelmanager modelmanager

# echo "Atualizando microservices.json for access API from Frontend"
# bash ./part_4/update_config.sh

# echo "Config FrontEnd"
# docker run -d --restart always --network plat_network -p 80:8501 -v $(pwd)/part_4/docker/config:/myServer/config --name frontendstreamlit frontendstreamlit