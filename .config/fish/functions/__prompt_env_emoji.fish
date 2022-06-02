function __prompt_env_emoji
    if set --query VIRTUAL_ENV
        echo "🐍"
    else if set --query DIRENV_DIR
        echo "."
    end
end
