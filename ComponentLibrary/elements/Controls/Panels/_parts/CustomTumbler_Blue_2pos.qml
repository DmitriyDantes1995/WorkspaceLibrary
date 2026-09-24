import QtQuick 2.0
Image {
    property real m_state;
    fillMode: Image.PreserveAspectFit
    source: {
        if(m_state == 1)
            return  Qt.resolvedUrl("Blue_tumbler_up.png")
        else
            return  Qt.resolvedUrl("Blue_tumbler_down.png")
    }
}


