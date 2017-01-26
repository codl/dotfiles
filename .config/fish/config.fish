if status --is-login
    exec bash -l -c "source ~/.profile; exec fish -i"
end
