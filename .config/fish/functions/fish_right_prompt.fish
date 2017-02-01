function fish_right_prompt
    echo -n -s " " (set_color (__prompt_color)) (set_reverse) (git_branch_name) (set_reverse) (set_color normal)
end
