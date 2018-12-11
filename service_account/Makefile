DOCKER_RUN_OPTION += -v ~/.kube/config:/.kube/config
DOCKER_RUN_OPTION += --entrypoint terraform
TERRAFORM_IMAGE ?= ngeor/helm-kubectl-terraform:2.8.2

-include ../terraform.mk
