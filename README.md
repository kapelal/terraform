# Terraform

Inventaire (chaque composant GCP est dans un répertoire) de tous les scripts terraform du projet kapelal sous GCP

## Exécution

[terraform.mk](./terraform.mk) liste toutes les commandes terraform possible de faire

Chaque répertoire à un Makefile qui include [terraform.mk](./terraform.mk) et si besoin, override certaines variable env

## Variable d'env

`TERRAFORM_IMAGE`: l'image docker qui utilisé pour éxécuter les scripts terraform

`CREDENTIALS`: chemin du service account GCP

`VAR_FILE_OPTIONS`: option pour les .tfvars

`BACKEND_CONFIG_OPTIONS` = option pour les fichiers .backend

`DOCKER_RUN_OPTION`: option docker

`TERRAFORM`: commande terraform
