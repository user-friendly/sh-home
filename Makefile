# 
# Build & deploy sh-home project.
# 

.DEFAULT_GOAL=all

# TODO Check if base dir is target dir. Fail if that is the case.
BASE_DIR=$(PWD)
TARGET_DIR=$(HOME)

SOURCES=bin bin/ffpog .bash_custom .bash_misc .gitconfig .emacs \
	.git_commit_template .gitignore_global .tmux.conf

TARGET_SOURCES=$(foreach file,$(SOURCES),$(TARGET_DIR)/$(file))

$(TARGET_DIR)/%: %
	@if [ -d $< ]; then \
		if [ ! -d $@ ]; then \
			echo mkdir $@; \
			mkdir $@; \
		else \
			echo touch $@; \
			touch $@; \
		fi \
	else \
		echo cp -f $< $@; \
		cp -f $< $@; \
	fi

all: $(TARGET_SOURCES)

.PHONY: clean

clean:
	rm -Rf $(TARGET_SOURCES)
