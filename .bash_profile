#───────────────────────────────────────────────────────────────────────────────
# Load the shell dotfiles:
#     → ~/.path can be used to extend `$PATH`
#     → ~/.extra can be used for other settings you don't want to commit
#───────────────────────────────────────────────────────────────────────────────
for file in ~/.{path,exports,aliases,functions,bash_prompt,extra}; do
	[ -r "$file" ] && . "$file"
done
unset file


#───────────────────────────────────────────────────────────────────────────────
# Case-insensitive globbing (used in pathname expansion)
#───────────────────────────────────────────────────────────────────────────────
shopt -s nocaseglob


#───────────────────────────────────────────────────────────────────────────────
# Append to the Bash history file, rather than overwriting it
#───────────────────────────────────────────────────────────────────────────────
shopt -s histappend


#───────────────────────────────────────────────────────────────────────────────
# Autocorrect typos in path names when using `cd`
#───────────────────────────────────────────────────────────────────────────────
shopt -s cdspell


#───────────────────────────────────────────────────────────────────────────────
# UK English and UTF-8
#───────────────────────────────────────────────────────────────────────────────
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB"


#───────────────────────────────────────────────────────────────────────────────
# Source the functions required for a prompt containing the current Git status
#───────────────────────────────────────────────────────────────────────────────
[ -f ~/.shell/git-prompt.sh ] && . ~/.shell/git-prompt.sh

# vim:ft=sh
