TARGET_DIR := target
SRC_DIR := src

TEX := xelatex
TEX_FLAG := -halt-on-error -shell-escape\
						-output-directory=$(TARGET_DIR)\
						-file-line-error

all: $(TARGET_DIR)
	$(TEX) $(TEX_FLAG) $(SRC_DIR)/body.tex
	(cd target; biber body.bcf)

$(TARGET_DIR):
	mkdir -p $@

.PHONY: all biber
