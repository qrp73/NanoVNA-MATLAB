# NanoVNA-MATLAB
MATLAB scripts for NanoVNA vector network analyzer. Connect, save S2P file and display Logmag and Smith chart

## Overview

With these MATLAB scripts you can connect to your NanoVNA, execute commands, get S11 and S21 data, save it to S2P file and plot LOGMAG and SMITH charts. All can be done from MATLAB environment and it don't requires any external application.

## Instructions

1) Make sure NanoVNA COM port drivers are installed (see NanoVNA drivers section)
2) Connect your NanoVNA before MATLAB start
3) Start MATLAB and open nanovna.m script
4) Enter correct COM port name (e.g. "COM3")
5) Run the script

Please note, you're needs to connect NanoVNA before opening MATLAB.

![screenshot](https://user-images.githubusercontent.com/46676744/67643701-d8063300-f922-11e9-8d20-a603cd2859bf.png)


## NanoVNA drivers
If you don't have STM32 Virtual COM port driver, you can download it from st.com (registration required): 
https://my.st.com/content/ccc/resource/technical/software/driver/70/30/29/18/96/3e/4f/3b/stsw-stm32102.zip/files/stsw-stm32102.zip/jcr:content/translations/en.stsw-stm32102.zip
