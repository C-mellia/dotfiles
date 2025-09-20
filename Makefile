COPY := .config/nvim\
				.config/i3\
				.config/polybar\
				.config/picom.conf\
				.config/hypr\
				.config/alacritty\
				.zshrc\
				.vimrc\
				.wezterm.lua\
				.tmux.conf\
				.xprofile\

LINK := .config/dunst\
				.config/starship.toml\
				.config/dunst\

TARGET := $(HOME)
SOURCE := $(HOME)/dotfiles

COPY_TARGET := $(addprefix $(TARGET)/,$(COPY))
LINK_TARGET := $(addprefix $(TARGET)/,$(LINK))

all: $(LINK_TARGET) $(COPY_TARGET)

$(TARGET)/%: $(SOURCE)/% | $(TARGET)
	@echo "Linking $@ -> $<"
	@-ln -s $< $@

$(COPY_TARGET): $(TARGET)/%: $(SOURCE)/% | $(TARGET)
	@echo "Copying $< -> $@"
	@cp -rf --update $< $@

$(TARGET):
	-mkdir -p $@

.PHONY: all
