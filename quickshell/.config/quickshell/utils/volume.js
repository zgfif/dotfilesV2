// volume.js

const VOLUMEICONS = ["", "", "", ""]



function chooseIcon(level) {
    if (level >= 0.66)
        return VOLUMEICONS[3]
    
    if (level >= 0.33)
        return VOLUMEICONS[2]
    
    if (level > 0)
        return VOLUMEICONS[1]

    return VOLUMEICONS[0]
}



function indicator(level, muted) {
    return muted ? VOLUMEICONS[0] : chooseIcon(level)
}



function getVolume(audioSink) {
    return audioSink?.audio?.volume ?? 0
}



function isMuted(audioSink) {
    return audioSink?.audio?.muted ?? false
}



function tooltip(level, muted) {
    const percentage = (level * 100).toFixed()
    const status = muted ? "\n[muted]" : ""

    return `vol: ${percentage}%${status}`
}
