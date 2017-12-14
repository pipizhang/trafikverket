.PHONY: install show run

install:
	@bundle install

show:
	@exec bin/app show

run:
	@exec bin/app run
