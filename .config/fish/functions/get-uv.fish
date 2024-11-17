function get-uv
    mkdir -p ~/.local/bin
    pushd ~/.local/bin
    and curl -L https://github.com/astral-sh/uv/releases/download/$argv[1]/uv-x86_64-unknown-linux-gnu.tar.gz | gunzip | tar xv --strip-components=1
    popd
end
