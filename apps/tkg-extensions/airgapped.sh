#!/bin/bash

export HARBOR_INTERNAL="harbor.dorn.gorke.ml"

export CM_1="projects.registry.vmware.com/tkg/cert-manager/cert-manager-cainjector:v0.16.1_vmware.1"
export CM_2="projects.registry.vmware.com/tkg/cert-manager/cert-manager-controller:v0.16.1_vmware.1"
export CM_3="projects.registry.vmware.com/tkg/cert-manager/cert-manager-webhook:v0.16.1_vmware.1"

export CM_1_INTERNAL="${HARBOR_INTERNAL}/tkg/cert-manager/cert-manager-cainjector:v0.16.1_vmware.1"
export CM_2_INTERNAL="${HARBOR_INTERNAL}/tkg/cert-manager/cert-manager-controller:v0.16.1_vmware.1"
export CM_3_INTERNAL="${HARBOR_INTERNAL}/tkg/cert-manager/cert-manager-webhook:v0.16.1_vmware.1"

docker pull $CM_1
docker tag $CM_1 $CM_1_INTERNAL
docker push $CM_1_INTERNAL
docker pull $CM_2
docker tag $CM_2 $CM_2_INTERNAL
docker push $CM_2_INTERNAL
docker pull $CM_3
docker tag $CM_3 $CM_3_INTERNAL
docker push $CM_3_INTERNAL

# cert-manager
sed -i -e "s~$CM_1~$CM_1_INTERNAL~g" ./01-cert-manager/03-cert-manager.yaml
sed -i -e "s~$CM_2~$CM_2_INTERNAL~g" ./01-cert-manager/03-cert-manager.yaml
sed -i -e "s~$CM_3~$CM_3_INTERNAL~g" ./01-cert-manager/03-cert-manager.yaml

#kubectl apply -f ./01-cert-manager/