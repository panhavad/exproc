                                                                                                      
	███████╗██╗  ██╗██████╗ ██████╗  ██████╗  ██████╗
	██╔════╝╚██╗██╔╝██╔══██╗██╔══██╗██╔═══██╗██╔════╝
	█████╗   ╚███╔╝ ██████╔╝██████╔╝██║   ██║██║     
	██╔══╝   ██╔██╗ ██╔═══╝ ██╔══██╗██║   ██║██║     
	███████╗██╔╝ ██╗██║     ██║  ██║╚██████╔╝╚██████╗
	╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝

# Exportable Processing Statistic Info
## What is it?

**Exproc** is Local performance monitoring script, allow user to get result both on console and exported file.
The exported file later on can be open with excel for further analysis.

This script is main under several goals:

 - **Summary** and **understandable** performance statistic
 - **Exportable** performance history for further **analysis**
 - Capture the statistic **locally** on the machine itself

**Capturing the performance of the machine is using similar script and technique with "htop"

This script is depend on several dependencies:

 - **sysstat:** to check the current CPU performance
 - **bc:** to operate arithmetic calculation of decimal number on bash

## Why this?

To solve the current remote performance monitoring application issue, cause delay, not able to export the statistic for easy and further analysis, some statistical data is to detail not understandable.

## How it work?

It just using the existing command to check the machine performance and extract the important information only to the console then also export to file that start with "proc_res_....".

## How to use this script?

 1. Simply clone this **<a href="https://github.com/panhavad/exproc" target="_blank">repo</a>**
 2. Go the cloned directory
 3. Change .sh file permission to executable "**chmod 777 run_exproc.sh**"
 4. Execute the **run_exproc.sh**
 5. Result in console and "**proc_res_....**"
 6. Copy the result file to local machine
 7. Open with **excel** (just select **YES** if they said file might be corrupt because of different format)
 8. Select the whole column A:A
 9. Goto data -> Text to Column -> Delimiter (Comma)
 8. **Enjoy the record**

## Does it really work?
<img src="https://s4.gifyu.com/images/exproc_demo2.gif" width="1000"/>

## 🐫Todos
- Add priority so that even the machine is overload script still executing

