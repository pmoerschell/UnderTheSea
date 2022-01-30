import QtQuick 2.12
import QtQuick.Controls 2.5
import QtWebEngine 1.8
import org.jsonDownloader 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Under the Sea")
    property string jsonUrl: "https://s3.amazonaws.com/com.buildbox.dev.interview/UnderTheSea/data.json"
    property variant parentModelquery: []

    JsonDownloader { // C++sterd type (see main.cpp, jsondownloader.[cpp|.h])
        id: jsonDownloader
        // call into C++ to retrieve JSON from Url
        Component.onCompleted: { jsonDownloader.fetchJson(jsonUrl); }
        // call into C++ to retrieve JSON downloaded
        onDownloaded: { jsonModel.json = jsonDownloader.downloadedJson(); }
    }

    // web engine to open clicked on object in default browser window
    WebEngineView {
        id: webEngineView
        url: ""
        onUrlChanged: { Qt.openUrlExternally(url); }
    }

    Column {
        anchors.fill: parent
        leftPadding: parent.width / 50
        spacing: parent.height / 50
        topPadding: spacing

        Button {
            id: upButton
            height: parent.height / 18
            width: parent.width / 10
            Text {
                anchors.centerIn: parent
                font.pixelSize: parent.height / 3
                text: qsTr("Up")
            }
            background: Rectangle {
                color: "white"
                border.color: "black"
                border.width: 1
            }
            onClicked: {
                if ( parentModelquery.length > 0)
                    jsonModel.query =  parentModelquery.pop();
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height - upButton.height
            Grid {
                anchors.fill: parent
                columns: 6
                anchors.horizontalCenter: parent.horizontalCenter

                JSONListModel {  // from JSONListModel.qml
                    id: jsonModel
                    json: ""
                    query: "$[*]"
                }
                Repeater {
                    model: jsonModel.model
                    Rectangle {
                        width: parent.width / 7
                        height: width
                        border.color: "black"
                        border.width: 1
                        Column {
                            anchors.fill: parent
                            spacing: height / 10
                            topPadding: height / 5
                            Image {
                                width: parent.width / 3
                                height: width
                                source: model.icon
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text {
                                text: qsTr(model.name)
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: parent.height / 8
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                // if url exists, open it, otherwise display children menu
                                if (typeof model.url !== "undefined") {
                                    webEngineView.url = model.url;
                                } else {
                                    parentModelquery.push(jsonModel.query);
                                    jsonModel.query = "$..[?(@.name=='" + model.name + "')].children[*]"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
