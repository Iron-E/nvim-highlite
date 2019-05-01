
ERB_SOURCES = $(wildcard colors/*.erb)
VIM_OUTPUTS = $(ERB_SOURCES:%.erb=%.vim)

.PHONY: all

all: $(VIM_OUTPUTS)

%.vim: %.erb
	erb -T - $< > $@
