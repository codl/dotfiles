function __prompt_color
    if not set -q __fish_prompt_color
        set -l colors green cyan yellow blue magenta
        set -l host_hash (oldmath ibase=16\;(hostname | md5sum | tr '[a-f]' '[A-F]' | head -c15))
        set -U __fish_prompt_color $colors[(math $host_hash%(count $colors)+1)]
    end

    echo -n "$__fish_prompt_color"
end
