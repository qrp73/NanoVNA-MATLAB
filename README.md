![Language](https://img.shields.io/badge/language-MATLAB-red.svg)
[![License](https://img.shields.io/badge/license-GNU%20GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl.html)

# NanoVNA-MATLAB
MATLAB scripts for NanoVNA vector network analyzer. Connect, save S2P file and display Logmag, Smith chart and TDR step response

## Overview

With these MATLAB scripts you can connect to your NanoVNA, execute commands, get S11 and S21 data, save it to S2P file and plot LOGMAG, SMITH chart and TDR step response. All can be done from MATLAB environment and it don't requires any external application.

## Instructions

1) Make sure NanoVNA COM port drivers are installed (see NanoVNA drivers section)
2) Connect your NanoVNA before MATLAB start
3) Start MATLAB and open nanovna.m script
4) Enter correct COM port name (e.g. "COM3")
5) Run the script

Please note, you're needs to connect NanoVNA before opening MATLAB.

## Screenshots

![screenshot](https://user-images.githubusercontent.com/46676744/67643701-d8063300-f922-11e9-8d20-a603cd2859bf.png)

![screenshot-tdr](https://user-images.githubusercontent.com/46676744/67647070-8f0da900-f939-11e9-9079-4a189e2ec520.png)


## NanoVNA drivers
If you don't have STM32 Virtual COM port driver, you can download it from st.com (registration required): 
https://my.st.com/content/ccc/resource/technical/software/driver/70/30/29/18/96/3e/4f/3b/stsw-stm32102.zip/files/stsw-stm32102.zip/jcr:content/translations/en.stsw-stm32102.zip
