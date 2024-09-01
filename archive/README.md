---
noteId: "5e5e87a0683a11ef88409dac2637a010"
tags: []

---

  
[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)
 # Linux ClearCache
 #### This script allows free up RAM (via drop caches) and refreshes your swap on your linux server
--------------------------------------------
Usage: 
use sudo or root priv  - (i.e): Adust permissions
```sh
$ sudo chmod +x clrcachev1.sh clrcachev2.sh
```
```sh
$ sudo ./clrcachev1.sh  
$ sudo ./clrcachev2.sh
```
(i.e.): Adjust crontab - Update : /etc/crontab
```sh
sudo crontab -e
 0,15,30,45 * * * * /home/SomeUser/YourPath/YourTools/clrcachev2.sh
```
>Quick Crontab References:
> [Admin's Choice](https://www.adminschoice.com/crontab-quick-reference)
> [Linux Config](https://linuxconfig.org/linux-crontab-reference-guide)
> [GeeksForGeeks](https://www.geeksforgeeks.org/crontab-in-linux-with-examples/)

> ### Note   
>Be sure to use settings that work with your workloads the example above is provided as an example only; if you're unsure please crosscheck online to evaluate how clearing cache and/or refreshing swap may impact your system performance / operation.
```sh
Please research before using scripts that modify the function and/or operation of your system.  Please leverage some of the references below to derive more information.

Apply, adjust, change configuration files at your own Risk,  we / myteam / nor the references cited below are responsible for changes *you make to your system*.  Enjoy!
```
| tool | github credit, references |
| ------ | ------ |
| clrcachev1 | [Linux Free Memory Script](https://github.com/jacob-israel/Linux-Free-Memory-Shell-Script) |
| clrcachev2 | [TechMint Clearing Cache ](https://www.tecmint.com/clear-ram-memory-cache-buffer-and-swap-space-on-linux/) |
| clrcachev2 | [TechMint Flush memory cache ](https://tecadmin.net/flush-memory-cache-on-linux-server/) |

