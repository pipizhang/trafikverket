.PHONY: install show run docker

install:
	@bundle install

show:
	@exec bin/app show

run:
	@exec bin/app run

docker:
	@exec docker-compose run --rm --name trafikverket app
