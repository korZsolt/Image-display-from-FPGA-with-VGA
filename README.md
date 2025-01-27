# Image-display-from-FPGA-with-VGA
## Description
The focus of this project is *displaying images stored on an FPGA on a monitor, with the help of the board's VGA output*.\
The project is implemented in **Xilinx Vivado 2018.3**, written in VHDL. Other operations, like transforming an image into a binary text file, were done in **MatLab**.\
The project was made with the **Nexys4** FPGA in mind, and was also tested on this board and a **1280*1024 resolution**, **60Hz refresh rate** monitor. Depending on the specifications of your devices, some parameters might need to be modified for the code to work, but *potential changes are commented in the VHDL and MatLab files*.

### Components
The aside the module that displays the pixels and the main module, the project contains an **MPG**, **clock divider** and **RAM memory**.
