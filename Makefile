#
# Build & deploy sh-home project.
#

.DEFAULT_GOAL=all

# TODO Check if base dir is target dir. Fail if that is the case.
BASE_DIR=$(PWD)
TARGET_DIR=$(HOME)

SOURCES=bin bin/ffpog bin/notepad++ .bash_custom .bash_misc .gitconfig .emacs \
	.git_commit_template .gitignore_global .tmux.conf

SOURCES+=.bash_conf.d $(shell find -P .bash_conf.d  \
                 -type f -iname '[[:digit:]]*' ! -iname '*~' \
				 2>/dev/null | sort -n 2>/dev/null)
TARGET_SOURCES=$(foreach file,$(SOURCES),$(TARGET_DIR)/$(file))

SKIP_CLEAN_DIRS=

include Makefile.*.conf

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
	@if [ "no" != "$(SKIP_CLEAN_DIRS)" ]; then \
		echo 'skipping directories'; \
	fi
	@for file in $(TARGET_SOURCES); do \
		if [ ! -d $$file ]; then \
			echo rm -f $$file; \
			rm -f $$file; \
		else \
			if [ "no" = "$(SKIP_CLEAN_DIRS)" ]; then \
				echo rm -Rf $$file; \
				rm -Rf $$file; \
			else \
				echo "skip $$file"; \
			fi \
		fi \
	done
