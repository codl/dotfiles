#!/bin/bash

# disable path name expansion or * will be expanded in the line
# cmd=( $line )
set -f

monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format: WxH+X+Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=18
font="-*-Ubuntu-*-*-*-*-10-*-*-*-*-*-*-*"
font="-*-Roboto+DroidSansJap-*-*-*-*-10-*-*-*-*-*-*-*"

 MOST="#cc0000"
 MORE="#01a242"
   FG="#331d11"
 LESS="#ccaa88"
LEAST="#ccc5bb"
   BG="#f2e9e2"

  SEP="^bg()^fg($LEAST)^r(1x$panel_height)^fg()"

SPACING="   "

COLORS=$( dirname $0 )/$( hostname -s ).colors.sh
if [[ -f $COLORS ]]; then
  source $COLORS
fi

trayer="trayer --alpha 0 --transparent true --tint 0x${BG#'#'} --widthtype request --height $panel_height --align right --edge top --expand true"

####
# true if we are using the svn version of dzen2
# depending on version/distribution, this seems to have version strings like
# "dzen-" or "dzen-x.x.x-svn"
if dzen2 -v 2>&1 | head -n 1 | grep -q '^dzen-\([^,]*-svn\|\),'; then
    dzen2_svn="true"
else
    dzen2_svn=""
fi

function uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

herbstclient pad $monitor $panel_height
{
    while true ; do
        echo -n "date $SEP$SPACING$(date +"%H:%M %Z")$SPACING"
        echo -n "^fg($LESS)($(TZ=UTC date +"%H %Z"), $(TZ='America/Los_Angeles' date +"%H %Z"), $(TZ=America/New_York date +"%H %Z"))$SPACING$SEP$SPACING"
        echo    "^fg($LESS)$(date +"%Y-%m-^fg()%d")$SPACING"
        sleep 1 || break
    done > >(uniq_linebuffered)  &
    pids+=($!)

    while true; do
        BATTOUTPUT=""
        battpct=$(acpi | sed -n "s/.*, \(.*\)%.*/\1/p")
        batttime=$(acpi | sed -n "s/.*, .*%, .\(.:..\).*/\1/p")
        battstatus=$(acpi | sed -n "s/.*: \([^,]*\).*/\1/p")
        fg=$LESS
        bg=""
        content="$batttime"
        [[ $battstatus != 'Discharging' || $batttime == '' ]] && content="${battpct}%"
        [[ $battstatus == 'Discharging' ]] && fg=$FG
        [[ $battpct -lt 60 && $battstatus == 'Discharging' ]] && fg=$MORE
        [[ $battpct -lt 20 && $battstatus == 'Discharging' ]] && bg=$MORE && fg=$BG
        [[ $battpct -lt 95 || $battstatus == 'Discharging' ]] && BATTOUTPUT="$SEP^bg($bg)^fg($fg)${SPACING}^i($HOME/.dzen/batt$[$battpct * 5 / 100].xbm) ${content}$SPACING"
        echo "batt $BATTOUTPUT"
        sleep 2
    done > >(uniq_linebuffered)  &
    pids+=($!)

    while true; do
      time=$(tamato)
      fg=$FG
      bg=$BG
      [[ ${time%:*} -le 2 ]] && bg=$FG && fg=$BG
      [[ $time == "0:00" ]] && bg=$BG && fg=$LESS
      echo "tamato $SEP^ca(1, tamato -s)^ca(3, tamato -b)^ca(2, tamato -l)^bg($bg)^fg($fg)${SPACING}^r(3x3) $(tamato)$SPACING^ca()^ca()^ca()"
      sleep 1
    done > >(uniq_linebuffered) &
    pids+=($!)


    if [[ $monitor == 0 ]]; then
        nitrogen --restore
        sleep 2
        $trayer &
        pids+=($!)
    fi


    herbstclient --idle
    kill -TERM "${pids[@]}" >/dev/null 2>&1

} 2> /dev/null | {

    TAGS=( $(herbstclient tag_status $monitor) )
    visible=true
    date=""
    windowtitle=""
    batt=""
    while true ; do
        iscurmonitor=false
        # draw tags
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') #viewed and focused
                    echo -n "^bg($MORE)^fg($BG)"
                    iscurmonitor=true
                    ;;
                '+') #viewed and unfocused
                    echo -n "^bg($LESS)^fg($BG)"
                    ;;
                '-'|'%') #viewed on another monitor and focused/unfocused
                    echo -n "^bg($LEAST)^fg($BG)"
                    ;;
                '!') #urgent
                    echo -n "^bg($MOST)^fg($BG)"
                    ;;
                ':') #not empty
                    echo -n "^bg()^fg()"
                    ;;
                '.'|*) #empty
                    continue
                    ;;
                '#') #viewed and focused
                    echo -n "^bg($MORE)^fg($BG)"
                    iscurmonitor=true
                    ;;
            esac
            if [ ! -z "$dzen2_svn" ] ; then
                echo -n "^ca(1,herbstclient focus_monitor $monitor && "'herbstclient use "'${i:1}'")'"$SPACING${i:1}$SPACING^ca()"
            else
                echo -n "$SPACING${i:1}$SPACING"
            fi
        done
        if [[ ! -z $date ]]; then
            echo -n "$date"
        fi
        if [[ ! -z $batt ]]; then
            echo -n "$batt"
        fi
        if [[ ! -z $tamato ]]; then
            echo -n "$tamato"
        fi
        if [[ $iscurmonitor == true ]]; then
            echo -n "$SEP$SPACING${windowtitle//^/^^}"
        fi
        echo
        # wait for next event
        read line || break
        cmd=( $line )
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                #echo "resetting tags" >&2
                TAGS=( $(herbstclient tag_status $monitor) )
                ;;
            batt)
                batt="${cmd[@]:1}"
                ;;
            tamato)
                tamato="${cmd[@]:1}"
                ;;
            date)
                #echo "resetting date" >&2
                date="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            togglehidepanel)
                currentmonidx=$(herbstclient list_monitors |grep ' \[FOCUS\]$'|cut -d: -f1)
                if [ -n "${cmd[1]}" ] && [ "${cmd[1]}" -ne "$monitor" ] ; then
                    continue
                fi
                if [ "${cmd[1]}" = "current" ] && [ "$currentmonidx" -ne "$monitor" ] ; then
                    continue
                fi
                echo "^togglehide()"
                if $visible ; then
                    visible=false
                    herbstclient pad $monitor 0
                else
                    visible=true
                    herbstclient pad $monitor $panel_height
                fi
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
        esac
    done
} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y -fn "$font" -h $panel_height \
    -ta l -bg "$BG" -fg "$FG" -e 'button3='
