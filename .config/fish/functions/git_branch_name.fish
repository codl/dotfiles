function git_branch_name -d "Get the name of the current Git branch, tag or sha1"
    set -l branch_name (command git symbolic-ref --short HEAD 2>/dev/null)

    if test -z "$branch_name"
        set -l tag_name (command git describe --tags --exact-match HEAD 2>/dev/null)

        if test -z "$tag_name"
            command git rev-parse --short HEAD 2>/dev/null
        else
            printf "%s\n" "$tag_name"
        end
    else
        printf "%s\n" "$branch_name"
    end
end
# https://github.com/fisherman/git_util/blob/81cd0c365ea863579146980cdd5e717c10c9ac33/git_branch_name.fish
