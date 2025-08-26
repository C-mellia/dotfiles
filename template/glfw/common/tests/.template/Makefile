MAKEFLAGS += --no-print-directory

SRC_EXT := c
SRC_DIR := src
OBJ_DIR := target
INCLUDE_DIR := include

LIB_NAME ?= foo
TARGET ?= main
CC ?= gcc
LD ?= gcc

CC_FLAG ?= -Werror -Wall -Wextra\
					 -std=gnu23\
					 -I$(INCLUDE_DIR) -I$(HOME)/.local/include\
					 -I../.test_header
LD_FLAG ?= -L$(HOME)/.local/lib\
					 -l$(LIB_NAME)

SRCS := $(wildcard $(SRC_DIR)/*.$(SRC_EXT))
OBJS := $(SRCS:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/%.o)

all: $(TARGET)

clean:
	-rm -r $(OBJ_DIR)
	-rm $(TARGET)

run: $(TARGET)
	./$(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LD_FLAG)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT) | $(OBJ_DIR)
	$(CC) -c $< -o $@ $(CC_FLAG)

$(OBJ_DIR):
	mkdir -p $@

.PHONY: all clean run
