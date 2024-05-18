
echo '{                                                     ' >  $(pwd)/model-manager/docker/config/microservices.json
echo '  "models": {                                         ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '    "propensity": {                                     ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '      "version": "V01",                               ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '      "url": "http://'$(sudo docker inspect defaultpropensityapi | python3 -c "import sys, json; print(json.load(sys.stdin)[0]['NetworkSettings']['Networks']
['plat_network']['IPAddress'])")':8080/predict"          ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '    },                                                ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '    "clustering": {                                     ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '      "version": "V01",                               ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '      "url": "http://'$(sudo docker inspect customerclusteringapi | python3 -c "import sys, json; print(json.load(sys.stdin)[0]['NetworkSettings']['Networks']
['plat_network']['IPAddress'])")':8080/predict"          ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '    }                                                 ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '  }                                                   ' >> $(pwd)/model-manager/docker/config/microservices.json
echo '}                                                     ' >> $(pwd)/model-manager/docker/config/microservices.json

echo "[PART 3] Arquivo de configuração atualizado com sucesso: "

cat $(pwd)/model-manager/docker/config/microservices.json