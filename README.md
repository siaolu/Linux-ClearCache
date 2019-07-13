
[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)
 # Linux ClearCache 
clrcachev1 & clrcachev2 based on: 
- https://github.com/jacob-israel/Linux-Free-Memory-Shell-Script

 ### This script allows free up RAM (via drop caches) and refreshes your swap on your linux server
--------------------------------------------
Check out Either version.

Usage: 
use sudo or root priv

(i.e): Adust permissions
$ sudo chmod +x clrcachev1.sh clrcachev2.sh
```sh
- $ sudo ./clrcachev1.sh  
- $ sudo ./clrcachev2.sh
```
(i.e.): Adjust crontab - Update : /etc/crontab
sudo crontab -e

>Quick Crontab References: Depending on your work loads configure crontab based on *your* operating requirements: 
>https://www.adminschoice.com/crontab-quick-reference
>https://linuxconfig.org/linux-crontab-reference-guide
>https://www.geeksforgeeks.org/crontab-in-linux-with-examples/
```sh
(i.e.): 0,15,30,45 * * * * /home/SomeUser/YourPath/YourTools/clrcachev2.sh 
```
>** Note **   
>Be sure to use settings that work with your workloads, if you're unsure please crosscheck online to evaluate how clearing >cache and/or refreshing swap might impact your system performance / operation.






