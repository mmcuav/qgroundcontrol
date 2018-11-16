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


    property int __chNumber: 0
    property int __comboxIndex: 0


    property string __keyIndexString
    property int __whichComboxStatus :0
    property int __resetChValue: 0


    property int __prevIndex: 0
    property int __currentIndex: 0

    property bool __saveEnable: true

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
                        pD2dInforData.getChStr(__chNumber);
                        videoCombox.currentIndex = pD2dInforData.getComboxList(1);
                        //show
                        mainlyout.visible = false;
                        videoLyout.visible = true;
                    }
                    else if(__comboxIndex == 1)
                    {
                        pD2dInforData.getChStr(__chNumber);
                        oneChannelCombo1.currentIndex = pD2dInforData.getComboxList(1);

                        if(__chNumber == 5)
                        {
                            oneChannelLabel1.text = pD2dInforData.getKeyValue("CH5V1");
                            oneChannelSlider1.value = pD2dInforData.getKeyValue("CH5V1");

                            oneChannelLabel2.text = pD2dInforData.getKeyValue("CH5V2");
                            oneChannelSlider2.value = pD2dInforData.getKeyValue("CH5V2");

                            oneChannelCombox.currentIndex = pD2dInforData.getKeyValue("CH5M");
                        }
                        else if(__chNumber == 6)
                        {
                            oneChannelLabel1.text = pD2dInforData.getKeyValue("CH6V1");
                            oneChannelSlider1.value = pD2dInforData.getKeyValue("CH6V1");

                            oneChannelLabel2.text = pD2dInforData.getKeyValue("CH6V2");
                            oneChannelSlider2.value = pD2dInforData.getKeyValue("CH6V2");

                            oneChannelCombox.currentIndex = pD2dInforData.getKeyValue("CH6M");
                        }
                        else if(__chNumber == 7)
                        {
                            oneChannelLabel1.text = pD2dInforData.getKeyValue("CH7V1");
                            oneChannelSlider1.value = pD2dInforData.getKeyValue("CH7V1");

                            oneChannelLabel2.text = pD2dInforData.getKeyValue("CH7V2");
                            oneChannelSlider2.value = pD2dInforData.getKeyValue("CH7V2");

                            oneChannelCombox.currentIndex = pD2dInforData.getKeyValue("CH7M");
                        }
                        else if(__chNumber == 8)
                        {
                            oneChannelLabel1.text = pD2dInforData.getKeyValue("CH8V1");
                            oneChannelSlider1.value = pD2dInforData.getKeyValue("CH8V1");

                            oneChannelLabel2.text = pD2dInforData.getKeyValue("CH8V2");
                            oneChannelSlider2.value = pD2dInforData.getKeyValue("CH8V2");

                            oneChannelCombox.currentIndex = pD2dInforData.getKeyValue("CH8M");
                        }
                        else if(__chNumber == 9)
                        {
                            oneChannelLabel1.text = pD2dInforData.getKeyValue("CH9V1");
                            oneChannelSlider1.value = pD2dInforData.getKeyValue("CH9V1");

                            oneChannelLabel2.text = pD2dInforData.getKeyValue("CH9V2");
                            oneChannelSlider2.value = pD2dInforData.getKeyValue("CH9V2");

                            oneChannelCombox.currentIndex = pD2dInforData.getKeyValue("CH9M");
                        }
                        //show
                        mainlyout.visible = false;
                        oneChannelLyout.visible = true;

                    }
                    else
                    {
                        if(__comboxIndex == 2)
                        {
                            mulRow4.visible = false;
                            mulRow3.visible = false;

                            pD2dInforData.getChStr(__chNumber);
                            mulRow1Combox.currentIndex = pD2dInforData.getComboxList(1);
                            mulRow2Combox.currentIndex = pD2dInforData.getComboxList(2);
                            //
                            if(__chNumber == 5)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH5V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH5V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH5V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH5V2");
                            }
                            else if(__chNumber == 6)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH6V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH6V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH6V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH6V2");
                            }
                            else if(__chNumber == 7)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH7V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH7V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH7V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH7V2");
                            }
                            else if(__chNumber == 8)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH8V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH8V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH8V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH8V2");
                            }
                            else if(__chNumber == 9)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH9V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH9V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH9V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH9V2");
                            }
                        }
                        else if(__comboxIndex == 3)
                        {
                            mulRow4.visible = false;

                            pD2dInforData.getChStr(__chNumber);
                            mulRow1Combox.currentIndex = pD2dInforData.getComboxList(1);
                            mulRow2Combox.currentIndex = pD2dInforData.getComboxList(2);
                            mulRow3Combox.currentIndex = pD2dInforData.getComboxList(3);
                            //
                            if(__chNumber == 5)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH5V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH5V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH5V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH5V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH5V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH5V3");
                            }
                            else if(__chNumber == 6)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH6V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH6V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH6V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH6V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH6V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH6V3");
                            }
                            else if(__chNumber == 7)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH7V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH7V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH7V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH7V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH7V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH7V3");
                            }
                            else if(__chNumber == 8)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH8V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH8V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH8V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH8V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH8V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH8V3");
                            }
                            else if(__chNumber == 9)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH9V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH9V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH9V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH9V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH9V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH9V3");
                            }
                        }
                        else
                        {
                            pD2dInforData.getChStr(__chNumber);
                            mulRow1Combox.currentIndex = pD2dInforData.getComboxList(1);
                            mulRow2Combox.currentIndex = pD2dInforData.getComboxList(2);
                            mulRow3Combox.currentIndex = pD2dInforData.getComboxList(3);
                            mulRow4Combox.currentIndex = pD2dInforData.getComboxList(4);

                            if(__chNumber == 5)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH5V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH5V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH5V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH5V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH5V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH5V3");

                                mulRow4Label.text = pD2dInforData.getKeyValue("CH5V4");
                                mulRow4Slider.value = pD2dInforData.getKeyValue("CH5V4");
                            }
                            else if(__chNumber == 6)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH6V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH6V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH6V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH6V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH6V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH6V3");

                                mulRow4Label.text = pD2dInforData.getKeyValue("CH6V4");
                                mulRow4Slider.value = pD2dInforData.getKeyValue("CH6V4");
                            }
                            else if(__chNumber == 7)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH7V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH7V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH7V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH7V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH7V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH7V3");

                                mulRow4Label.text = pD2dInforData.getKeyValue("CH7V4");
                                mulRow4Slider.value = pD2dInforData.getKeyValue("CH7V4");
                            }
                            else if(__chNumber == 8)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH8V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH8V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH8V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH8V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH8V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH8V3");

                                mulRow4Label.text = pD2dInforData.getKeyValue("CH8V4");
                                mulRow4Slider.value = pD2dInforData.getKeyValue("CH8V4");
                            }
                            else if(__chNumber == 9)
                            {
                                mulRow1Label.text = pD2dInforData.getKeyValue("CH9V1");
                                mulRow1Slider.value = pD2dInforData.getKeyValue("CH9V1");

                                mulRow2Label.text = pD2dInforData.getKeyValue("CH9V2");
                                mulRow2Slider.value = pD2dInforData.getKeyValue("CH9V2");

                                mulRow3Label.text = pD2dInforData.getKeyValue("CH9V3");
                                mulRow3Slider.value = pD2dInforData.getKeyValue("CH9V3");

                                mulRow4Label.text = pD2dInforData.getKeyValue("CH9V4");
                                mulRow4Slider.value = pD2dInforData.getKeyValue("CH9V4");
                            }
                        }
                        mainlyout.visible = false;
                        mulChannelLyout.visible = true;
                    }
                }
            }

            function checkEnableSave()
            {
                if(__chNumber == 5)
                {
                    if(ch5Combo.currentIndex == 0)
                    {
                        if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex)) !== 0)
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch5Combo.currentIndex == 1)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch5Combo.currentIndex == 2)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch5Combo.currentIndex == 3)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                }
                else if(__chNumber == 6)
                {
                    if(ch6Combo.currentIndex == 0)
                    {
                        if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex)) !== 0)
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch6Combo.currentIndex == 1)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch6Combo.currentIndex == 2)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch6Combo.currentIndex == 3)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                }
                else if(__chNumber == 7)
                {
                    if(ch7Combo.currentIndex == 0)
                    {
                        if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex)) !== 0)
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch7Combo.currentIndex == 1)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch7Combo.currentIndex == 2)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch7Combo.currentIndex == 3)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                }
                else if(__chNumber == 8)
                {
                    if(ch8Combo.currentIndex == 0)
                    {
                        if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex)) !== 0)
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch8Combo.currentIndex == 1)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch8Combo.currentIndex == 2)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch8Combo.currentIndex == 3)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                }
                else if(__chNumber == 9)
                {
                    if(ch9Combo.currentIndex == 0)
                    {
                        if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex)) !== 0)
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch9Combo.currentIndex == 1)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch9Combo.currentIndex == 2)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                    else if(ch9Combo.currentIndex == 3)
                    {
                        if((pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex)) !== 0)&&
                                (pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex)) !== 0))
                        {
                            __saveEnable = false;
                        }
                    }
                }
                else if(__chNumber == 10)
                {
                    if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(videoCombox.currentIndex)) !== 0)
                    {
                        __saveEnable = false;
                    }
                }
            }

            function saveChSetting() {
                checkEnableSave();
                if(!__saveEnable)
                {
                    enableSaveDialog.open();
                    return;
                }

                if(__chNumber == 5)
                {
                    pD2dInforData.clearChSetting(5);
                    if(ch5Combo.currentIndex == 0)
                    {
                        ch5Label.text = oneChannelCombo1.currentText + "," + oneChannelCombox.currentText;

                        pD2dInforData.setKeyValue("CH5",1);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex),5);

                        pD2dInforData.setKeyValue("CH5V1",oneChannelSlider1.value);
                        pD2dInforData.setKeyValue("CH5V2",oneChannelSlider2.value);
                        pD2dInforData.setKeyValue("CH5M",oneChannelCombox.currentIndex);
                    }
                    else if(ch5Combo.currentIndex == 1)
                    {
                        ch5Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                        pD2dInforData.setKeyValue("CH5",2);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),5);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),5);

                        pD2dInforData.setKeyValue("CH5V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH5V2",mulRow2Slider.value);
                    }
                    else if(ch5Combo.currentIndex == 2)
                    {
                        ch5Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                        pD2dInforData.setKeyValue("CH5",3);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),5);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),5);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),5);

                        pD2dInforData.setKeyValue("CH5V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH5V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH5V3",mulRow3Slider.value);
                    }
                    else if(ch5Combo.currentIndex == 3)
                    {
                        ch5Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                        pD2dInforData.setKeyValue("CH5",4);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),5);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),5);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),5);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex),5);

                        pD2dInforData.setKeyValue("CH5V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH5V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH5V3",mulRow3Slider.value);
                        pD2dInforData.setKeyValue("CH5V4",mulRow4Slider.value);
                    }
                }
                else if(__chNumber == 6)
                {
                    pD2dInforData.clearChSetting(6);
                    if(ch6Combo.currentIndex == 0)
                    {
                        ch6Label.text = oneChannelCombo1.currentText + "," + oneChannelCombox.currentText;
                        pD2dInforData.setKeyValue("CH6",1);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex),6);
                        pD2dInforData.setKeyValue("CH6V1",oneChannelSlider1.value);
                        pD2dInforData.setKeyValue("CH6V2",oneChannelSlider2.value);
                        pD2dInforData.setKeyValue("CH6M",oneChannelCombox.currentIndex);
                    }
                    else if(ch6Combo.currentIndex == 1)
                    {
                        ch6Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                        pD2dInforData.setKeyValue("CH6",2);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),6);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),6);

                        pD2dInforData.setKeyValue("CH6V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH6V2",mulRow2Slider.value);
                    }
                    else if(ch6Combo.currentIndex == 2)
                    {
                        ch6Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                        pD2dInforData.setKeyValue("CH6",3);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),6);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),6);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),6);

                        pD2dInforData.setKeyValue("CH6V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH6V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH6V3",mulRow3Slider.value);
                    }
                    else if(ch6Combo.currentIndex == 3)
                    {
                        ch6Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                        pD2dInforData.setKeyValue("CH6",4);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),6);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),6);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),6);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex),6);

                        pD2dInforData.setKeyValue("CH6V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH6V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH6V3",mulRow3Slider.value);
                        pD2dInforData.setKeyValue("CH6V4",mulRow4Slider.value);
                    }
                }
                else if(__chNumber == 7)
                {
                    pD2dInforData.clearChSetting(7);
                    if(ch7Combo.currentIndex == 0)
                    {
                        ch7Label.text = oneChannelCombo1.currentText + "," + oneChannelCombox.currentText;
                        pD2dInforData.setKeyValue("CH7",1);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex),7);
                        pD2dInforData.setKeyValue("CH7V1",oneChannelSlider1.value);
                        pD2dInforData.setKeyValue("CH7V2",oneChannelSlider2.value);
                        pD2dInforData.setKeyValue("CH7M",oneChannelCombox.currentIndex);
                    }
                    else if(ch7Combo.currentIndex == 1)
                    {
                        ch7Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                        pD2dInforData.setKeyValue("CH7",2);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),7);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),7);

                        pD2dInforData.setKeyValue("CH7V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH7V2",mulRow2Slider.value);
                    }
                    else if(ch7Combo.currentIndex == 2)
                    {
                        ch7Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                        pD2dInforData.setKeyValue("CH7",3);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),7);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),7);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),7);

                        pD2dInforData.setKeyValue("CH7V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH7V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH7V3",mulRow3Slider.value);
                    }
                    else if(ch7Combo.currentIndex == 3)
                    {
                        ch7Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                        pD2dInforData.setKeyValue("CH7",4);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),7);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),7);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),7);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex),7);

                        pD2dInforData.setKeyValue("CH7V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH7V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH7V3",mulRow3Slider.value);
                        pD2dInforData.setKeyValue("CH7V4",mulRow4Slider.value);
                    }
                }
                else if(__chNumber == 8)
                {
                    pD2dInforData.clearChSetting(8);
                    if(ch8Combo.currentIndex == 0)
                    {
                        ch8Label.text = oneChannelCombo1.currentText + "," + oneChannelCombox.currentText;
                        pD2dInforData.setKeyValue("CH8",1);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex),8);
                        pD2dInforData.setKeyValue("CH8V1",oneChannelSlider1.value);
                        pD2dInforData.setKeyValue("CH8V2",oneChannelSlider2.value);
                        pD2dInforData.setKeyValue("CH8M",oneChannelCombox.currentIndex);
                    }
                    else if(ch8Combo.currentIndex == 1)
                    {
                        ch8Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                        pD2dInforData.setKeyValue("CH8",2);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),8);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),8);

                        pD2dInforData.setKeyValue("CH8V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH8V2",mulRow2Slider.value);
                    }
                    else if(ch8Combo.currentIndex == 2)
                    {
                        ch8Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                        pD2dInforData.setKeyValue("CH8",3);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),8);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),8);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),8);

                        pD2dInforData.setKeyValue("CH8V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH8V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH8V3",mulRow3Slider.value);
                    }
                    else if(ch8Combo.currentIndex == 3)
                    {
                        ch8Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                        pD2dInforData.setKeyValue("CH8",4);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),8);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),8);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),8);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex),8);

                        pD2dInforData.setKeyValue("CH8V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH8V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH8V3",mulRow3Slider.value);
                        pD2dInforData.setKeyValue("CH8V4",mulRow4Slider.value);
                    }
                }
                else if(__chNumber == 9)
                {
                    pD2dInforData.clearChSetting(9);
                    if(ch9Combo.currentIndex == 0)
                    {
                        ch9Label.text = oneChannelCombo1.currentText + "," + oneChannelCombox.currentText;
                        pD2dInforData.setKeyValue("CH9",1);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(oneChannelCombo1.currentIndex),9);
                        pD2dInforData.setKeyValue("CH9V1",oneChannelSlider1.value);
                        pD2dInforData.setKeyValue("CH9V2",oneChannelSlider2.value);
                        pD2dInforData.setKeyValue("CH9M",oneChannelCombox.currentIndex);
                    }
                    else if(ch9Combo.currentIndex == 1)
                    {
                        ch9Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText;
                        pD2dInforData.setKeyValue("CH9",2);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),9);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),9);

                        pD2dInforData.setKeyValue("CH9V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH9V2",mulRow2Slider.value);
                    }
                    else if(ch9Combo.currentIndex == 2)
                    {
                        ch9Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText;
                        pD2dInforData.setKeyValue("CH9",3);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),9);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),9);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),9);

                        pD2dInforData.setKeyValue("CH9V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH9V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH9V3",mulRow3Slider.value);
                    }
                    else if(ch9Combo.currentIndex == 3)
                    {
                        ch9Label.text = mulRow1Combox.currentText + "," + mulRow2Combox.currentText + "," + mulRow3Combox.currentText  + "," + mulRow4Combox.currentText;
                        pD2dInforData.setKeyValue("CH9",4);

                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow1Combox.currentIndex),9);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow2Combox.currentIndex),9);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow3Combox.currentIndex),9);
                        pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(mulRow4Combox.currentIndex),9);

                        pD2dInforData.setKeyValue("CH9V1",mulRow1Slider.value);
                        pD2dInforData.setKeyValue("CH9V2",mulRow2Slider.value);
                        pD2dInforData.setKeyValue("CH9V3",mulRow3Slider.value);
                        pD2dInforData.setKeyValue("CH9V4",mulRow4Slider.value);
                    }
                }
                else if(__chNumber == 10)
                {
                    pD2dInforData.clearChSetting(10);
                    videoLabel.text = videoCombox.currentText;

                    pD2dInforData.setKeyValue("VIDEO",1);
                    pD2dInforData.setKeyValue(pD2dInforData.getKeyNameFromCombox(videoCombox.currentIndex),10);
                }
            }

            function resetChStatus(){
                if(__resetChValue == 5)
                {
                    ch5Combo.currentIndex = 0;
                    ch5Label.text = "undefined";
                }
                else if(__resetChValue == 6)
                {
                    ch6Combo.currentIndex = 0;
                    ch6Label.text = "undefined";
                }
                else if(__resetChValue == 7)
                {
                    ch7Combo.currentIndex = 0;
                    ch7Label.text = "undefined";
                }
                else if(__resetChValue == 8)
                {
                    ch8Combo.currentIndex = 0;
                    ch8Label.text = "undefined";
                }
                else if(__resetChValue == 9)
                {
                    ch9Combo.currentIndex = 0;
                    ch9Label.text = "undefined";
                }
                else if(__resetChValue == 10)
                {
                    videoLabel.text = "undefined";
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
                        model:      [qsTr("A long"),qsTr("A short"), qsTr("B long"),qsTr("B  short"), qsTr("C long"),qsTr("C  short"), qsTr("D long"),qsTr("D  short")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                                __prevIndex = oneChannelCombo1.currentIndex;
                                __currentIndex= index;
                                __whichComboxStatus = 0;
                                if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(index)) !== 0)
                                {
                                    messageDialog.open();
                                }
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
                        model:      [qsTr("Loosen to reset"),qsTr("Loosen to keep")]
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
                        model:      [qsTr("A long"),qsTr("A  short"), qsTr("B long"),qsTr("B  short"), qsTr("C long"),qsTr("C  short"), qsTr("D long"),qsTr("D  short")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                                __prevIndex = mulRow1Combox.currentIndex;
                                __currentIndex= index;
                                __whichComboxStatus = 1;
                                if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(index)) !== 0)
                                {
                                    messageDialog.open();
                                }
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
                        model:      [qsTr("A long"),qsTr("A  short"), qsTr("B long"),qsTr("B  short"), qsTr("C long"),qsTr("C  short"), qsTr("D long"),qsTr("D  short")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                                __prevIndex = mulRow2Combox.currentIndex;
                                __currentIndex= index;
                                __whichComboxStatus = 2;
                                if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(index)) !== 0)
                                {
                                    messageDialog.open();
                                }
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
                        model:      [qsTr("A long"),qsTr("A  short"), qsTr("B long"),qsTr("B  short"), qsTr("C long"),qsTr("C  short"), qsTr("D long"),qsTr("D  short")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                                __prevIndex = mulRow3Combox.currentIndex;
                                __currentIndex= index;
                                __whichComboxStatus = 3;
                                if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(index)) !== 0)
                                {
                                    messageDialog.open();
                                }
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
                        model:      [qsTr("A long"),qsTr("A  short"), qsTr("B long"),qsTr("B  short"), qsTr("C long"),qsTr("C  short"), qsTr("D long"),qsTr("D  short")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                                __prevIndex = mulRow4Combox.currentIndex;
                                __currentIndex= index;
                                __whichComboxStatus = 4;
                                if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(index)) !== 0)
                                {
                                    messageDialog.open();
                                }
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
                        model:      [qsTr("A long"),qsTr("A  short"), qsTr("B long"),qsTr("B  short"), qsTr("C long"),qsTr("C  short"), qsTr("D long"),qsTr("D  short")]
                        width:      ScreenTools.defaultFontPixelWidth*12
                        onActivated: {
                            if (index != -1) {
                                __prevIndex = videoCombox.currentIndex;
                                __currentIndex= index;
                                __whichComboxStatus = 5;
                                if(pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(index)) !== 0)
                                {
                                    messageDialog.open();
                                }
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

                if(pD2dInforData.getKeyValue("CH5") !== 0)
                {
                    ch5Combo.currentIndex = pD2dInforData.getKeyValue("CH5") - 1;
                    ch5Label.text = pD2dInforData.getChStr(5);

                    if(ch5Combo.currentIndex == 0)
                    {
                        ch5Label.text +=",";
                        ch5Label.text += pD2dInforData.getChModelStr("CH5M");
                    }
                }
                else
                {
                    ch5Label.text = "undefined";
                }

                if(pD2dInforData.getKeyValue("CH6") !== 0)
                {
                    ch6Combo.currentIndex = pD2dInforData.getKeyValue("CH6") - 1;
                    ch6Label.text = pD2dInforData.getChStr(6);

                    if(ch6Combo.currentIndex == 0)
                    {
                        ch6Label.text +=",";
                        ch6Label.text += pD2dInforData.getChModelStr("CH6M");
                    }
                }
                else
                {
                    ch6Label.text = "undefined";
                }

                if(pD2dInforData.getKeyValue("CH7") !== 0)
                {
                    ch7Combo.currentIndex = pD2dInforData.getKeyValue("CH7") - 1;
                    ch7Label.text = pD2dInforData.getChStr(7);

                    if(ch7Combo.currentIndex == 0)
                    {
                        ch7Label.text +=",";
                        ch7Label.text += pD2dInforData.getChModelStr("CH7M");
                    }
                }
                else
                {
                    ch7Label.text = "undefined";
                }

                if(pD2dInforData.getKeyValue("CH8") !== 0)
                {
                    ch8Combo.currentIndex = pD2dInforData.getKeyValue("CH8") - 1;
                    ch8Label.text = pD2dInforData.getChStr(8);

                    if(ch8Combo.currentIndex == 0)
                    {
                        ch8Label.text +=",";
                        ch8Label.text += pD2dInforData.getChModelStr("CH8M");
                    }
                }
                else
                {
                    ch8Label.text = "undefined";
                }

                if(pD2dInforData.getKeyValue("CH9") !== 0)
                {
                    ch9Combo.currentIndex = pD2dInforData.getKeyValue("CH9") - 1;
                    ch9Label.text = pD2dInforData.getChStr(9);

                    if(ch9Combo.currentIndex == 0)
                    {
                        ch9Label.text +=",";
                        ch9Label.text += pD2dInforData.getChModelStr("CH9M");
                    }
                }
                else
                {
                    ch9Label.text = "undefined";
                }

                if(pD2dInforData.getKeyValue("VIDEO") !== 0)
                {
                    videoLabel.text = pD2dInforData.getChStr(10);
                }
                else
                {
                    videoLabel.text = "undefined";
                }
            }
            MessageDialog {
                id:         messageDialog
                visible:    false
                icon:       StandardIcon.Warning
                standardButtons: StandardButton.Yes | StandardButton.No
                title:      qsTr("WARNING")
                text:       qsTr("The channel has been occupied. Are you sure you want to cover it?")
                onYes: {
                    __resetChValue = pD2dInforData.getKeyValue(pD2dInforData.getKeyNameFromCombox(__currentIndex));
                    pD2dInforData.clearChSetting(__resetChValue);
                    centreWindow.resetChStatus();
                }
                onNo: {
                    if(__whichComboxStatus == 0)
                    {
                        oneChannelCombo1.currentIndex = __prevIndex;
                    }
                    else if(__whichComboxStatus == 1)
                    {
                        mulRow1Combox.currentIndex = __prevIndex;
                    }
                    else if(__whichComboxStatus == 2)
                    {
                        mulRow2Combox.currentIndex = __prevIndex;
                    }
                    else if(__whichComboxStatus == 3)
                    {
                        mulRow3Combox.currentIndex = __prevIndex;
                    }
                    else if(__whichComboxStatus == 4)
                    {
                        mulRow4Combox.currentIndex = __prevIndex;
                    }
                    else if(__whichComboxStatus == 5)
                    {
                        videoCombox.currentIndex = __prevIndex;
                    }
                }
            }

            MessageDialog {
                id:         enableSaveDialog
                visible:    false
                icon:       StandardIcon.Warning
                standardButtons: StandardButton.Yes
                title:      qsTr("WARNING")
                text:       qsTr("The key is defined multiple, please check!")
                onYes: {
                    close();
                }
            }
        }
    } // QGCViewPanel
} // QGCView

