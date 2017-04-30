function fish_prompt
    if not set -q __fish_prompt_shortened_hostname
        set -g __fish_prompt_shortened_hostname (hostname | cut -f 1 -d . |head -c 4)
    end

    echo -n -s (set_color (__prompt_color)) (set_reverse) $__fish_prompt_shortened_hostname " " (prompt_pwd) (set_reverse) (set_color normal) (__prompt_trailing) " "
end
