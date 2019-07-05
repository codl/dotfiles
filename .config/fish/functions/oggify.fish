function oggify
    find -name '*.flac' | while read f
        echo "$f"
        ffmpeg -i "$f" -hide_banner -v error -nostdin -map 0:a -c:a libvorbis -y "$f.ogg"
        and metaflac --export-picture-to=/tmp/oggify-pic.tmp "$f"
        and kid3-cli -c 'set picture:"/tmp/oggify-pic.tmp" "front"' "$f.ogg"
        and rm "$f"
    end
end

