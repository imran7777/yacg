#!/bin/bash

scriptPos=${0%/*}

# script takes the yacg models and generate the program code
# based on them

pushd $scriptPos/.. > /dev/null

echo "create meta model classes ..."
if ! pipenv run python3 yacg.py --models \
    resources/models/json/yacg_model_schema.json \
    --output ${scriptPos}/../yacg/model/model.py \
             ${scriptPos}/../tests/model/test_model.py \
             ${scriptPos}/../docs/puml/yacg_model.puml \
    --templates pythonBeans \
                pythonBeansTests \
                plantUml \
    --templateParameters modelPackage=yacg.model.model \
                         title="yacg model"; then
    echo "    ERROR while create meta model classes"
    exit 1
fi

echo "create config model classes ..."
if ! pipenv run python3 yacg.py --models \
    resources/models/json/yacg_config_schema.json \
    --output ${scriptPos}/../yacg/model/config.py \
             ${scriptPos}/../tests/model/test_config.py \
             ${scriptPos}/../docs/puml/yacg_config_schema.puml \
    --templates pythonBeans \
                pythonBeansTests \
                plantUml \
    --templateParameters modelPackage=yacg.model.config \
                         title="yacg configuration model"; then
    echo "    ERROR while create config model classes"
    exit 1
fi

echo "create openapi model classes ..."
if ! pipenv run python3 yacg.py --models \
    resources/models/json/yacg_openapi_paths.json \
    --output ${scriptPos}/../yacg/model/openapi.py \
             ${scriptPos}/../tests/model/test_openapi.py \
             ${scriptPos}/../docs/puml/yacg_openapi.puml \
    --templates pythonBeans \
                pythonBeansTests \
                plantUml \
    --templateParameters modelPackage=yacg.model.openapi \
                         title="yacg openapi model"; then
    echo "    ERROR while create openapi model classes"
    exit 1
fi

popd > /dev/null