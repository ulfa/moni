PROJECT = moni
DIALYZER = dialyzer
REBAR = rebar
TAR = tar
CD = cd
REPO = ../../../../repository
REPOSRC = ../../repository

all: app

tar: app 
	$(CD) rel; tar cvf $(REPO)/$(PROJECT).$(VERSION).tar $(PROJECT)

tarall: app 
	$(CD) ..; $(TAR) cvf $(REPOSRC)/$(PROJECT).src.$(VERSION).tar $(PROJECT) --exclude .git/* --exclude log/*

cpall: tarall
	$(CD) ..;scp $(REPOSRC)/$(PROJECT).src.$(VERSION).tar $(USR)@$(HOST):~/projects/erlang

cp: tar
	@$(CD) ..;scp $(REPOSRC)/$(PROJECT).$(VERSION).tar $(USR)@$(HOST):~/projects/erlang

release: app
	@$(REBAR) generate

app: deps
	@$(REBAR) compile

deps:
	@$(REBAR) get-deps

clean:
	@$(REBAR) clean
	rm -f test/*.beam
	rm -f erl_crash.dump
	rm -f log/*

tests: clean app eunit ct

eunit:
	@$(REBAR) eunit skip_deps=true

ct:
	@$(REBAR) ct

build-plt:
	@$(DIALYZER) --build_plt --output_plt .ct_dialyzer.plt \
		--apps kernel stdlib sasl inets crypto public_key ssl

dialyze:
	@$(DIALYZER) --src src --plt .sue_dialyzer.plt \
		-Wbehaviours -Werror_handling \
		-Wrace_conditions -Wunmatched_returns # -Wunderspecs

docs:
	@$(REBAR) doc skip_deps=true
