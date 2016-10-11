function __prompt_trailing
    switch (id -u)
    case 0
        echo #
    case '*'
        echo \$
    end
end
