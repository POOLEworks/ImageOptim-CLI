# begin
startTime=$(now)

echo "Processing $(getImgCount) images..."

if [ "true" == $runImageAlpha ]; then
  $(populateImageAlphaQueue)
  $(waitFor "ImageAlpha")
  osascript -e 'tell application "ImageAlpha" to quit'
fi

$(populateImageOptimQueue)
$(waitFor "ImageOptim")

if [ "true" == $runJPEGmini ]; then
  `osascript "$cliPath/imageOptimAppleScriptLib" runJpegMini $imgPath` > /dev/null 2>&1
fi

endTime=$(now)

if [ "true" == $quitOnComplete ]; then
  osascript -e 'tell application "ImageOptim" to quit'
fi

success "Finished in $(getTimeSpent) seconds" | xargs