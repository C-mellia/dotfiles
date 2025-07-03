SHELL := bash

OBJ_DIR ?= ./target
PREFIX ?= $(HOME)/.local

LIB_NAME := common
SRC_EXT := c
HEADER_EXT := h
SRC_DIR := src
INCLUDE_DIR := include
INSTALL_LIB := $(PREFIX)/lib
INSTALL_INCLUDE := $(PREFIX)/include

TEST_TARGET=main
TARGET := lib$(LIB_NAME).so
CC := gcc
LD := gcc
TEST_CC := $(CC)
TEST_LD := $(LD)

TEST_ARGS := CC=$(TEST_CC) LD=$(TEST_LD)\
						 LD_LIBRARY_PATH=$(PWD):${LD_LIBRARY_PATH}\
						 LIBRARY_PATH=$(PWD):${LIBRARY_PATH}\
						 C_INCLUDE_PATH=$(PWD)/$(INCLUDE_DIR):${C_INCLUDE_PATH}\
						 LIB_NAME=$(LIB_NAME)\
						 TARGET=$(TEST_TARGET)\
						 SHELL=$(SHELL)\

CC_FLAG ?= -Werror -Wall -Wextra\
					 -std=gnu23\
					 -I$(INCLUDE_DIR) -I$(HOME)/.local/include\
					 -Ivendor\
					 -fPIC
LD_FLAG ?= --shared\
					 -L$(HOME)/.local/lib

SRCS := $(wildcard $(SRC_DIR)/*.$(SRC_EXT))
HEADERS := $(wildcard $(INCLUDE_DIR)/$(LIB_NAME)/*)

OBJS := $(SRCS:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/%.o)
INSTALL_HEADERS := $(HEADERS:$(INCLUDE_DIR)/$(LIB_NAME)/%.$(HEADER_EXT)=$(INSTALL_INCLUDE)/$(LIB_NAME)/%.$(HEADER_EXT))

all: $(TARGET)

clean:
	-rm -r $(OBJ_DIR)
	-rm $(TARGET)
	@$(TEST_ARGS) sh -c 'cd tests && ./unit_tests.sh clean'

test: $(TARGET)
	@$(TEST_ARGS) sh -c 'cd tests && ./unit_tests.sh'

install: $(INSTALL_LIB)/$(TARGET) $(INSTALL_HEADERS)

help:
	@echo "recipes:"
	@echo "\thelp: show this message"
	@echo "\tall: compile the library"
	@echo "\tclean: remove build target files and target files of the each test cases under the tests directory"
	@echo "\tinstall: install target file and headers to your system"
	@echo "\ttest: run test cases under the tests directory"

$(OBJ_DIR) $(INSTALL_LIB) $(INSTALL_INCLUDE)/$(LIB_NAME):
	mkdir -p $@

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LD_FLAG)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT) | $(OBJ_DIR)
	$(CC) -c $< -o $@ $(CC_FLAG)

$(INSTALL_LIB)/$(TARGET): $(TARGET) $(INSTALL_LIB)
	install -m 755 $(TARGET) $@

$(INSTALL_INCLUDE)/$(LIB_NAME)/%.$(HEADER_EXT): $(INCLUDE_DIR)/$(LIB_NAME)/%.$(HEADER_EXT) | $(INSTALL_INCLUDE)/$(LIB_NAME)
	install -m 644 $< $@

_lib_name:
	@echo $(LIB_NAME)

.PHONY: all clean test install help _lib_name
