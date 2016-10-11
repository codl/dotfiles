function slop
	/usr/bin/slop | sed "s/\([^=]\+\)=\(.\+\)/set \1 \2;/"
end
