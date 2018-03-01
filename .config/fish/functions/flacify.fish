function flacify
	for file in *.wav
		ffmpeg -v quiet -i $file $file.flac
		and rm $file
	end
end
