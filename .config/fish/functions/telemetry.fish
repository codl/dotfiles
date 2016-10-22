function telemetry -a dest
    curl -s -XPOST -d "host="(hostname) https://beacon.codl.fr/self-telemetry/$dest &
end
