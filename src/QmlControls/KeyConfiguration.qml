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
    id:         keyConfigurationView
    viewPanel:  panel

    property real _gap: 15
    property int _channelID: 0
    property int _keyCount: 0
    property int _inUseChannelID: 0
    property int _inUseKeyId: 0
    property int _dupKeyId: 0
    property bool _saveEnabled: false
    property bool _settingEnabled: true
    property int _minValue: 0
    property int _maxValue: 2047

    property var _keyConfiguration: joystickManager.keyConfiguration

    QGCPalette { id: qgcPal; colorGroupEnabled: panel.enabled }

    QGCViewPanel {
        id:             panel
        anchors.fill:   parent
        Rectangle {
            id:              centreWindow
            anchors.fill:    parent
            anchors.margins: ScreenTools.defaultFontPixelWidth
            color:           qgcPal.window

            function loadKeySetting() {
                _settingEnabled = false;
                if (_keyCount !== _keyConfiguration.getKeyCount(_channelID) &&
                    _keyConfiguration.getKeyCount(_channelID) !== 0) {
                    keyCountChangeDialog.open();
                    return;
                }

                if(_keyCount == 1) {
                    singleKeyCombo1.currentIndex = _keyConfiguration.getKeyIndex(_channelID, 1, 1);
                    singleKeySlider1.value = _keyConfiguration.getValue(_channelID, 1, 1);
                    singleKeyLabel1.text = singleKeySlider1.value;
                    singleKeySlider2.value = _keyConfiguration.getDefaultValue(_channelID);
                    singleKeyLabel2.text = singleKeySlider2.value;
                    singleKeyCombox.currentIndex = (_keyConfiguration.getControlMode(_channelID) > 0) ?
                                                   (_keyConfiguration.getControlMode(_channelID) - 1) : 0;

                    mainlayout.visible = false;
                    singleKeyLayout.visible = true;
                } else {
                    multiKeyRow3.visible = false;
                    multiKeyRow4.visible = false;
                    if (_keyCount > 1) {
                        multiKeyRow1.visible = true;
                        multiKeyRow2.visible = true;
                        multiKeyRow1Combox.currentIndex = _keyConfiguration.getKeyIndex(_channelID, 1, _keyCount);
                        multiKeyRow1Slider.value = _keyConfiguration.getValue(_channelID, 1, _keyCount);
                        multiKeyRow1Label.text = multiKeyRow1Slider.value;
                        multiKeyRow2Combox.currentIndex = _keyConfiguration.getKeyIndex(_channelID, 2, _keyCount);
                        multiKeyRow2Slider.value = _keyConfiguration.getValue(_channelID, 2, _keyCount);
                        multiKeyRow2Label.text = multiKeyRow2Slider.value;
                    }
                    if (_keyCount > 2) {
                        multiKeyRow3.visible = true;
                        multiKeyRow3Combox.currentIndex = _keyConfiguration.getKeyIndex(_channelID, 3, _keyCount);
                        multiKeyRow3Slider.value = _keyConfiguration.getValue(_channelID, 3, _keyCount);
                        multiKeyRow3Label.text = multiKeyRow3Slider.value;
                    }
                    if (_keyCount > 3) {
                        multiKeyRow4.visible = true;
                        multiKeyRow4Combox.currentIndex = _keyConfiguration.getKeyIndex(_channelID, 4, _keyCount);
                        multiKeyRow4Slider.value = _keyConfiguration.getValue(_channelID, 4, _keyCount);
                        multiKeyRow4Label.text = multiKeyRow4Slider.value;
                     }
                     mainlayout.visible = false;
                     multiKeyLayout.visible = true;
                }
            }

            function checkBeforeSave() {
                var channelInUse;
                if(_keyCount == 1) {
                    // check duplicated value
                    if(singleKeySlider1.value == singleKeySlider2.value) {
                        dupValueDialog.open();
                        return;
                    }
                    // check key used by other channel
                    channelInUse = _keyConfiguration.keyIsInUse(singleKeyCombo1.currentIndex, singleKeyCombox.currentIndex+1);
                    if(channelInUse !== 0 && channelInUse !== _channelID) {
                        _inUseChannelID = channelInUse;
                        _inUseKeyId = singleKeyCombo1.currentIndex;
                        keyIsOccupiedDialog.open();
                        return;
                    }
                } else {
                    // check duplicated key
                    if(multiKeyRow1Combox.currentIndex == multiKeyRow2Combox.currentIndex ||
                       (multiKeyRow1Combox.currentIndex == multiKeyRow3Combox.currentIndex && multiKeyRow3.visible) ||
                       (multiKeyRow1Combox.currentIndex == multiKeyRow4Combox.currentIndex && multiKeyRow4.visible)) {
                        _dupKeyId = multiKeyRow1Combox.currentIndex;
                        dupKeyDialog.open();
                        return;
                    }
                    if((multiKeyRow2Combox.currentIndex == multiKeyRow3Combox.currentIndex && multiKeyRow3.visible) ||
                       (multiKeyRow2Combox.currentIndex == multiKeyRow4Combox.currentIndex && multiKeyRow4.visible)) {
                        _dupKeyId = multiKeyRow2Combox.currentIndex;
                        dupKeyDialog.open();
                        return;
                    }
                    if((multiKeyRow3Combox.currentIndex == multiKeyRow4Combox.currentIndex && multiKeyRow3.visible && multiKeyRow4.visible)) {
                        _dupKeyId = multiKeyRow3Combox.currentIndex;
                        dupKeyDialog.open();
                        return;
                    }
                    // check duplicated value
                    if(multiKeyRow1Slider.value == multiKeyRow2Slider.value ||
                       (multiKeyRow1Slider.value == multiKeyRow3Slider.value && multiKeyRow3.visible) ||
                       (multiKeyRow1Slider.value == multiKeyRow4Slider.value && multiKeyRow4.visible) ||
                       (multiKeyRow2Slider.value == multiKeyRow3Slider.value && multiKeyRow3.visible) ||
                       (multiKeyRow2Slider.value == multiKeyRow4Slider.value && multiKeyRow4.visible) ||
                       (multiKeyRow3Slider.value == multiKeyRow4Slider.value &&  multiKeyRow3.visible && multiKeyRow4.visible)) {
                        dupValueDialog.open();
                        return;
                    }
                    // check key used by other channel
                    channelInUse = _keyConfiguration.keyIsInUse(multiKeyRow1Combox.currentIndex, 0);
                    if (multiKeyRow1.visible && channelInUse !== 0 && channelInUse !== _channelID) {
                        _inUseChannelID = channelInUse;
                        _inUseKeyId = multiKeyRow1Combox.currentIndex;
                        keyIsOccupiedDialog.open();
                        return;
                    }
                    channelInUse = _keyConfiguration.keyIsInUse(multiKeyRow2Combox.currentIndex, 0);
                    if (multiKeyRow2.visible && channelInUse !== 0 && channelInUse !== _channelID) {
                        _inUseChannelID = channelInUse;
                        _inUseKeyId = multiKeyRow2Combox.currentIndex;
                        keyIsOccupiedDialog.open();
                        return;
                    }
                    channelInUse = _keyConfiguration.keyIsInUse(multiKeyRow3Combox.currentIndex, 0);
                    if (multiKeyRow3.visible && channelInUse !== 0 && channelInUse !== _channelID) {
                        _inUseChannelID = channelInUse;
                        _inUseKeyId = multiKeyRow3Combox.currentIndex;
                        keyIsOccupiedDialog.open();
                        return;
                    }
                    channelInUse = _keyConfiguration.keyIsInUse(multiKeyRow4Combox.currentIndex, 0);
                    if (multiKeyRow4.visible && channelInUse !== 0 && channelInUse !== _channelID) {
                        _inUseChannelID = channelInUse;
                        _inUseKeyId = multiKeyRow4Combox.currentIndex;
                        keyIsOccupiedDialog.open();
                        return;
                    }
                }
                _saveEnabled = true;
            }

            function saveChannelKeySetting() {
                _saveEnabled = false;
                checkBeforeSave();
                if(!_saveEnabled) {
                    return;
                }
                _keyConfiguration.resetKeySetting(_channelID);

                if(_keyCount == 1) {
                    _keyConfiguration.saveSingleKeySetting(singleKeyCombo1.currentIndex,
                                                           singleKeyCombox.currentIndex+1,
                                                           _channelID, singleKeySlider1.value,
                                                           singleKeySlider2.value);
                }
                if(_keyCount > 1) {
                    _keyConfiguration.saveKeySetting(multiKeyRow1Combox.currentIndex, _channelID, multiKeyRow1Slider.value);
                    _keyConfiguration.saveKeySetting(multiKeyRow2Combox.currentIndex, _channelID, multiKeyRow2Slider.value);
                }
                if(_keyCount > 2) {
                    _keyConfiguration.saveKeySetting(multiKeyRow3Combox.currentIndex, _channelID, multiKeyRow3Slider.value);
                }
                if(_keyCount > 3) {
                    _keyConfiguration.saveKeySetting(multiKeyRow4Combox.currentIndex, _channelID, multiKeyRow4Slider.value);
                }
                initChannelStatus();
                _keyConfiguration.setChannelDefaultValue(_channelID);

                singleKeyLayout.visible = false;
                multiKeyLayout.visible = false;
                mainlayout.visible = true;
            }

            function initChannelStatus() {
                ch5Combo.currentIndex = Math.max(_keyConfiguration.getKeyCount(5) - 1, 0);
                ch5Label.text = _keyConfiguration.getKeySettingString(5);
                ch6Combo.currentIndex = Math.max(_keyConfiguration.getKeyCount(6) - 1, 0);
                ch6Label.text = _keyConfiguration.getKeySettingString(6);
                ch7Combo.currentIndex = Math.max(_keyConfiguration.getKeyCount(7) - 1, 0)
                ch7Label.text = _keyConfiguration.getKeySettingString(7);
                ch8Combo.currentIndex = Math.max(_keyConfiguration.getKeyCount(8) - 1, 0)
                ch8Label.text = _keyConfiguration.getKeySettingString(8);
                ch9Combo.currentIndex = Math.max(_keyConfiguration.getKeyCount(9) - 1, 0)
                ch9Label.text = _keyConfiguration.getKeySettingString(9);
            }


            Row {
                id:             mainlayout
                anchors.fill:   parent
                anchors.leftMargin: 20
                anchors.topMargin:  100
                Column{
                    spacing: 22
                    Row{
                        spacing: 100
                        QGCLabel {
                            text: qsTr("Channel")
                        }
                        QGCLabel {
                            text: qsTr("Count of keys")
                        }
                    }
                    Row{
                        spacing: 150
                        QGCLabel {
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                            text:              qsTr("CH5")
                        }

                        QGCComboBox {
                            id:         ch5Combo
                            model:      [qsTr("1"), qsTr("2"), qsTr("3"), qsTr("4")]
                            width:      200
                        }

                        QGCButton {
                            id:        ch5Button
                            text:      qsTr("Settings")
                            onClicked:{
                                _channelID = 5;
                                _keyCount = ch5Combo.currentIndex + 1;
                                centreWindow.loadKeySetting();
                            }
                        }
                        QGCLabel {
                            id:                ch5Label
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }
                    }
                    Row {
                        spacing: 150
                        QGCLabel {
                            text:              qsTr("CH6")
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }

                        QGCComboBox {
                            id:         ch6Combo
                            model:      [qsTr("1"), qsTr("2"), qsTr("3"), qsTr("4")]
                            width:      200
                        }

                        QGCButton {
                            id:        ch6Button
                            text:      qsTr("Settings")
                            onClicked: {
                                _channelID = 6;
                                _keyCount = ch6Combo.currentIndex + 1;
                                centreWindow.loadKeySetting();
                            }
                        }
                        QGCLabel {
                            id:                ch6Label
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }
                    }

                    Row {
                        spacing: 150
                        QGCLabel {
                            text:              qsTr("CH7")
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }

                        QGCComboBox {
                            id:         ch7Combo
                            model:      [qsTr("1"), qsTr("2"), qsTr("3"), qsTr("4")]
                            width:      200
                        }

                        QGCButton {
                            id:        ch7Button
                            text:      qsTr("Settings")
                            onClicked: {
                                _channelID = 7;
                                _keyCount = ch7Combo.currentIndex + 1;
                                centreWindow.loadKeySetting();
                            }
                        }
                        QGCLabel {
                            id:                ch7Label
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }
                    }

                    Row{
                        spacing: 150
                        QGCLabel {
                            text:              qsTr("CH8")
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }

                        QGCComboBox {
                            id:         ch8Combo
                            model:      [qsTr("1"), qsTr("2"), qsTr("3"), qsTr("4")]
                            width:      200
                        }

                        QGCButton {
                            id:        ch8Button
                            text:      qsTr("Settings")
                            onClicked: {
                                _channelID = 8;
                                _keyCount = ch8Combo.currentIndex + 1;
                                centreWindow.loadKeySetting();
                            }
                        }
                        QGCLabel {
                            id:                ch8Label
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }
                    }

                    Row{
                        spacing: 150
                        QGCLabel {
                            text:              qsTr("CH9")
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }

                        QGCComboBox {
                            id:         ch9Combo
                            model:      [qsTr("1"), qsTr("2"), qsTr("3"), qsTr("4")]
                            width:      200
                        }

                        QGCButton {
                            id:        ch9Button
                            text:      qsTr("Settings")
                            onClicked: {
                                _channelID = 9;
                                _keyCount = ch9Combo.currentIndex + 1;
                                centreWindow.loadKeySetting();
                            }
                        }
                        QGCLabel {
                            id:                ch9Label
                            anchors.top:       parent.top
                            anchors.topMargin: _gap
                        }
                    }
                }
            }

            Column{
                id:                 singleKeyLayout
                anchors.fill:       parent
                anchors.leftMargin: 20
                anchors.topMargin:  100
                spacing:            80
                Row{
                    id:      singleKeyRow1
                    spacing: 100
                    QGCLabel {
                        id:                  singleKeyLabel
                        text:                qsTr("CH" + _channelID)
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                         width:              40
                    }
                    QGCComboBox {
                        id:         singleKeyCombo1
                        model:      [qsTr("A short"),qsTr("A long"), qsTr("B short"),qsTr("B long"), qsTr("C short"),qsTr("C long"), qsTr("D short"),qsTr("D long")]
                        width:      300
                    }
                    QGCLabel {
                        id:                  singleKeyLabel1
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                        width:               40
                    }
                    QGCSlider {
                        id:                  singleKeySlider1
                        orientation:         Qt.Horizontal
                        minimumValue:        _minValue
                        maximumValue:        _maxValue
                        stepSize:            1
                        width:               800

                        onValueChanged: {
                            singleKeyLabel1.text = singleKeySlider1.value;
                        }
                    }
                }
                Row{
                    id:      singleKeyRow2
                    spacing: 100
                    QGCLabel {
                        text:                qsTr(" ")
                        width:               40
                    }
                    QGCLabel {
                        text:                qsTr("Start value")
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                        width:               300
                    }
                    QGCLabel {
                        id:                  singleKeyLabel2
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                        width:               40
                    }
                    QGCSlider {
                        id:                   singleKeySlider2
                        orientation:          Qt.Horizontal
                        minimumValue:         _minValue
                        maximumValue:         _maxValue
                        stepSize:             1
                        width:                800

                        onValueChanged: {
                            singleKeyLabel2.text = singleKeySlider2.value;
                        }
                    }
                }
                Row{
                    id:      singleKeyRow3
                    spacing: 100
                    QGCLabel {
                        text:                qsTr(" ")
                        width:               40
                    }
                    QGCLabel {
                        text:                qsTr("Control mode")
                        width:               300
                    }
                    QGCComboBox {
                        id:         singleKeyCombox
                        model:      [qsTr("Keep after key release"),qsTr("Reset after key release")]
                        width:      500
                    }
                }
                Row{
                    spacing: 200
                    QGCLabel {
                        text:      qsTr(" ")
                        width:     40
                    }
                    QGCButton {
                        id:        singleKeySaveButton
                        text:      qsTr("Save")
                        onClicked: {
                            if (singleKeyCombox.currentIndex == 1) {
                                useBothPressDialog.open();
                            } else {
                                centreWindow.saveChannelKeySetting();
                            }

                        }
                    }
                    QGCButton {
                        id:        singleKeyResetButton
                        text:      qsTr("Reset")
                        onClicked: {
                            channelResetDialog.open();
                        }
                    }
                    QGCButton {
                        id:        singleKeyCancelButton
                        text:      qsTr("Cancel")
                        onClicked: {
                            singleKeyLayout.visible = false;
                            mainlayout.visible = true;
                        }
                    }
                }
            }

            Column{
                id:                 multiKeyLayout
                anchors.fill:       parent
                anchors.leftMargin: 20
                anchors.topMargin:  100
                spacing:            30
                Row{
                    id:      multiKeyRow1
                    spacing: 100
                    QGCLabel {
                        id:                  multiKeyLabel
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                        width:               40
                        text:                qsTr("CH" + _channelID)
                    }
                    QGCComboBox {
                        id:         multiKeyRow1Combox
                        model:      [qsTr("A short"),qsTr("A long"), qsTr("B short"),qsTr("B long"), qsTr("C short"),qsTr("C long"), qsTr("D short"),qsTr("D long")]
                        width:      300
                    }
                    QGCLabel {
                        id:                  multiKeyRow1Label
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                        width:               40
                    }
                    QGCSlider {
                        id:                  multiKeyRow1Slider
                        orientation:         Qt.Horizontal
                        minimumValue:        _minValue
                        maximumValue:        _maxValue
                        stepSize:            1
                        width:               800

                        onValueChanged: {
                            multiKeyRow1Label.text = multiKeyRow1Slider.value;
                        }
                    }
                }
                Row{
                    id:      multiKeyRow2
                    spacing: 100
                    QGCLabel {
                        text:       qsTr(" ")
                        width:      40
                    }
                    QGCComboBox {
                        id:         multiKeyRow2Combox
                        model:      [qsTr("A short"),qsTr("A long"), qsTr("B short"),qsTr("B long"), qsTr("C short"),qsTr("C long"), qsTr("D short"),qsTr("D long")]
                        width:      300
                    }
                    QGCLabel {
                        id:                  multiKeyRow2Label
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                        width:               40
                    }
                    QGCSlider {
                        id:                  multiKeyRow2Slider
                        orientation:         Qt.Horizontal
                        minimumValue:        _minValue
                        maximumValue:        _maxValue
                        stepSize:            1
                        width:               800

                        onValueChanged: {
                            multiKeyRow2Label.text = multiKeyRow2Slider.value;
                        }
                    }
                }
                Row{
                    id:      multiKeyRow3
                    spacing: 100
                    QGCLabel {
                        text:       qsTr(" ")
                        width:      40
                    }
                    QGCComboBox {
                        id:         multiKeyRow3Combox
                        model:      [qsTr("A short"),qsTr("A long"), qsTr("B short"),qsTr("B long"), qsTr("C short"),qsTr("C long"), qsTr("D short"),qsTr("D long")]
                        width:      300
                    }
                    QGCLabel {
                        id:                  multiKeyRow3Label
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                        width:               40
                    }
                    QGCSlider {
                        id:                  multiKeyRow3Slider
                        orientation:         Qt.Horizontal
                        minimumValue:        _minValue
                        maximumValue:        _maxValue
                        stepSize:            1
                        width:               800

                        onValueChanged: {
                            multiKeyRow3Label.text = multiKeyRow3Slider.value;
                        }
                    }
                }
                Row{
                    id:      multiKeyRow4
                    spacing: 100
                    QGCLabel {
                        text:       qsTr(" ")
                        width:      40
                    }
                    QGCComboBox {
                        id:         multiKeyRow4Combox
                        model:      [qsTr("A short"),qsTr("A long"), qsTr("B short"),qsTr("B long"), qsTr("C short"),qsTr("C long"), qsTr("D short"),qsTr("D long")]
                        width:      300
                    }
                    QGCLabel {
                        id:                  multiKeyRow4Label
                        anchors.top:         parent.top
                        anchors.topMargin:   _gap
                        width:               40
                    }
                    QGCSlider {
                        id:                   multiKeyRow4Slider
                        orientation:          Qt.Horizontal
                        minimumValue:         _minValue
                        maximumValue:         _maxValue
                        stepSize:             1
                        width:                800

                        onValueChanged: {
                            multiKeyRow4Label.text = multiKeyRow4Slider.value;
                        }
                    }
                }
                Row{
                    spacing: 200
                    QGCLabel {
                        text:       qsTr(" ")
                        width:      40
                    }

                    QGCButton {
                        id:        mulSaveButton
                        text:      qsTr("Save")
                        onClicked: {
                            centreWindow.saveChannelKeySetting();
                        }
                    }
                    QGCButton {
                        id:        mulResetButton
                        text:      qsTr("Reset")
                        onClicked: {
                            channelResetDialog.open();
                        }
                    }
                    QGCButton {
                        id:        mulCancelButton
                        text:      qsTr("Cancel")
                        onClicked: {
                            multiKeyLayout.visible = false;
                            mainlayout.visible = true;
                        }
                    }
                }
            }

            Component.onCompleted: {
                mainlayout.visible = true;
                singleKeyLayout.visible = false;
                multiKeyLayout.visible = false;
                centreWindow.initChannelStatus();
            }

            MessageDialog {
                id:         keyIsOccupiedDialog
                visible:    false
                icon:       StandardIcon.Warning
                standardButtons: StandardButton.Yes | StandardButton.No
                title:      qsTr("NOTICE")
                text:       qsTr("\"%1\" has been used by CH%2. Confirm to clear configuration of CH%2 and continue?")
                                .arg(_keyConfiguration.getKeyStringFromIndex(_inUseKeyId)).arg(_inUseChannelID)
                onYes: {
                    _keyConfiguration.resetKeySetting(_inUseChannelID);
                    centreWindow.initChannelStatus();
                    centreWindow.saveChannelKeySetting();
                }
            }

            MessageDialog {
                id:         dupKeyDialog
                visible:    false
                icon:       StandardIcon.Warning
                standardButtons: StandardButton.Yes
                title:      qsTr("NOTICE")
                text:       qsTr("\"%1\" is defined for multiple values, please check.")
                                .arg(_keyConfiguration.getKeyStringFromIndex(_dupKeyId))
            }

            MessageDialog {
                id:         useBothPressDialog
                visible:    false
                icon:       StandardIcon.Warning
                standardButtons: StandardButton.Yes | StandardButton.No
                title:      qsTr("NOTICE")
                text:       qsTr("In this control mode, both short press and long press of the key are occupied. Continue?")
                onYes: {
                    centreWindow.saveChannelKeySetting();
                }
                onNo: {
                }
            }

            MessageDialog {
                id:         keyCountChangeDialog
                visible:    false
                icon:       StandardIcon.Warning
                standardButtons: StandardButton.Yes | StandardButton.No
                title:      qsTr("NOTICE")
                text:       qsTr("The count of key for CH%1 is changed. Confirm to clear configuration of CH%1 and continue?").arg(_channelID)
                onYes: {
                    _keyConfiguration.resetKeySetting(_channelID);
                    centreWindow.initChannelStatus();
                    centreWindow.loadKeySetting();
                }
                onNo: {
                    centreWindow.initChannelStatus();
                }
            }

            MessageDialog {
                id:         dupValueDialog
                visible:    false
                icon:       StandardIcon.Warning
                standardButtons: StandardButton.Yes
                title:      qsTr("NOTICE")
                text:       qsTr("There are duplicated values, please check.")
            }

            MessageDialog {
                id:         channelResetDialog
                visible:    false
                icon:       StandardIcon.Warning
                standardButtons: StandardButton.Yes | StandardButton.No
                title:      qsTr("NOTICE")
                text:       qsTr("Confirm to clear configuration of CH%1?").arg(_channelID)
                onYes: {
                    _keyConfiguration.resetKeySetting(_channelID);
                    centreWindow.initChannelStatus();
                    mainlayout.visible = true;
                    singleKeyLayout.visible = false;
                    multiKeyLayout.visible = false;
                }
            }
        }
    } // QGCViewPanel
} // QGCView

