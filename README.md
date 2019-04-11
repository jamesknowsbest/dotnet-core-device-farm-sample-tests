# dotnet-core-device-farm-sample-tests
Short project to show how to build a test package in dot-net for AWS Device Farm

## How did I create this project? 

I ran the following commands for a simple NUnit project
`dotnet new -i NUnit3.DotNetNew.Template`
`dotnet new nunit`
`dotnet restore`

**dependencies**
`dotnet add package Selenium.WebDriver`
`dotnet add package Newtonsoft.Json`
`dotnet add package Selenium.Support`
`dotnet add package Castle.Core`
`dotnet add package Appium.WebDriver`

If you do not have the dot-net CLI installed you can download it from this link
https://dotnet.microsoft.com/download

From there I referenced the [android sample](https://github.com/appium/appium-dotnet-driver/wiki/Android-Sample) and the [integration tests](https://github.com/appium/appium-dotnet-driver/tree/master/test/integration) for code samples. 

## How to run tests locally

https://docs.microsoft.com/en-ca/dotnet/core/tools/dotnet-test?tabs=netcore21

## How to create a test package for Device Farm

