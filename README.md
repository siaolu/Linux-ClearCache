[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)
 # Linux ClearCache
 #### This script allows free up RAM (via drop caches), refreshes your swap, and provides enhanced logging and testing capabilities on your Linux server
--------------------------------------------
Usage: 
use sudo or root priv  - (i.e): Adjust permissions
```sh
$ sudo chmod +x clrcachev1.sh clrcachev2.sh clrcachev3.sh clrcachev4.sh clrcachev5.sh clrcachev6.sh
```
```sh
$ sudo ./clrcachev1.sh  
$ sudo ./clrcachev2.sh
$ sudo ./clrcachev3.sh
$ sudo ./clrcachev4.sh
$ sudo ./clrcachev5.sh
$ sudo ./clrcachev6.sh [options]
```
Options for clrcachev6.sh:
- `-v`: Verbose mode
- `-t`: Test mode

(i.e.): Adjust crontab - Update : /etc/crontab
```sh
sudo crontab -e
 0,15,30,45 * * * * /home/SomeUser/YourPath/YourTools/clrcachev6.sh
```
>Quick Crontab References:
> [Admin's Choice](https://www.adminschoice.com/crontab-quick-reference)
> [Linux Config](https://linuxconfig.org/linux-crontab-reference-guide)
> [GeeksForGeeks](https://www.geeksforgeeks.org/crontab-in-linux-with-examples/)

> ### Note   
>Be sure to use settings that work with your workloads. The example above is provided as an example only; if you're unsure please crosscheck online to evaluate how clearing cache and/or refreshing swap may impact your system performance / operation. The newer versions (v3-v6) provide enhanced logging and testing capabilities to help you understand the impact on your system.
```sh
Please research before using scripts that modify the function and/or operation of your system. Please leverage some of the references below to derive more information.

Apply, adjust, change configuration files at your own Risk. We / myteam / nor the references cited below are responsible for changes *you make to your system*. Enjoy!
```
| tool | github credit, references |
| ------ | ------ |
| clrcachev1 | [Linux Free Memory Script](https://github.com/jacob-israel/Linux-Free-Memory-Shell-Script) |
| clrcachev2 | [TechMint Clearing Cache ](https://www.tecmint.com/clear-ram-memory-cache-buffer-and-swap-space-on-linux/) |
| clrcachev2 | [TechMint Flush memory cache ](https://tecadmin.net/flush-memory-cache-on-linux-server/) |
| clrcachev3-v6 | Developed fused by daswerks to v1 and v2 |

### New Features in Recent Versions:
- v3: Enhanced logging, timing function, and memory snapshots
- v4: Improved error handling and configurability
- v5: Added portability improvements and verbose mode
- v6: Implemented test mode and individual testing functions

To use the latest version with all features:
```sh
$ sudo ./clrcachev6.sh -v -t  # Run in verbose and test mode
```