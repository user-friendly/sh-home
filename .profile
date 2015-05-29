# Custom shell commands to be appended to the user's .profile file.
# Cygwin seems to not be executing .profile upon starting the regular
# console program, but .bashrc only. Perhaps for a good reason...
# To enable/disable shell helper scripts invoke make enable/disable
# overwriting the variable SHELL_STARTUP_FILE_TARGET, like this:
# #> make SHELL_STARTUP_FILE_TARGET='.bashrc' enable/disable

# Should be included by most of the currently popular distros.
# Set PATH so it includes user's private bin if it exists.
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi

if [ -n "$BASH_VERSION" ] && [ ! -z "$PS1" ] && [ -f "$HOME/.bash_custom" ]; then
    . "$HOME/.bash_custom"
fi
