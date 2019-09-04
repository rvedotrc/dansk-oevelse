TARGETS=etc/verber.json

default: build check

clean:
	rm -f $(TARGETS)

check:
	./dump | jq .fejl[]
	./dump | jq '.verber[] | select(.["antal_dårlige"] > 0)'

build: $(TARGETS)

etc/verber.json: etc/verber.txt
	./dump > etc/verber.json

# vi: set noet ft=Makefile :
