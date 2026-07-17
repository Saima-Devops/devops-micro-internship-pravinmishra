#!/bin/bash

tools=("Git" "Docker" "Jenkins" "Kubernetes" "Terraform")

echo "DevOps Tools Checklist"

for tool in "${tools[@]}"
do
    echo "- $tool"
done
