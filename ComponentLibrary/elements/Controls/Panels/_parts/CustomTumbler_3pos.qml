import QtQuick 2.0

Image {
    property real m_state;
    source: {
        if(m_state == 0)
            return  Qt.resolvedUrl("tumbler_down.png")
        if(m_state == 1)
            return  Qt.resolvedUrl("tumbler_center.png")
        if(m_state == 2)
            return  Qt.resolvedUrl("tumbler_left.png")
        if(m_state == 3)
            return  Qt.resolvedUrl("tumbler_right.png")
        else
            return  Qt.resolvedUrl("tumbler_center.png")
    }
}
