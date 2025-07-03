SHELL := bash

TARGET := main
SRC_EXT := c

SRC_DIR := ./src
OBJ_DIR := ./target
INCLUDE_DIR := ./include

VENDORS := hotint common

PREFIX := $(if $(INSTALL_PREFIX),$(INSTALL_PREFIX),$(HOME)/.local)

CC := gcc
LD := gcc
CC_FLAG ?= -Werror -Wall -Wextra\
					 -std=gnu23\
					 -fPIC\
					 -I$(INCLUDE_DIR) -I$(HOME)/.local/include\
					 -Icommon/include -Ihotint/include

LD_FLAG ?= -L$(HOME)/.local/lib -Lcommon\
					 -lGL -lglad -lglfw -lm -llinalg -larray -lcommon

SRCS := $(wildcard $(SRC_DIR)/*.$(SRC_EXT))
OBJS := $(SRCS:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/%.o)

INSTALL_BIN := $(PREFIX)/bin

all: $(VENDORS) $(TARGET)

clean:
	-rm -rf $(OBJ_DIR)
	-rm -rf $(TARGET)
	-$(MAKE) -C hotint clean
	-$(MAKE) -C common clean

run: $(VENDORS) $(TARGET)
	sh -c ./$(TARGET) $(if $(ARGS),+o,) $(ARGS)

install: $(INSTALL_BIN)/$(TARGET)

test:
	@echo $(VENDORS)

$(VENDORS):
	$(MAKE) -C $@

$(TARGET): $(OBJS)
	$(LD) -o $@ $^ $(LD_FLAG)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT) | $(OBJ_DIR)
	$(CC) -c $< -o $@ $(CC_FLAG)

$(OBJ_DIR) $(INSTALL_BIN):
	mkdir -p $@

$(INSTALL_BIN)/$(TARGET): $(TARGET) $(INSTALL_BIN)
	install -m 755 $(TARGET) $(INSTALL_BIN)/

.PHONY: all clean run install $(VENDORS)
