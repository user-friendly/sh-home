# Custom shell commands to be appended to the user's .profile file.

# Should be included by most of the currently popular distros.
# Set PATH so it includes user's private bin if it exists.
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi

if [ -n "$BASH_VERSION" ] && [ ! -z "$PS1" ] && [ -f "$HOME/.bash_custom" ]; then
    . "$HOME/.bash_custom"
fi
