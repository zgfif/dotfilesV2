// volume.js

const VOLUME_ICONS = ["", "", "", ""]



function chooseIcon(level) {
    if (level >= 0.66)
        return VOLUME_ICONS[3]
    
    if (level >= 0.33)
        return VOLUME_ICONS[2]
    
    if (level > 0)
        return VOLUME_ICONS[1]

    return VOLUME_ICONS[0]
}



function indicator(level, muted) {
    return muted ? VOLUME_ICONS[0] : chooseIcon(level)
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
