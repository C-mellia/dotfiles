
CONFIG_DIR := $(HOME)/.config

_CONFIGS := nvim picom.conf starship.toml i3 hypr\
						dunst/dunstrc zathura/zathurarc nap/config.yaml
CONFIGS = $(shell echo -n $(_CONFIGS) | tr [:space:] ',')

LINKS := $(shell echo $(CONFIG_DIR)/{$(CONFIGS)})

$(CONFIG_DIR)/%:
	-mkdir -p $(shell dirname $@) -v
	ln -s $(PWD)/$(shell basename $@) -t $(shell dirname $@) -v

$(CONFIG_DIR)/nap/config.yaml:
	-mkdir -p $(shell dirname $@) -v
	ln -s $(PWD)/nap.yaml $@ -v

# $(CONFIG_DIR)/*: $(shell dirname $@)
# 	ln -s $@ $(shell basename $@)

__test:
	@echo $(CONFIGS)
	@echo $(LINKS)

link: $(LINKS) wezterm

wezterm:
	rm -f $(HOME)/.wezterm.lua
	ln -s $(PWD)/wezterm.lua $(HOME)/.wezterm.lua

.PHONY: __test link wezterm
