// app_launcher.js

function sortByCount(array) {
    array.sort((a, b) => b.count - a.count)
    return array
}



function sortByName(array) {
    array.sort((a, b) => a.name.localeCompare(b.name))
    return array
}



function getDesktopsArray(desktopsString) {
    const arr = []
    const output = desktopsString.trim()

    if (!output)
        return

    const lines = output.split("\n")

    for (const line of lines) {
        let values = line.split(" ___ ")

        if (values.length < 3)
            continue
        
        arr.push(
            { 
                name: values[0], 
                exec: values[1].split(" ")[0], 
                icon: values[2]
            }
        )
    }
    return arr
}



function getdesktopsArrayWithCount(desktopsArray, sortedLaunchedApps) {
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



function buildDesktopsArray(
    desktopsString, 
    launchedAppsArray
) {
    const desktopsArray = getDesktopsArray(desktopsString)
    const sortedLauncheAppsArray = sortByCount(launchedAppsArray.apps)

    const desktopsArrayWithCount = getdesktopsArrayWithCount(
        desktopsArray, 
        sortedLauncheAppsArray
    )

    const splited = splitByLaunching(desktopsArrayWithCount)

    return [
        ...sortByCount(splited[0]), 
        ...sortByName(splited[1])
    ]
}



function updateAppsData(fileData, appName) {
    const index = fileData.apps.findIndex(item => item.name === appName)

    if (index < 0) {
        fileData.apps.push({
            name: appName,
            count: 1
        })

    } else {
        fileData.apps[index].count += 1
    }

    return fileData
}
