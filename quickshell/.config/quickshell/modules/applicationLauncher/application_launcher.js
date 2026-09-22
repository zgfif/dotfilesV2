// application_launcher.js

function sortByCount(array) {
    array.sort((a, b) => b.count - a.count)
    return array
}



function sortByName(array) {
    array.sort((a, b) => a.name.localeCompare(b.name))
    return array
}



function convertDesktopsStringToArray(desktopsString) {
    const arr = []
    const output = desktopsString.trim()

    if (!output)
        return

    const lines = output.split("\n")

    for (const line of lines) {
        let values = line.split(" ___ ")

        if (values.length < 3)
            continue

        let exec = values[1].split(" ")[0]
        
        if (values[3] === "true") {
            exec = `kitty -e ${exec}`
        }

        arr.push(
            { 
                name: values[0], 
                exec: exec,
                icon: values[2],
            }
        )
    }
    return arr
}



function getDesktopsArrayWithCount(desktopsArray, sortedLaunchedApps) {
    const desktopsArrayWithCount = []

    for (const desktop of desktopsArray) {
        desktop.count = 0
        
        const desktopInLaunched = sortedLaunchedApps.find(elem => elem.name === desktop.name)

        if (desktopInLaunched) {
            desktop.count = desktopInLaunched.count
        }
        
        desktopsArrayWithCount.push(desktop)
    }

    return desktopsArrayWithCount
}


function splitByLaunching(desktops) {
    const launchedDesktopsArray = []
    const notlaunchedDesktopsArray = []

    for (const desktop of desktops) {
        if (desktop.count > 0) {
            launchedDesktopsArray.push(desktop)
        } else {
            notlaunchedDesktopsArray.push(desktop)
        }
    }

    return [launchedDesktopsArray, notlaunchedDesktopsArray]
}



function buildAppsArrayAccordingToLaunchCount(
    desktopsArray, 
    launchedAppsArray
) {
    const sortedLauncheAppsArray = sortByCount(launchedAppsArray.apps)

    const desktopsArrayWithCount = getDesktopsArrayWithCount(
        desktopsArray, 
        sortedLauncheAppsArray
    )

    const splited = splitByLaunching(desktopsArrayWithCount)

    // firstly we show previusly launched apps count > 1, then others - sorted by alphabet.
    return [
        ...sortByCount(splited[0]), 
        ...sortByName(splited[1])
    ]
}



function updateLaunchedAppsArray(fileData, appName) {
    const index = fileData.apps.findIndex(item => item.name === appName)

    if (index < 0) {
        fileData.apps.push({
            name: appName,
            count: 1
        })

    } else {
        fileData.apps[index].count += 1
    }
 
    sortByCount(fileData.apps)

    return fileData
}



function jsonToObject(jsonText) {
    const defaultObject = { apps: [] }

    if (jsonText.length === 0) {
        return defaultObject
    }

    try {
        return JSON.parse(jsonText)
    } catch (error) {
        console.log("Failed to parse launched apps:", error)
        return defaultObject
    }
}



function convertToLocal(filePath) {
    return filePath.replace("file://", "")
}



function updateLaunchedAppsFile(file, appName) {
    let fileData = jsonToObject(
        file.text()
    )

    fileData = updateLaunchedAppsArray(fileData, appName)

    try {
        const string = JSON.stringify(fileData, null, 4)

        try {
            file.setData(string)
        } catch (error) {
            console.log("Can not write to JSON file:", error)
            return
        }

    } catch (error) {
        console.log("Can not convert JSON to string:", error)
        return
    }
}



function buildAppsArray(desktopsString, jsonFile) {
    const desktopsArray = convertDesktopsStringToArray(desktopsString)

    const launchedAppsArray = jsonToObject(
        jsonFile.text()
    )

    return buildAppsArrayAccordingToLaunchCount(
        desktopsArray, 
        launchedAppsArray
    )
}
