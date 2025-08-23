_D := $(HOME)/dotfiles
CONFIG_DIR := $(HOME)/.config

_CONFIGS := nvim picom.conf starship.toml i3 hypr\
						dunst/dunstrc zathura/zathurarc nap/config.yaml\
						.tmux.conf
CONFIGS = $(shell echo -n $(_CONFIGS) | tr [:space:] ',')
CUSTOM_CONFIGS = wezterm.lua zshrc vimrc xprofile

LINKS := $(shell echo $(CONFIG_DIR)/{$(CONFIGS)})

$(CONFIG_DIR)/%:
	-mkdir -p $(shell dirname $@) -v
	ln -s $(_D)/$(shell basename $@) -t $(shell dirname $@) -v

$(CONFIG_DIR)/nap/config.yaml:
	-mkdir -p $(shell dirname $@) -v
	ln -s $(_D)/nap.yaml $@ -v

# $(CONFIG_DIR)/*: $(shell dirname $@)
# 	ln -s $@ $(shell basename $@)

all: link copy

link: $(LINKS)

copy: $(CUSTOM_CONFIGS)

$(CUSTOM_CONFIGS):
	-mv $(HOME)/.$@ .$@.bak
	cp $(_D)/.$@ $(HOME)/.$@

.PHONY: link copy $(CUSTOM_CONFIGS)
