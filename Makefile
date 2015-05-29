#
# Build & deploy sh-home project.
#

# TODO Check if base dir is target dir. Fail if that is the case.
BASE_DIR=$(PWD)
TARGET_DIR=$(HOME)

SOURCES=bin bin/ffpog bin/notepad++ .bash_custom .bash_misc .gitconfig .emacs \
	.git_commit_template .gitignore_global .tmux.conf

SOURCES+=.bash_conf.d $(shell find -P .bash_conf.d  \
                 -type f -iname '[[:digit:]]*' ! -iname '*~' \
				 2>/dev/null | sort -n 2>/dev/null)

SOURCES+=.emacs.d \
	.emacs.d/elisp \
	.emacs.d/elisp/google-c-style.el

TARGET_SOURCES=$(foreach file,$(SOURCES),$(TARGET_DIR)/$(file))

# Whether to skip uninstalling directories or not.
SKIP_UNINSTALL_DIRS=yes

# Following block of variables relates to including a snippet of code that will
# essentially enable/disable the helper scripts.
SHELL_STARTUP_FILE=.profile
SHELL_STARTUP_FILE_TARGET=$(TARGET_DIR)/$(SHELL_STARTUP_FILE)
ENABLED_MESSAGE=Shell scripts enabled.
DISABLED_MESSAGE=Shell scripts disabled.
START_HEADER := \# DO NOT MODIFY BELOW THIS LINE
END_FOOTER := \# DO NOT MODIFY ABOVE THIS LINE
IS_ENABLED=sed --posix -n '/'"$(START_HEADER)"'/,/'"$(END_FOOTER)"'/ c\x' "$(SHELL_STARTUP_FILE_TARGET)"
ENABLE= \
	cp "$(SHELL_STARTUP_FILE_TARGET)" "$(SHELL_STARTUP_FILE_TARGET).back"; \
	echo "$(START_HEADER)" >> "$(SHELL_STARTUP_FILE_TARGET)"; \
	cat "$(SHELL_STARTUP_FILE)" >> "$(SHELL_STARTUP_FILE_TARGET)"; \
	echo "$(END_FOOTER)" >> "$(SHELL_STARTUP_FILE_TARGET)"
DISABLE=sed --posix -i '/'"$(START_HEADER)"'/,/'"$(END_FOOTER)"'/ d' "$(SHELL_STARTUP_FILE_TARGET)"

# NOTE Introduced with version 3.82. Older distros won't support one shell.
# Having this special target defined anywhere in the makefile
# sets all targets' recipes to be executed in one shell.
# Scripts no longer need to be one line.
#.ONESHELL:
# The above's downside is only the last command's exit status will
# be captured. With an "-e" flag, the shell should exit if any untested
# command returns non 0. `man sh` for more details on the this flag.
# Also, make sure "-c" is in there (this is the default flag).
.SHELLFLAGS=-e -c

.DEFAULT_GOAL=all

.PHONY: all clean uninstall enable

$(TARGET_DIR)/%: %
	@if [ -d "$<" ]; then \
		if [ ! -d "$@" ]; then \
			echo mkdir "$@"; \
			mkdir "$@"; \
		else \
			echo touch "$@"; \
			touch "$@"; \
		fi; \
	else \
		echo cp -f "$<" "$@"; \
		cp -f "$<" "$@"; \
	fi

all:
	@echo 'Nothing to make...'

clean:
	@echo 'Nothing to clean...'

enable:
	@if [ ! -f "$(SHELL_STARTUP_FILE_TARGET)" ]; then \
		echo "Shell startup file not found: $(SHELL_STARTUP_FILE_TARGET)"; \
		exit 1; \
	fi; \
	if [ ! -z "$$($(IS_ENABLED))" ]; then \
		echo "$(ENABLED_MESSAGE)"; \
		exit 0; \
	fi; \
	echo -n "Startup snippet not found... "; \
	$(ENABLE); \
	echo "$(ENABLED_MESSAGE)"

disable:
	@if [ ! -f "$(SHELL_STARTUP_FILE_TARGET)" ]; then \
		echo "Shell startup file not found: $(SHELL_STARTUP_FILE_TARGET)"; \
		exit 1; \
	fi; \
	if [ -z "$$($(IS_ENABLED))" ]; then \
		echo "$(DISABLED_MESSAGE)"; \
		exit 0; \
	fi; \
	echo -n "Startup snippet found... "; \
	$(DISABLE); \
	echo "$(DISABLED_MESSAGE)"

install: $(TARGET_SOURCES)

uninstall:
	@if [ "no" != "$(SKIP_UNINSTALL_DIRS)" ]; then \
		echo 'skipping directories'; \
	fi; \
	for file in $(TARGET_SOURCES); do \
		if [ ! -d $$file ]; then \
			echo rm -f $$file; \
			rm -f $$file; \
		else \
			if [ "no" = "$(SKIP_UNINSTALL_DIRS)" ]; then \
				echo rm -Rf $$file; \
				rm -Rf $$file; \
			else \
				echo "skip $$file"; \
			fi; \
		fi; \
	done
