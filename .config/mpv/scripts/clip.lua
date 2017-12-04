local mp = require 'mp'
local msg = require 'mp.msg'
local utils = require 'mp.utils'
local table = require 'table'

function append(a, b)
    if #b == 0 then
        return
    end
    for i = 1, #b do
        table.insert(a, b[i])
    end
end

function clip()
    loopa = mp.get_property_number('ab-loop-a')
    loopb = mp.get_property_number('ab-loop-b')

    if not loopa or not loopb then
        mp.osd_message('Must have an A-B loop to clip')
        return
    end

    path = mp.get_property('path')

    length = loopb - loopa

    abr = 7*8*1000 / length
    abr = math.min(abr, 1000)
    abr_video = abr - 128

    maybe_resize = {}
    height = mp.get_property_number('height')
    if height > 720 then
        maybe_resize = {'-vf', 'scale=-2:720'}
    end

    args = {
        'ffmpeg',
            '-v', 'fatal',
            '-ss', loopa, '-t', length, '-i', path,
            '-b:v', abr_video .. 'k', '-b:a', '128k'
    }
    more_args = {
        '-f', 'mp4', '-preset', 'faster', '-movflags', '+faststart', '-y', '/tmp/clip.mp4'
    }

    append(args, maybe_resize)
    append(args, more_args)


    mp.osd_message('Clipping...')
    result = utils.subprocess({args=args})

    if result['status'] == 0 then
        mp.osd_message('Clip created', 10)
    else
        mp.osd_message('Error creating clip', 10)
    end


end

mp.add_key_binding('C', 'clip', clip)
