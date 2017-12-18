SHELL := /bin/bash

.PHONY: help install show run test docker

help: ## This help message
	@echo "usage: make [target]"
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m: \2/')"

install: ## Install gems
	@exec bundle install

show: ## Execute 'show' command
	@exec bin/app show

run: ## Execute 'run' command
	@exec bin/app run

test: ## Run tests
	@exec rspec spec

docker: ## Start a docker container
	@exec docker-compose run --rm --name trafikverket app
