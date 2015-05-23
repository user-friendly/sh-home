#
# Build & deploy sh-home project.
#

.DEFAULT_GOAL=all

.PHONY: all clean uninstall enable

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
SKIP_UNINSTALL_DIRS=

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


all:
	@echo 'Nothing to make...'

clean:
	@echo 'Nothing to clean...'

# Append the contents of the following file to the user's .profile file.
# @todo Find a better way of dealing with the enabling shell code snippet.
SHELL_STARTUP_FILE=.profile
SHELL_STARTUP_FILE_TARGET=$(TARGET_DIR)/$(SHELL_STARTUP_FILE)
TEMP_SHELL_STARTUP_FILE=/tmp/$(SHELL_STARTUP_FILE)
TEMP_SHELL_STARTUP_FILE_APPEND=/tmp/$(SHELL_STARTUP_FILE).append

enable:
	@if [ -f "$(SHELL_STARTUP_FILE_TARGET)" ]; then \
		tr '\n' ' ' < $(SHELL_STARTUP_FILE_TARGET) > $(TEMP_SHELL_STARTUP_FILE); \
		tr '\n' ' ' < $(SHELL_STARTUP_FILE) > $(TEMP_SHELL_STARTUP_FILE_APPEND); \
		DIFF="$$(grep -F -f $(TEMP_SHELL_STARTUP_FILE_APPEND) $(TEMP_SHELL_STARTUP_FILE))"; \
		if [ -z "$$DIFF" ]; then \
			echo -n "Not found in shell startup file... "; \
			if [ ! -f "$(SHELL_STARTUP_FILE_TARGET).back" ]; then \
				cp "$(SHELL_STARTUP_FILE_TARGET)" "$(SHELL_STARTUP_FILE_TARGET).back"; \
			fi; \
			cat $(SHELL_STARTUP_FILE) >> "$(SHELL_STARTUP_FILE_TARGET)"; \
		fi; \
		echo "Shell scripts enabled."; \
		rm -f $(TEMP_SHELL_STARTUP_FILE); \
		rm -f $(TEMP_SHELL_STARTUP_FILE_APPEND); \
	else \
		echo "File $(SHELL_STARTUP_FILE_TARGET) not found - skip enabling scripts."; \
	fi;

# @todo Implement "disable" target.
# Would need to remote the shell code snippet.

install: $(TARGET_SOURCES)

uninstall:
	@if [ "no" != "$(SKIP_UNINSTALL_DIRS)" ]; then \
		echo 'skipping directories'; \
	fi
	@for file in $(TARGET_SOURCES); do \
		if [ ! -d $$file ]; then \
			echo rm -f $$file; \
			rm -f $$file; \
		else \
			if [ "no" = "$(SKIP_UNINSTALL_DIRS)" ]; then \
				echo rm -Rf $$file; \
				rm -Rf $$file; \
			else \
				echo "skip $$file"; \
			fi \
		fi \
	done
