# PYTHON
PYTHON_INTERPRETER ?= python3
PIP ?= pip3
VIRTUAL_ENV_FOLDER ?= venv
ACTIVATE =. ./$(VIRTUAL_ENV_FOLDER)/bin/activate

### VENV ###
# Run all make commands in a single subshell, see: https://stackoverflow.com/questions/24736146/how-to-use-virtualenv-in-makefile/24736236
.ONESHELL:

# Target to create virtual env.
venv:
	@$(PYTHON_INTERPRETER) -m venv ./$(VIRTUAL_ENV_FOLDER)

# Install all development dependencies
.PHONY: install
install: venv
	@$(ACTIVATE); $(PYTHON_INTERPRETER) -m pip install --upgrade pip; $(PIP) install -r requirements.txt

### Experiments ###
run-basic:
	@$(ACTIVATE); chaos run experiments/pod-down-experiment.json

run-node-maintenance:
	@$(ACTIVATE); chaos run experiments/node-maintenance-experiment.json

### Infra ###

.PHONY: cluster
cluster:
	kind create cluster --config kind.yaml --image kindest/node:v1.21.12 --name chaos-experiments

.PHONY: clean
clean:
	kind delete cluster --name chaos-experiments

.PHONY: load-image
load-image:
	@docker build -t basic:0.0.1 .
	@kind load docker-image basic:0.0.1 --name chaos-experiments

.PHONY: deploy-basic
deploy-basic:
	@kubectl apply -f sample-applications/basic/infra/basic_with_issue.yaml


.PHONY: deploy-basic-fix
deploy-basic-fix:
	@kubectl apply -f sample-applications/basic/infra/basic_with_fix.yaml

.PHONY: deploy-nginx
deploy-nginx:
	@kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

.PHONY: infra
infra: cluster load-image deploy-nginx deploy-basic 
