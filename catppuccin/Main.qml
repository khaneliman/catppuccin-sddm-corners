import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "components"

Item {
    id: root

    height: Screen.height
    width: Screen.width

    Image {
        id: background

        anchors.fill: parent
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectCrop

        source: config.Background

        asynchronous: false
        cache: true
        mipmap: true
        clip: true
    }

    Item {
        id: contentPanel

        anchors {
            fill: parent
            topMargin: config.Padding
            rightMargin: config.Padding
            bottomMargin:config.Padding
            leftMargin: config.Padding
        }

        DateTimePanel {
            id: dateTimePanel

            anchors.fill: parent
        }

        LoginPanel {
            id: loginPanel

            anchors.fill: parent
        }
    }
}
