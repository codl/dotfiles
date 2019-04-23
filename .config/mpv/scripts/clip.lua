local mp = require 'mp'
local utils = require 'mp.utils'

function append(a, b)
    if #b == 0 then
        return
    end
    for i = 1, #b do
        table.insert(a, b[i])
    end
end

function dirname(filename)
    sep = package.config:sub(1,1)
    return filename:match('.*'..sep)
end

function prepare_clip()
    loopa = mp.get_property_number('ab-loop-a')
    loopb = mp.get_property_number('ab-loop-b')

    tmpdir = dirname(os.tmpname())


    if not loopa or not loopb then
        mp.osd_message('Must have an A-B loop to clip')
        return
    end

    path = mp.get_property('path')

    length = loopb - loopa

    subtitles = (
        mp.get_property_bool('sid', true)
        and mp.get_property_bool('sub-visibility')
    )

    if subtitles then
        subfile = tmpdir..'clip.ass'
        args = {
            'ffmpeg',
                '-v', 'fatal',
                '-ss', loopa, '-t', length+1, '-i', path, '-map', '0:s',
                '-y', subfile
        }

        result = utils.subprocess({args=args})

        if result['status'] ~= 0 then
            mp.osd_message('Error creating clip', 10)
            return
        end
    end

    abr = 8*8*1000 / length
    abr_video = abr - 128

    height = mp.get_property_number('height')
    scale = height > 1080

    args = {
        'ffmpeg',
            '-v', 'fatal',
            '-ss', loopa, '-t', length, '-i', path,
            '-map_metadata', '-1',
            '-ac', '2',
            '-filter:a', 'acompressor=ratio=20:threshold=.001:makeup=64:attack=20:release=1000,volume=2.5',
            '-sn',
            '-b:a', '128k',
            '-maxrate', abr_video .. 'k',
            '-bufsize', '8M',
            '-crf', '18',
            '-pix_fmt', 'yuv420p'
    }

    if scale or subtitles then
        filtergraph = ''
        if subtitles then
            filtergraph = filtergraph..'subtitles=f='..subfile..','
        end
        if scale then
            filtergraph = filtergraph..'scale=-2:1080,'
        end
        filtergraph = string.sub(filtergraph, 0, -2)
        append(args, {
            '-filter:v', filtergraph,
        })
    end

    append(args,
        {
            '-f', 'mp4',
            '-preset', 'slower',
            '-movflags', '+faststart',
            '-y', tmpdir..'clip.mp4'
        }
    )

    return args
end

function dump_clip_script()
    args = prepare_clip()
    f = io.open('/tmp/clip.sh', 'w')
    args_s = '"' .. table.concat(args, '" "') .. '"';
    f:write(args_s)
    f:close()
    mp.osd_message('Dumped /tmp/clip.sh', 10)
end

function clip()
    mp.osd_message('Clipping...', 10)

    args = prepare_clip()

    result = utils.subprocess({args=args})

    if result['status'] == 0 then
        mp.osd_message('Clip created', 10)
    else
        mp.osd_message('Error creating clip', 10)
    end


end

mp.add_key_binding('C', 'clip', clip)
mp.add_key_binding('ctrl+shift+C', 'dump-clip-script', dump_clip_script)
