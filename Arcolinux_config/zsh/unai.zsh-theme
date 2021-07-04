# green username
username() {
   echo "%{$fg[green]%}%n%{$reset_color%}"
}
foldericon() {
   echo "%{$FG[012]%} %{$reset_color%}"
}
# current directory, two levels deep
directory() { 
    echo "%{$FG[012]%}%0~/%{$reset_color%}"
}

function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

# set the git_prompt_info text
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}(%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[yellow]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗"


# putting it all together
PROMPT='%B$(username) $(foldericon)$(directory)$(git_prompt_info)%(!.#.$) '
