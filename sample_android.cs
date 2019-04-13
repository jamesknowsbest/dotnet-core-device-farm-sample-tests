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
			// These capabilities are passed in to the appium server by Device Farm
			// We should not need to set these when in Device Farm's execution environment 
			// capabilities.AddAdditionalCapability("deviceName", "emulator-5554");
			// capabilities.AddAdditionalCapability("platformName", "Android");
			// capabilities.AddAdditionalCapability("app", "/PATH/TO/app-debug.apk");
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
			// referenced https://github.com/appium-boneyard/sample-code/blob/master/sample-code/examples/dotnet/AppiumDotNetSample/Android/AndroidSearchingTest.cs#L53-L55
			var HOMEPAGE_HEADLINE = "AWS Device Farm Sample App for Android";
			By byAccessibilityId = new ByAccessibilityId("Homepage Headline");
			var actual_homepage_headline = driver.FindElement(byAccessibilityId).Text;
			Assert.AreEqual(actual_homepage_headline,HOMEPAGE_HEADLINE);
		}
    }
}