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
        wget "https://pippin.gimp.org/ametameric/"$filename \
            -O $HOME/.cache/ametameric/$filename
    end
    and head -c 422 $HOME/.cache/ametameric/$filename
end
