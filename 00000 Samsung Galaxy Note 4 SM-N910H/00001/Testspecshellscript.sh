#!/bin/bash
export DEVICEFARM_CHROMEDRIVER_EXECUTABLE=/opt/chromedriver/linux/36/chromedriver
export DEVICEFARM_WORKING_DIR=/tmp/working_dirJmpoqM
export DEVICEFARM_DEVICE_NAME=41001988dca822bd
export DEVICEFARM_SCREENSHOT_PATH=/tmp/scratch7tGQun.scratch/custom_screenshotEg7hui
export DEVICEFARM_DEVICE_PLATFORM_NAME=Android
export DEVICEFARM_LOG_DIR=/tmp/customer_log_directoryfszpRJ
export SCREENSHOT_PATH=/tmp/scratch7tGQun.scratch/custom_screenshotEg7hui
export WORKING_DIRECTORY=/tmp/customer_artifacts_working_directorylydqYi
export HOME=/home/device-farm
export DEVICEFARM_DEVICE_UDID=41001988dca822bd
export DEVICEFARM_TEST_PACKAGE_PATH=/tmp/scratch7tGQun.scratch/test-packager6xfO7
export DEVICEFARM_APP_PATH=/tmp/scratch7tGQun.scratch/share-yCfNhZ.scratch/app-dyiunO.apk
install()
{
echo ' '
echo '[DEVICEFARM] ########### Entering phase install ###########'
echo ' '
echo '[DeviceFarm] echo "Navigate to test package directory"' 
echo "Navigate to test package directory" 
echo '[DeviceFarm] cd $DEVICEFARM_TEST_PACKAGE_PATH' 
cd $DEVICEFARM_TEST_PACKAGE_PATH 
echo '[DeviceFarm] cat /etc/os-release' 
cat /etc/os-release 
echo '[DeviceFarm] if [ $DEVICEFARM_DEVICE_PLATFORM_NAME = "Android" ]; then
    echo "Downloading dotnet for Linux"
    curl -sL "https://download.visualstudio.microsoft.com/download/pr/7d8f3f4c-9a90-42c5-956f-45f673384d3f/14d686d853a964025f5c54db237ff6ef/dotnet-sdk-2.2.105-linux-x64.tar.gz" -o dotnet-sdk-2.2.105.tar.gz
fi' 
if [ $DEVICEFARM_DEVICE_PLATFORM_NAME = "Android" ]; then
    echo "Downloading dotnet for Linux"
    curl -sL "https://download.visualstudio.microsoft.com/download/pr/7d8f3f4c-9a90-42c5-956f-45f673384d3f/14d686d853a964025f5c54db237ff6ef/dotnet-sdk-2.2.105-linux-x64.tar.gz" -o dotnet-sdk-2.2.105.tar.gz
fi 
echo '[DeviceFarm] if [ $DEVICEFARM_DEVICE_PLATFORM_NAME = "iOS" ]; then
    echo "Downloading dotnet for macOS"
    curl -sL "https://download.visualstudio.microsoft.com/download/pr/47709d55-450a-4828-9e3a-de65aef7c2f2/f512dd0abf6989ce1800d4fd40a745d7/dotnet-sdk-2.2.105-osx-x64.tar.gz" -o dotnet-sdk-2.2.105.tar.gz
fi' 
if [ $DEVICEFARM_DEVICE_PLATFORM_NAME = "iOS" ]; then
    echo "Downloading dotnet for macOS"
    curl -sL "https://download.visualstudio.microsoft.com/download/pr/47709d55-450a-4828-9e3a-de65aef7c2f2/f512dd0abf6989ce1800d4fd40a745d7/dotnet-sdk-2.2.105-osx-x64.tar.gz" -o dotnet-sdk-2.2.105.tar.gz
fi 
echo '[DeviceFarm] tar -xzf dotnet-sdk-2.2.105.tar.gz' 
tar -xzf dotnet-sdk-2.2.105.tar.gz 
echo '[DeviceFarm] ./dotnet --version' 
./dotnet --version 
}
pre_test()
{
echo ' '
echo '[DEVICEFARM] ########### Entering phase pre_test ###########'
echo ' '
echo '[DeviceFarm] echo "Start appium server"' 
echo "Start appium server" 
echo '[DeviceFarm] appium --log-timestamp --device-name $DEVICEFARM_DEVICE_NAME --platform-name $DEVICEFARM_DEVICE_PLATFORM_NAME --app $DEVICEFARM_APP_PATH --udid $DEVICEFARM_DEVICE_UDID --chromedriver-executable $DEVICEFARM_CHROMEDRIVER_EXECUTABLE  >> $DEVICEFARM_LOG_DIR/appiumlog.txt 2>&1 &' 
appium --log-timestamp --device-name $DEVICEFARM_DEVICE_NAME --platform-name $DEVICEFARM_DEVICE_PLATFORM_NAME --app $DEVICEFARM_APP_PATH --udid $DEVICEFARM_DEVICE_UDID --chromedriver-executable $DEVICEFARM_CHROMEDRIVER_EXECUTABLE  >> $DEVICEFARM_LOG_DIR/appiumlog.txt 2>&1 & 
echo '[DeviceFarm] start_appium_timeout=0; while [ true ]; do
    if [ $start_appium_timeout -gt 60 ];
    then
        echo "appium server never started in 60 seconds. Exiting";
        exit 1;
    fi;
    grep -i "Appium REST http interface listener started on 0.0.0.0:4723" $DEVICEFARM_LOG_DIR/appiumlog.txt >> /dev/null 2>&1;
    if [ $? -eq 0 ];
    then
        echo "Appium REST http interface listener started on 0.0.0.0:4723";
        break;
    else
        echo "Waiting for appium server to start. Sleeping for 1 second";
        sleep 1;
        start_appium_timeout=$((start_appium_timeout+1));
    fi;
done; ' 
start_appium_timeout=0; while [ true ]; do
    if [ $start_appium_timeout -gt 60 ];
    then
        echo "appium server never started in 60 seconds. Exiting";
        exit 1;
    fi;
    grep -i "Appium REST http interface listener started on 0.0.0.0:4723" $DEVICEFARM_LOG_DIR/appiumlog.txt >> /dev/null 2>&1;
    if [ $? -eq 0 ];
    then
        echo "Appium REST http interface listener started on 0.0.0.0:4723";
        break;
    else
        echo "Waiting for appium server to start. Sleeping for 1 second";
        sleep 1;
        start_appium_timeout=$((start_appium_timeout+1));
    fi;
done;  
}
test()
{
echo ' '
echo '[DEVICEFARM] ########### Entering phase test ###########'
echo ' '
echo '[DeviceFarm] echo "Start Appium C# test"' 
echo "Start Appium C# test" 
COMMAND_EXIT_CODE=$?
if [ "$COMMAND_EXIT_CODE" != "0" ]; then
return $COMMAND_EXIT_CODE
fi
echo '[DeviceFarm] ./dotnet test' 
./dotnet test 
COMMAND_EXIT_CODE=$?
if [ "$COMMAND_EXIT_CODE" != "0" ]; then
return $COMMAND_EXIT_CODE
fi
}
post_test()
{
echo ' '
echo '[DEVICEFARM] ########### Entering phase post_test ###########'
echo ' '
}
handle_TERM()
{
echo '[DEVICEFARM] ########### Stop received, exit testspec execution ###########'
exit 130
}
handle_EXIT()
{
DEVICEFARM_EXIT_CODE=$?
echo '[DEVICEFARM] ########### Finish executing testspec ###########'
echo ' '
echo '[DEVICEFARM] ########### Setting upload permissions ###########'
echo ' '
echo DEVICEFARM_LOG_DIR: $DEVICEFARM_LOG_DIR >> /tmp/artifacts_description.txt 
chmod -R +r $DEVICEFARM_LOG_DIR/*
echo ' '
exit $DEVICEFARM_EXIT_CODE
}
trap 'handle_TERM' 2 15
trap 'handle_EXIT' 0
export NVM_DIR=$HOME/.nvm
. $NVM_DIR/nvm.sh
echo '[DEVICEFARM] ########### Start executing testspec ###########'
echo ' '
install
pre_test
test
TEST_EXIT_CODE=$?
post_test
echo ' '
exit $TEST_EXIT_CODE
