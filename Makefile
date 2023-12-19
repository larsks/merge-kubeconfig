# via https://stackoverflow.com/a/1542661/147356
classpathify = $(subst $(eval ) ,:,$(wildcard $1))

CONFIGS=$(wildcard configs/*)
CONFIGS_MERGED=$(call classpathify,$(CONFIGS))
CONTEXT=$(shell kubectl config current-context 2> /dev/null)

config: configs $(CONFIGS)
	KUBECONFIG="$(CONFIGS_MERGED)" kubectl --context "$(CONTEXT)" config view --flatten > $@ || { rm -f $@; exit 1; }

clean:
	rm -f config
