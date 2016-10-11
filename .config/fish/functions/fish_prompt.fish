function fish_prompt
	if not set -q __fish_prompt_shortened_hostname
        set -g __fish_prompt_shortened_hostname (hostname -s|head -c 3)
    end

    if not set -q __fish_prompt_colour
        set -l colours green cyan yellow blue magenta
        set -l host_hash (math ibase=16\;(hostname | md5sum | tr '[a-f]' '[A-F]' | head -c15))
        set -U __fish_prompt_colour $colours[(math $host_hash%(count $colours)+1)]
    end

    echo -n -s (set_color $__fish_prompt_colour) (set_reverse) $__fish_prompt_shortened_hostname " " (prompt_pwd) (set_reverse) (set_color normal) (__prompt_trailing) " "
end
