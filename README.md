# dotnet-core-device-farm-sample-tests
Short project to show how to build a test package in dot-net for AWS Device Farm

## How did I create this project? 

I ran the following commands for a simple NUnit project

```
dotnet new -i NUnit3.DotNetNew.Template
dotnet new nunit
dotnet restore
```

**dependencies**
```
dotnet add package Selenium.WebDriver
dotnet add package Newtonsoft.Json
dotnet add package Selenium.Support
dotnet add package Castle.Core
dotnet add package Appium.WebDriver
```

If you do not have the dot-net CLI installed you can download it from this link
https://dotnet.microsoft.com/download

From there I referenced the [android sample](https://github.com/appium/appium-dotnet-driver/wiki/Android-Sample) and the [integration tests](https://github.com/appium/appium-dotnet-driver/tree/master/test/integration) for code samples. 

## How to run tests locally

You can run `dotnet test` or run the following commands: 
```
dotnet publish
# Need the publish command to copy dependencies
# https://github.com/nunit/nunit/issues/2713#issuecomment-365932475
nunit-console bin/Debug/netcoreapp2.2/publish/dotnet-core-device-farm-sample-tests.dll

# alternatively if you download the zip of nunit you should be able to run it like this: 
curl -sL https://github.com/nunit/nunit-console/releases/download/v3.10/NUnit.Console-3.10.0.zip -o NUnit.zip
unzip NUnit.zip -d NUnit
# might need to reference different version of NUnit from the unzipped directory depending
mono ./NUnit/bin/net35/nunit3-console.exe bin/Debug/netcoreapp2.2/publish/dotnet-core-device-farm-sample-tests.dll 
```


## How to create a test package for Device Farm

```
dotnet publish
curl -sL https://github.com/nunit/nunit-console/releases/download/v3.10/NUnit.Console-3.10.0.zip -o NUnit.zip
unzip NUnit.zip -d NUnit
# copy mono from local installation on a mac
# find it's directory using `which mono`
cp /usr/local/bin/mono .
## TODO: need to compile mono for ubuntu to include in test package
zip -r test_package.zip bin NUnit

zip -r test_package.zip *.csproj *.cs
```

## TODO: write commands for testspec.yml file and upload cli commands

https://download.mono-project.com/runtimes/raw/?C=M;O=D

[DeviceFarm] cat /etc/os-release
NAME="Ubuntu"
VERSION="14.04.5 LTS, Trusty Tahr"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 14.04.5 LTS"
VERSION_ID="14.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"

Unhandled Exception:
System.TypeInitializationException: The type initializer for 'NUnit.ConsoleRunner.Program' threw an exception. ---> System.TypeLoadException: Could not set up parent class, due to: Could not set up parent class, due to: Could not load type of field 'NUnit.Options.OptionSet:ValueOption' (1) due to: Could not load file or assembly 'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089' or one of its dependencies. assembly:/tmp/scratchS8oL48.scratch/test-packageMqlJjJ/NUnit/bin/net20/nunit3-console.exe type:OptionSet member:(null) assembly:/tmp/scratchS8oL48.scratch/test-packageMqlJjJ/NUnit/bin/net20/nunit3-console.exe type:CommandLineOptions member:(null)
   --- End of inner exception stack trace ---
[ERROR] FATAL UNHANDLED EXCEPTION: System.TypeInitializationException: The type initializer for 'NUnit.ConsoleRunner.Program' threw an exception. ---> System.TypeLoadException: Could not set up parent class, due to: Could not set up parent class, due to: Could not load type of field 'NUnit.Options.OptionSet:ValueOption' (1) due to: Could not load file or assembly 'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089' or one of its dependencies. assembly:/tmp/scratchS8oL48.scratch/test-packageMqlJjJ/NUnit/bin/net20/nunit3-console.exe type:OptionSet member:(null) assembly:/tmp/scratchS8oL48.scratch/test-packageMqlJjJ/NUnit/bin/net20/nunit3-console.exe type:CommandLineOptions member:(null)
   --- End of inner exception stack trace ---
 

mono --version
Mono JIT compiler version 5.18.0.268 (tarball Tue Mar 12 08:31:42 GMT 2019)
Copyright (C) 2002-2014 Novell, Inc, Xamarin Inc and Contributors. www.mono-project.com
        TLS:           
        SIGSEGV:       altstack
        Notification:  kqueue
        Architecture:  amd64
        Disabled:      none
        Misc:          softdebug 
        Interpreter:   yes
        LLVM:          supported, not enabled.
        Suspend:       preemptive
        GC:            sgen (concurrent by default)

./mono/bin/mono --version
Mono JIT compiler version 5.18.0.225 (2018-08/bac9fc1f889 Fri Dec 21 11:33:29 EST 2018)
Copyright (C) 2002-2014 Novell, Inc, Xamarin Inc and Contributors. www.mono-project.com
        TLS:           
        SIGSEGV:       altstack
        Notification:  kqueue
        Architecture:  amd64
        Disabled:      none
        Misc:          softdebug 
        Interpreter:   yes
        LLVM:          yes(600)
        Suspend:       preemptive
        GC:            sgen (concurrent by default)mono --help
