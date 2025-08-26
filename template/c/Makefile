SHELL := bash

TARGET := main
SRC_EXT := c

SRC_DIR := ./src
OBJ_DIR := ./target
INCLUDE_DIR := ./include

PREFIX := $(if $(INSTALL_PREFIX),$(INSTALL_PREFIX),$(HOME)/.local)

CC := gcc
LD := gcc
CC_FLAG ?= -Werror -Wall -Wextra\
					 -std=gnu23\
					 -I$(INCLUDE_DIR) -I$(HOME)/.local/include
LD_FLAG ?= -L$(HOME)/.local/lib

SRCS := $(wildcard $(SRC_DIR)/*.$(SRC_EXT))
OBJS := $(SRCS:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/%.o)

INSTALL_BIN := $(PREFIX)/bin

all: $(TARGET)

clean:
	[[ -z $(OBJ_DIR) ]] || rm -rf $(OBJ_DIR)
	[[ -z $(TARGET) ]] || rm -rf $(TARGET)

run: $(TARGET)
	sh -c "./$(TARGET) $(ARGS)"

install: $(INSTALL_BIN)/$(TARGET)

$(TARGET): $(OBJS)
	$(LD) -o $@ $^ $(LD_FLAG)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT) | $(OBJ_DIR)
	$(CC) -c $< -o $@ $(CC_FLAG)

$(OBJ_DIR) $(INSTALL_BIN):
	mkdir -p $@

$(INSTALL_BIN)/$(TARGET): $(TARGET) $(INSTALL_BIN)
	install -m 755 $(TARGET) $(INSTALL_BIN)/

.PHONY: all clean install
