# Get-ChocoOutdated

The command ``choco outdated`` shows you what software is out of date. Sadly, it is not an object:

```
choco outdated
Chocolatey v0.10.15
Outdated Packages
 Output is package name | current version | available version | pinned?

brave|1.11.104|1.12.108|false
chocolatey-core.extension|1.3.3|1.3.5.1|false
microsoft-windows-terminal|0.5.2681.0|1.1.2021.0|false
obs-studio|25.0.4|25.0.8|false
obs-studio.install|25.0.4|25.0.8|false
vcredist140|14.23.27820|14.26.28720.3|false
vim|8.2.0116|8.2.1399|false

Chocolatey has determined 7 package(s) are outdated.
```

My function [``Get-ChocoOutdated``](https://github.com/davidsteimle/generalscripts/blob/master/Get-ChocoOutdated.ps1) will return an array of objects built from ``choco outdated``'s results:

```
SoftwareName               CurrentVersion AvailableVersion Pinned
------------               -------------- ---------------- ------
brave                      1.11.104       1.12.108          False
chocolatey-core.extension  1.3.3          1.3.5.1           False
microsoft-windows-terminal 0.5.2681.0     1.1.2021.0        False
obs-studio                 25.0.4         25.0.8            False
obs-studio.install         25.0.4         25.0.8            False
vcredist140                14.23.27820    14.26.28720.3     False
vim                        8.2.0116       8.2.1399          False
```
