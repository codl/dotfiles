function __prompt_connection_emoji
    if set --query SSH_CONNECTION
        echo "⚡"
    end
end
