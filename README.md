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

**Note**: Though it should be possible to download mono in Device Farm I found it very difficult to use successfully. Here is the download page that Device Farm's testspec.yml file can use to get a pre-compiled mono installation
https://download.mono-project.com/runtimes/raw/

## How to create a test package for Device Farm

```
cd YOUR_PROJECT_DIRECTORY
zip -r test_package.zip *.csproj *.cs
```

## write commands for testspec.yml file and upload cli commands

### CLI Upload commands: 
**Note**: You can download and install the aws cli from [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
```
PROJECT_ARN=$(aws devicefarm create-project --name dotnet-test --region us-west-2 --query project.arn --output text)

APP_UPLOAD_DETAILS=$(aws devicefarm create-upload --project-arn $PROJECT_ARN --name app-debug.apk --type ANDROID_APP --region us-west-2 --query upload.[arn,url] --output text)
URL=$(echo $APP_UPLOAD_DETAILS | awk '{print $2; exit}')
APP_UPLOAD_ARN=$(echo $APP_UPLOAD_DETAILS | awk '{print $1; exit}')
curl -T ./app-debug.apk "$URL"

zip -r test_package.zip *.csproj *.cs

TEST_UPLOAD_DETAILS=$(aws devicefarm create-upload --project-arn $PROJECT_ARN --name test_package.zip --type APPIUM_NODE_TEST_PACKAGE --region us-west-2 --query upload.[arn,url] --output text)
URL=$(echo $TEST_UPLOAD_DETAILS | awk '{print $2; exit}')
TEST_UPLOAD_ARN=$(echo $TEST_UPLOAD_DETAILS | awk '{print $1; exit}')
curl -T ./test_package.zip "$URL"

TEST_SPEC_UPLOAD_DETAILS=$(aws devicefarm create-upload --project-arn $PROJECT_ARN --name dotnet-testspec.yml --type APPIUM_NODE_TEST_SPEC --region us-west-2 --query upload.[arn,url] --output text)
URL=$(echo $TEST_SPEC_UPLOAD_DETAILS | awk '{print $2; exit}')
TEST_SPEC_UPLOAD_ARN=$(echo $TEST_SPEC_UPLOAD_DETAILS | awk '{print $1; exit}')
curl -T ./dotnet-testspec.yml "$URL"

# using a Samsung Galaxy Note 4 SM-N910H in this case. You can use list-devices API to get the arn value of the device
DEVICE_POOL_ARN=$(aws devicefarm create-device-pool --project-arn $PROJECT_ARN --name "Samsung Galaxy Note 4" --rules '[{"attribute": "ARN","operator":"IN","value":"[\"arn:aws:devicefarm:us-west-2::device:70D5B22608A149568923E4A225EC5E04\"]"}]' --region us-west-2 --query devicePool.arn --output text)

aws devicefarm schedule-run --project-arn $PROJECT_ARN --device-pool-arn $DEVICE_POOL_ARN --app-arn $APP_UPLOAD_ARN --test testPackageArn=$TEST_UPLOAD_ARN,type=APPIUM_NODE,testSpecArn=$TEST_SPEC_UPLOAD_ARN --region us-west-2 
```

### Testspec file: 
In Device Farm's testspec.yml file download dotnet and unpackage it using the following snippet

```
# download page: https://github.com/dotnet/core/blob/master/release-notes/2.2/2.2.3/2.2.3-download.md
      - >-
        if [ $DEVICEFARM_DEVICE_PLATFORM_NAME = "Android" ];
        then
            echo "Downloading dotnet for Linux"
            curl -sL "https://download.visualstudio.microsoft.com/download/pr/7d8f3f4c-9a90-42c5-956f-45f673384d3f/14d686d853a964025f5c54db237ff6ef/dotnet-sdk-2.2.105-linux-x64.tar.gz" -o dotnet-sdk-2.2.105.tar.gz
        fi
      - >-
        if [ $DEVICEFARM_DEVICE_PLATFORM_NAME = "iOS" ];
        then
            echo "Downloading dotnet for macOS"
            curl -sL "https://download.visualstudio.microsoft.com/download/pr/47709d55-450a-4828-9e3a-de65aef7c2f2/f512dd0abf6989ce1800d4fd40a745d7/dotnet-sdk-2.2.105-osx-x64.tar.gz" -o dotnet-sdk-2.2.105.tar.gz
        fi
      - tar -xzf dotnet-sdk-2.2.105.tar.gz
      - ./dotnet --version 
```

Then run the tests using the command `./dotnet test` full testspec file I used can be found here
https://github.com/jamesknowsbest/dotnet-core-device-farm-sample-tests/blob/master/dotnet-testspec.yml

To read more about using dotnet test in linux please follow this link: 
https://github.com/nunit/docs/wiki/.NET-Core-and-.NET-Standard

**Note**: I was not able to run commands with nunit-console as that would require mono to execute it. I did not find the correct permutation/combination to use in Device Farm such that mono is successful and reliable. 
