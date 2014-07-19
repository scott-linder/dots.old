set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
function __prompt_section_start
    printf '%s[' (set_color normal)
end
function __prompt_section_next
    printf '%s][' (set_color normal)
end
function __prompt_section_end
    printf '%s]' (set_color normal)
end
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l git_prompt (__fish_git_prompt '%s')
    set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
    set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/")
    set -l host (hostname -s)
    set -l prompt_symbol ''
    switch $USER
        case root; set prompt_symbol '#'
        case '*';  set prompt_symbol '$'
    end
    __prompt_section_start
    printf '%s%s' (set_color green) "$USER"
    printf '%s@' (set_color normal)
    printf '%s%s' (set_color cyan) "$host"
    __prompt_section_next
    printf '%s%s' (set_color $fish_color_cwd) "$pwd"
    if test -n "$git_prompt"
        __prompt_section_next
        printf '%s' "$git_prompt"
    end
    if test "$last_status" -ne 0
        __prompt_section_next
        printf '%s%s' (set_color red) "$last_status"
    end
    __prompt_section_end
    printf '%s%s ' (set_color normal) "$prompt_symbol"
end
