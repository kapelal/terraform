TERRAFORM_IMAGE ?= hashicorp/terraform:0.11.3

ifndef CREDENTIALS
	CREDENTIALS = /home/rdesousa/.config/gcloud/kapelal.json
endif

VAR_FILE_OPTIONS       = -var-file vars.tfvars
BACKEND_CONFIG_OPTIONS = -backend-config config.backend

DOCKER_RUN = docker run
DOCKER_RUN += --rm
DOCKER_RUN += -u $$(id -u):$$(id -g)
DOCKER_RUN += -v $(CURDIR):/repo
DOCKER_RUN += -v $(CREDENTIALS):/etc/credentials.json
DOCKER_RUN += -w /repo
DOCKER_RUN += -e GOOGLE_APPLICATION_CREDENTIALS=/etc/credentials.json

TERRAFORM = @
TERRAFORM += $(DOCKER_RUN)
TERRAFORM += $(TERRAFORM_IMAGE)

default: plan

.PHONY: init
init: clean
	$(TERRAFORM) init $(BACKEND_CONFIG_OPTIONS)

.PHONY: check-init
check-init:
	@[ -d .terraform ] || make init

.PHONY: plan
plan: check-init
	$(TERRAFORM) plan $(VAR_FILE_OPTIONS)

.PHONY: plan-destroy
plan-destroy: check-init
	$(TERRAFORM) plan -destroy $(VAR_FILE_OPTIONS)

.PHONY: apply
apply: check-init
	$(TERRAFORM) apply -auto-approve $(VAR_FILE_OPTIONS)

.PHONY: validate
validate: check-init
	$(TERRAFORM) validate $(VAR_FILE_OPTIONS)

.PHONY: destroy
destroy: check-init
	$(TERRAFORM) destroy $(VAR_FILE_OPTIONS) -force

.PHONY: refresh
refresh: check-init
	$(TERRAFORM) refresh $(VAR_FILE_OPTIONS)

.PHONY: output
output: check-init
	$(TERRAFORM) output $(OUTPUTS)

.PHONY: clean
clean:
	@rm -rf .terraform
