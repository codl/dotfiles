local mp = require 'mp'
--local msg = require 'mp.msg'
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

function clip()
    mp.osd_message('Clipping...', 10)

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
    abr = math.min(abr, 1000)
    abr_video = abr - 128

    height = mp.get_property_number('height')
    scale = height > 720

    args = {
        'ffmpeg',
            '-v', 'fatal',
            '-ss', loopa, '-t', length, '-i', path,
            '-map_metadata', '-1',
            '-ac', '2',
            '-sn',
            '-b:v', abr_video .. 'k', '-b:a', '128k',
    }

    if scale or subtitles then
        filtergraph = ''
        if subtitles then
            filtergraph = filtergraph..'subtitles=f='..subfile..','
        end
        if scale then
            filtergraph = filtergraph..'scale=-2:720,'
        end
        filtergraph = string.sub(filtergraph, 0, -2)
        append(args, {
            '-vf', filtergraph,
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


    result = utils.subprocess({args=args})

    if result['status'] == 0 then
        mp.osd_message('Clip created', 10)
    else
        mp.osd_message('Error creating clip', 10)
    end


end

mp.add_key_binding('C', 'clip', clip)
