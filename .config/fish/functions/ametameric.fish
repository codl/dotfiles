function ametameric
    argparse --name=antameric --exclusive=r,d 'r/reverse' 'd/desaturated' -- $argv
    or return
    set filename 'ametameric.esc'
    if set -q _flag_r
        set filename 'ametameric-reverse.esc'
    else if set -q _flag_d
        set filename 'ametameric-desaturated.esc'
    end
    if test ! -f $HOME/.cache/ametameric/$filename
        mkdir -p $HOME/.cache/ametameric/
        echo "Downloading $filename in the background..."
        wget -q "https://pippin.gimp.org/ametameric/"$filename \
            --user-agent="ametameric.fish +https://github.com/codl/dotfiles/blob/master/.config/fish/functions/ametameric.fish" \
            -O $HOME/.cache/ametameric/$filename &
        function _postdownload --inherit-variable filename --on-process-exit (jobs --last --pid)
            __ametameric_init $filename
        end
    else
        __ametameric_init $filename
    end
end

function __ametameric_init -a filename
    head -c 422 $HOME/.cache/ametameric/$filename
end
