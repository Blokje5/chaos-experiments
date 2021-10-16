# PYTHON
PYTHON_INTERPRETER ?= python3
PIP ?= pip3
VIRTUAL_ENV_FOLDER ?= venv
ACTIVATE =. ./$(VIRTUAL_ENV_FOLDER)/bin/activate

# Run all make commands in a single subshell, see: https://stackoverflow.com/questions/24736146/how-to-use-virtualenv-in-makefile/24736236
.ONESHELL:

# Target to create virtual env.
venv:
	@$(PYTHON_INTERPRETER) -m venv ./$(VIRTUAL_ENV_FOLDER)

# Install all development dependencies
.PHONY: install
install: venv
	@$(ACTIVATE); $(PYTHON_INTERPRETER) -m pip install --upgrade pip; $(PIP) install -r requirements.txt
