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
dotnet pubish
curl -sL https://github.com/nunit/nunit-console/releases/download/v3.10/NUnit.Console-3.10.0.zip -o NUnit.zip
unzip NUnit.zip -d NUnit
# copy mono from local installation on a mac
# find it's directory using `which mono`
cp /usr/local/bin/mono .
## TODO: need to compile mono for ubuntu to include in test package
zip -r test_package.zip bin NUnit mono
```

## TODO: write commands for testspec.yml file and upload cli commands


