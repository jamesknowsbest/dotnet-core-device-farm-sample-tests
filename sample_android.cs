using NUnit.Framework;
using OpenQA.Selenium;
using System;
using OpenQA.Selenium.Appium;
using OpenQA.Selenium.Appium.Android;
using OpenQA.Selenium.Remote;

namespace AppiumDriverDemo
{
    [TestFixture ()]
	public class SampleTest
    {
        private AppiumDriver<AppiumWebElement> driver;

		[SetUp]
		public void beforeAll(){
            var  capabilities = new AppiumOptions();
			capabilities.AddAdditionalCapability("deviceName", "One Plus");
			capabilities.AddAdditionalCapability("platformName", "Android");
			capabilities.AddAdditionalCapability("app", "/Users/jmp/git/dotnet-core-device-farm-sample-tests/ApiDemos-debug.apk");
			driver = new AndroidDriver<AppiumWebElement>(new Uri("http://127.0.0.1:4723/wd/hub"), 
                               capabilities);		
		}

		[TearDown]
		public void afterAll(){
			// shutdown
			driver.Quit();
		}
			
		[Test ()]
		public void AppiumDriverMethodsTestCase ()
		{
			// Using appium extension methods
			// referenced https://github.com/appium-boneyard/sample-code/blob/master/sample-code/examples/dotnet/AppiumDotNetSample/Android/AndroidSearchingTest.cs#L69-L71
			string byXPath = "//android.widget.TextView[contains(@text, 'Animat')]";
            Assert.IsNotNull(driver.FindElementByXPath(byXPath).Text);
			Assert.AreEqual(driver.FindElementsByXPath(byXPath).Count, 1);
		}
    }
}