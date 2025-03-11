SHELL := bash

LIB_NAME := foo
TARGET := lib$(LIB_NAME).so
SRC_EXT := c
PREFIX := $(if $(INSTALL_PREFIX),$(INSTALL_PREFIX),$(HOME)/.local)

SRC_DIR := ./src
OBJ_DIR := ./target
INCLUDE_DIR := ./include
INSTALL_BIN := $(PREFIX)/bin
INSTALL_HEADER := $(PREFIX)/include

CC := gcc
CC_FLAG := -Werror -Wall -Wextra\
		   -std=gnu23\
		   -I$(INCLUDE_DIR) -I$(HOME)/.local/include
LD_FLAG := --shared

SRCS := $(wildcard $(SRC_DIR)/*.$(SRC_EXT))
OBJS := $(SRCS:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/%.o)
HEADERS := $(wildcard $(INCLUDE_DIR)/*)
INSTALL_HEADERS := $(HEADERS:$(INCLUDE_DIR)/%=$(INSTALL_HEADER)/%)

all: $(TARGET)

clean:
	[[ -z $(OBJ_DIR) ]] || rm -rf $(OBJ_DIR)
	[[ -z $(TARGET) ]] || rm -rf $(TARGET)
	cd tests && ./unit_tests.sh clean

test: $(TARGET)
	cd tests && ./unit_tests.sh

install: $(INSTALL_BIN)/$(TARGET) $(INSTALL_HEADERS)

help:
	@echo "recipes:"
	@echo "\thelp: show this message"
	@echo "\tall: compile the library"
	@echo "\tclean: remove build target files and target files of the each test cases under the tests directory"
	@echo "\tinstall: install target file and headers to your system"
	@echo "\ttest: run test cases under the tests directory"

$(OBJ_DIR) $(INSTALL_BIN) $(INSTALL_HEADER):
	mkdir -p $@

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LD_FLAG)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT) | $(OBJ_DIR)
	$(CC) -c $< -o $@ $(CC_FLAG)

$(INSTALL_BIN)/$(TARGET): $(TARGET) $(INSTALL_BIN)
	install -m 755 $(TARGET) $@

$(INSTALL_HEADER)/%: $(INCLUDE_DIR)/% | $(INSTALL_HEADER)
	cp -r $< $@

_lib_name:
	@echo $(LIB_NAME)

.PHONY: all clean test install help _lib_name
