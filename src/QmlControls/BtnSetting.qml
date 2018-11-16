/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick                  2.3
import QtQuick.Controls         1.2
import QtQuick.Controls.Styles  1.4
import QtQuick.Dialogs          1.2
import QtCharts                 2.0
import QGroundControl               1.0
import QGroundControl.Palette       1.0
import QGroundControl.Controls      1.0
import QGroundControl.Controllers   1.0
import QGroundControl.ScreenTools   1.0


import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

QGCView {
    id:         freqCalibration
    viewPanel:  panel
    property var _qgcView: qgcView
    property real __gap1: 15


    property real __chNumber: 0
    property real __comboxIndex: 0


    property bool __isCalibrate:false
    property bool __isAuto:false


    QGCPalette { id: qgcPal; colorGroupEnabled: panel.enabled }

    QGCViewPanel {
        id:             panel
        anchors.fill:   parent
        Rectangle {
            id:              centreWindow
            anchors.fill:    parent
            anchors.margins: ScreenTools.defaultFontPixelWidth
            color:           qgcPal.window

            function whichStatusIn() {
                if ((__chNumber < 5)||(__chNumber > 10))
                {
                    return;
                }
                else
                {
                    if(__chNumber == 10)
                    {
                        //show
                        mainlyout.visible = false;
                        videoLyout.visible = true;
                    }
                    else if(__comboxIndex == 1)
                    {
                        //show
                        mainlyout.visible = false;
                        oneChannelLyout.visible = true;

                    }
                    else
                    {
                        if(__comboxIndex == 3)
                        {
                            mulRow4.visible = false;
                        }
                        else if(__comboxIndex == 2)
                        {
                            mulRow4.visible = false;
                            mulRow3.visible = false;
                        }
                        mainlyout.visible = false;
                        mulChannelLyout.visible = true;
                    }
                }
            }
            function saveChSetting() {
                if(__chNumber == 5)
                {
                    if(ch5Combo.currentIndex == 0)
                    {
                        ch5Label.text = oneChannelCombo1.currentText;
                    }
                    else if(ch5Combo.currentIndex == 1)
                    {
                        ch5Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                    }
                    else if(ch5Combo.currentIndex == 2)
                    {
                        ch5Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                    }
                    else if(ch5Combo.currentIndex == 3)
                    {
                        ch5Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                    }
                }
                else if(__chNumber == 6)
                {
                    if(ch6Combo.currentIndex == 0)
                    {
                        ch6Label.text = oneChannelCombo1.currentText;
                    }
                    else if(ch6Combo.currentIndex == 1)
                    {
                        ch6Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                    }
                    else if(ch6Combo.currentIndex == 2)
                    {
                        ch6Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                    }
                    else if(ch6Combo.currentIndex == 3)
                    {
                        ch6Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                    }
                }
                else if(__chNumber == 7)
                {
                    if(ch7Combo.currentIndex == 0)
                    {
                        ch7Label.text = oneChannelCombo1.currentText;
                    }
                    else if(ch7Combo.currentIndex == 1)
                    {
                        ch7Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                    }
                    else if(ch7Combo.currentIndex == 2)
                    {
                        ch7Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                    }
                    else if(ch7Combo.currentIndex == 3)
                    {
                        ch7Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                    }
                }
                else if(__chNumber == 8)
                {
                    if(ch8Combo.currentIndex == 0)
                    {
                        ch8Label.text = oneChannelCombo1.currentText;
                    }
                    else if(ch8Combo.currentIndex == 1)
                    {
                        ch8Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                    }
                    else if(ch8Combo.currentIndex == 2)
                    {
                        ch8Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                    }
                    else if(ch8Combo.currentIndex == 3)
                    {
                        ch8Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                    }
                }
                else if(__chNumber == 9)
                {
                    if(ch9Combo.currentIndex == 0)
                    {
                        ch9Label.text = oneChannelCombo1.currentText;
                    }
                    else if(ch9Combo.currentIndex == 1)
                    {
                        ch9Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                    }
                    else if(ch9Combo.currentIndex == 2)
                    {
                        ch9Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                    }
                    else if(ch9Combo.currentIndex == 3)
                    {
                        ch9Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                    }
                }
                else if(__chNumber == 10)
                {
                    videoLabel.text = videoCombox.currentText;
                }
            }



            Row{
                id:             mainlyout
                anchors.fill:   parent
                anchors.leftMargin: 200
                Column{
                    anchors.fill:   parent
                    spacing: 22
                    Row{
                        spacing: 160
                        QGCLabel {
                            text:                   qsTr("CH")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }

                        QGCLabel {
                            text:                   qsTr("Button options")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }
                    }
                    Row{
                        spacing: 150
                        QGCLabel {
                            anchors.top:         parent.top
                            anchors.topMargin:   __gap1
                            text:                   qsTr("CH5")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }

                        QGCComboBox {
                            id:             ch5Combo
                            model:          [qsTr("one button"), qsTr("two buttons"), qsTr("three buttons"), qsTr("four buttons")]
                            width:      ScreenTools.defaultFontPixelWidth*12
                            onActivated: {
                                if (index != -1) {
                                }
                            }
                        }

                        QGCButton {
                            id:                    ch5Button
                            text:            qsTr("Settings")
                            onClicked:{
                                __chNumber = 5;
                                __comboxIndex = ch5Combo.currentIndex + 1;
                                centreWindow.whichStatusIn();
                            }
                        }
                        QGCLabel {
                            id:                     ch5Label
                            text:                   qsTr("undefined")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }
                    }
                    Row{
                        spacing: 150
                        QGCLabel {
                            text:                   qsTr("CH6")
                            anchors.top:         parent.top
                            anchors.topMargin:   __gap1
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }

                        QGCComboBox {
                            id:                    ch6Combo
                            model:          [qsTr("one button"), qsTr("two buttons"), qsTr("three buttons"), qsTr("four buttons")]
                            width:      ScreenTools.defaultFontPixelWidth*12
                            onActivated: {
                                if (index != -1) {
                                }
                            }
                        }

                        QGCButton {
                            id:                    ch6Button
                            text:            qsTr("Settings")
                            onClicked:{
                                __chNumber = 6;
                                __comboxIndex = ch6Combo.currentIndex + 1;
                                centreWindow.whichStatusIn();
                            }
                        }
                        QGCLabel {
                            id:                     ch6Label
                            text:                   qsTr("undefined")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }
                    }

                    Row{
                        spacing: 150
                        QGCLabel {
                            text:                   qsTr("CH7")
                            anchors.top:         parent.top
                            anchors.topMargin:   __gap1
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }

                        QGCComboBox {
                            id:         ch7Combo
                            model:      [qsTr("one button"), qsTr("two buttons"), qsTr("three buttons"), qsTr("four buttons")]
                            width:      ScreenTools.defaultFontPixelWidth*12
                            onActivated: {
                                if (index != -1) {
                                }
                            }
                        }

                        QGCButton {
                            id:                    ch7Button
                            text:            qsTr("Settings")
                            onClicked:{
                                __chNumber = 7;
                                __comboxIndex = ch7Combo.currentIndex + 1;
                                centreWindow.whichStatusIn();
                            }
                        }
                        QGCLabel {
                            id:                     ch7Label
                            text:                   qsTr("undefined")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }
                    }

                    Row{
                        spacing: 150
                        QGCLabel {
                            text:                   qsTr("CH8")
                            anchors.top:         parent.top
                            anchors.topMargin:   __gap1
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }

                        QGCComboBox {
                            id:                    ch8Combo
                            model:          [qsTr("one button"), qsTr("two buttons"), qsTr("three buttons"), qsTr("four buttons")]
                            width:      ScreenTools.defaultFontPixelWidth*12
                            onActivated: {
                                if (index != -1) {
                                }
                            }
                        }

                        QGCButton {
                            id:                    ch8Button
                            text:            qsTr("Settings")
                            onClicked:{
                                __chNumber = 8;
                                __comboxIndex = ch8Combo.currentIndex + 1;
                                centreWindow.whichStatusIn();
                            }
                        }
                        QGCLabel {
                            id:                     ch8Label
                            text:                   qsTr("undefined")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }
                    }

                    Row{
                        spacing: 150
                        QGCLabel {
                            text:                   qsTr("CH9")
                            anchors.top:         parent.top
                            anchors.topMargin:   __gap1
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }

                        QGCComboBox {
                            id:                    ch9Combo
                            model:          [qsTr("one button"), qsTr("two buttons"), qsTr("three buttons"), qsTr("four buttons")]
                            width:      ScreenTools.defaultFontPixelWidth*12
                            onActivated: {
                                if (index != -1) {
                                }
                            }
                        }

                        QGCButton {
                            id:                    ch9Button
                            text:            qsTr("Settings")
                            onClicked:{
                                __chNumber = 9;
                                __comboxIndex = ch9Combo.currentIndex + 1;
                                centreWindow.whichStatusIn();
                            }
                        }
                        QGCLabel {
                            id:                     ch9Label
                            text:                   qsTr("undefined")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }
                    }
                    Row{
                        spacing: 150
                        QGCLabel {
                            text:                   qsTr("Video switch")
                            anchors.top:         parent.top
                            anchors.topMargin:   __gap1
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }
                        QGCLabel {
                            text:                qsTr("     ")
                            width:      ScreenTools.defaultFontPixelWidth*6
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }

                        QGCButton {
                            id:                     videoButton
                            text:                   qsTr("Settings")
                            onClicked:{
                                __chNumber = 10;
                                centreWindow.whichStatusIn();
                            }
                        }
                        QGCLabel {
                            id:                     videoLabel
                            text:                   qsTr("undefined")
                            wrapMode:               Text.WordWrap
                            horizontalAlignment:    Text.AlignHCenter
                        }
                    }
                }
            }
            Column{
                id:                   oneChannelLyout
                anchors.fill:         parent
                anchors.leftMargin: 300
                anchors.topMargin:  50
                spacing: 80
                Row{
                    id:oneChannelRow1
                    spacing: 100
                    QGCLabel {
                        id:                  oneChannelLabel
                        text:                qsTr("CH" + __chNumber)
                        anchors.top:         parent.top
                        anchors.topMargin:   __gap1
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCComboBox {
                        id:         oneChannelCombo1
                        model:      [qsTr("A long press"),qsTr("A short press"), qsTr("B long press"),qsTr("B  short press"), qsTr("C long press"),qsTr("C  short press"), qsTr("D long press"),qsTr("D  short press")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                            }
                        }
                    }
                    QGCLabel {
                        id:                  oneChannelLabel1
                        text:                qsTr("value")
                        anchors.top:         parent.top
                        anchors.topMargin:   __gap1
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCSlider {
                        id:                         oneChannelSlider1
                        orientation:                Qt.Horizontal
                        minimumValue:               800
                        maximumValue:               2200
                        value:                      1900
                        stepSize:                   1
                        width:                      600

                        onValueChanged: {
                            oneChannelLabel1.text = oneChannelSlider1.value;
                        }
                    }
                }
                Row{
                    id:oneChannelRow2
                    spacing: 100
                    QGCLabel {
                        text:                qsTr("     ")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCLabel {
                        text:                qsTr("start value")
                        width:      ScreenTools.defaultFontPixelWidth*9
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCLabel {
                        id:                  oneChannelLabel2
                        anchors.top:         parent.top
                        anchors.topMargin:   __gap1
                        text:                qsTr("value")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCSlider {
                        id:                         oneChannelSlider2
                        orientation:                Qt.Horizontal
                        minimumValue:               800
                        maximumValue:               2200
                        value:                      1100
                        stepSize:                   1
                        width:                      600

                        onValueChanged: {
                            oneChannelLabel2.text = oneChannelSlider2.value;
                        }
                    }
                }
                Row{
                    id:oneChannelRow3
                    spacing: 100
                    QGCLabel {
                        text:                qsTr("     ")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCLabel {
                        text:                qsTr("Control mode")
                        width:      ScreenTools.defaultFontPixelWidth*12
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCComboBox {
                        id:         oneChannelCombox
                        model:      [qsTr("Loosen the reset"),qsTr("Loosen the keep")]
                        width:      ScreenTools.defaultFontPixelWidth*20
                        onActivated: {
                            if (index != -1) {
                            }
                        }
                    }
                }
                Row{
                    id:      oneChanneBtn
                    spacing: 300

                    QGCLabel {
                        text:                qsTr("   ")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCButton {
                        id:                    oneChanneSaveButton
                        text:            qsTr("SAVE")
                        onClicked:{
                            centreWindow.saveChSetting();

                            oneChannelLyout.visible = false;
                            mainlyout.visible = true;

                            //
                            mulRow2.visible = true;
                            mulRow3.visible = true;
                            mulRow4.visible = true;
                        }
                    }
                    QGCButton {
                        id:                    oneChanneCancelButton
                        text:            qsTr("CANCEL")
                        onClicked:{
                            oneChannelLyout.visible = false;
                            mainlyout.visible = true;

                            //
                            mulRow2.visible = true;
                            mulRow3.visible = true;
                            mulRow4.visible = true;
                        }
                    }
                }
            }
            Column{
                id:                   mulChannelLyout
                anchors.fill:         parent
                anchors.leftMargin: 300
                anchors.topMargin: 50
                spacing: 30
                Row{
                    id:mulRow1
                    spacing: 100
                    QGCLabel {
                        id:                  mulChLabel
                        anchors.top:         parent.top
                        anchors.topMargin:   __gap1
                        text:                qsTr("CH" + __chNumber)
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCComboBox {
                        id:         mulRow1Combox
                        model:      [qsTr("A long press"),qsTr("A  short press"), qsTr("B long press"),qsTr("B  short press"), qsTr("C long press"),qsTr("C  short press"), qsTr("D long press"),qsTr("D  short press")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                            }
                        }
                    }
                    QGCLabel {
                        id:                  mulRow1Label
                        text:                qsTr("value")
                        anchors.top:         parent.top
                        anchors.topMargin:   __gap1
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCSlider {
                        id:                         mulRow1Slider
                        orientation:                Qt.Horizontal
                        minimumValue:               800
                        maximumValue:               2200
                        value:                      1100
                        stepSize:                   1
                        width:                      600

                        onValueChanged: {
                            mulRow1Label.text = mulRow1Slider.value;
                        }
                    }
                }
                Row{
                    id:mulRow2
                    spacing: 100
                    QGCLabel {
                        text:                qsTr("     ")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCComboBox {
                        id:         mulRow2Combox
                        model:      [qsTr("A long press"),qsTr("A  short press"), qsTr("B long press"),qsTr("B  short press"), qsTr("C long press"),qsTr("C  short press"), qsTr("D long press"),qsTr("D  short press")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                            }
                        }
                    }
                    QGCLabel {
                        id:                  mulRow2Label
                        text:                qsTr("value")
                        anchors.top:         parent.top
                        anchors.topMargin:   __gap1
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCSlider {
                        id:                         mulRow2Slider
                        orientation:                Qt.Horizontal
                        minimumValue:               800
                        maximumValue:               2200
                        value:                      1100
                        stepSize:                   1
                        width:                      600

                        onValueChanged: {
                            mulRow2Label.text = mulRow2Slider.value;
                        }
                    }
                }
                Row{
                    id:mulRow3
                    spacing: 100
                    QGCLabel {
                        text:                qsTr("     ")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCComboBox {
                        id:         mulRow3Combox
                        model:      [qsTr("A long press"),qsTr("A  short press"), qsTr("B long press"),qsTr("B  short press"), qsTr("C long press"),qsTr("C  short press"), qsTr("D long press"),qsTr("D  short press")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                            }
                        }
                    }
                    QGCLabel {
                        id:                  mulRow3Label
                        text:                qsTr("value")
                        anchors.top:         parent.top
                        anchors.topMargin:   __gap1
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCSlider {
                        id:                         mulRow3Slider
                        orientation:                Qt.Horizontal
                        minimumValue:               800
                        maximumValue:               2200
                        value:                      1100
                        stepSize:                   1
                        width:                      600

                        onValueChanged: {
                            mulRow3Label.text = mulRow3Slider.value;
                        }
                    }
                }
                Row{
                    id:mulRow4
                    spacing: 100
                    QGCLabel {
                        text:                qsTr("     ")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCComboBox {
                        id:         mulRow4Combox
                        model:      [qsTr("A long press"),qsTr("A  short press"), qsTr("B long press"),qsTr("B  short press"), qsTr("C long press"),qsTr("C  short press"), qsTr("D long press"),qsTr("D  short press")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                            }
                        }
                    }
                    QGCLabel {
                        id:                  mulRow4Label
                        text:                qsTr("value")
                        anchors.top:         parent.top
                        anchors.topMargin:   __gap1
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCSlider {
                        id:                         mulRow4Slider
                        orientation:                Qt.Horizontal
                        minimumValue:               800
                        maximumValue:               2200
                        value:                      1100
                        stepSize:                   1
                        width:                      600

                        onValueChanged: {
                            mulRow4Label.text = mulRow4Slider.value;
                        }
                    }
                }
                Row{
                    id:      mulBtn
                    spacing: 300

                    QGCLabel {
                        text:                qsTr("   ")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }

                    QGCButton {
                        id:                    mulSaveButton
                        text:            qsTr("SAVE")
                        onClicked:{
                            centreWindow.saveChSetting();

                            mulChannelLyout.visible = false;
                            mainlyout.visible = true;

                            //
                            mulRow2.visible = true;
                            mulRow3.visible = true;
                            mulRow4.visible = true;
                        }
                    }
                    QGCButton {
                        id:                    mulCancelButton
                        text:            qsTr("CANCEL")
                        onClicked:{
                            mulChannelLyout.visible = false;
                            mainlyout.visible = true;

                            //
                            mulRow2.visible = true;
                            mulRow3.visible = true;
                            mulRow4.visible = true;
                        }
                    }
                }
            }
            Column{
                id:                   videoLyout
                anchors.fill:         parent
                anchors.leftMargin: 500
                anchors.topMargin: 100
                spacing: 100
                Row{
                    id:videoRow
                    spacing: 300
                    QGCLabel {
                        text:                qsTr("Video switch")
                        wrapMode:               Text.WordWrap
                        horizontalAlignment:    Text.AlignHCenter
                    }
                    QGCComboBox {
                        id:         videoCombox
                        model:      [qsTr("A long press"),qsTr("A  short press"), qsTr("B long press"),qsTr("B  short press"), qsTr("C long press"),qsTr("C  short press"), qsTr("D long press"),qsTr("D  short press")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                            }
                        }
                    }
                }
                Row{
                    id:      videoBtn
                    spacing: 400
                    QGCButton {
                        id:                    videoSaveButton
                        text:            qsTr("SAVE")
                        onClicked:{
                            centreWindow.saveChSetting();

                            videoLyout.visible = false;
                            mainlyout.visible = true;

                            //
                            mulRow2.visible = true;
                            mulRow3.visible = true;
                            mulRow4.visible = true;
                        }
                    }
                    QGCButton {
                        id:                    videoCancelButton
                        text:            qsTr("CANCEL")
                        onClicked:{
                            videoLyout.visible = false;
                            mainlyout.visible = true;

                            //
                            mulRow2.visible = true;
                            mulRow3.visible = true;
                            mulRow4.visible = true;
                        }
                    }
                }
            }
            Component.onCompleted: {
                mainlyout.visible = true;
                oneChannelLyout.visible = false;
                mulChannelLyout.visible = false;
                videoLyout.visible = false;
            }
            MessageDialog {
                id: testDialog
                icon: StandardIcon.Warning
                title: "WARNING"
                text: "come in !"
                standardButtons:    StandardButton.Ok
                onAccepted: {
                    close()
                }
                Component.onCompleted: visible = false
            }
        }
    } // QGCViewPanel
} // QGCView

