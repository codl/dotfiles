# This function initializes the ametameric color palette in your terminal.
# It is intended to be added to your config.fish like so:
#
# if status --is-interactive
#     ametameric
# end
#
# Command-line flags -r (--reverse) and -d (--desaturated) download and apply
# variants of the palette.
#
# On first run, it will download the palette in the background and apply it when
# it is done. Subsequent runs will apply the palette from cache.
#
# Ametameric is made by Øyvind Kolås <https://pippin.gimp.org/ametameric/>

function ametameric

    argparse --exclusive=r,d 'r/reverse' 'd/desaturated' 'h/help' -- $argv
    if test $status != 0 -o -n "$_flag_h"
        echo "usage: ametameric [(-r | --reverse)|(-d | --desaturated)]"
        return
    end

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
    # cutting after 422 bytes means we only get the color setting escapes
    # without the cute little color demo
    head -c 422 $HOME/.cache/ametameric/$filename
end
