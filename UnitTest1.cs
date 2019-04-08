using NUnit.Framework;
using OpenQA.Selenium;
using System;
using OpenQA.Selenium.Appium.DesiredCapabilities;


namespace Tests
{
    public class Tests
    {
        private AppiumDriver<AppiumWebElement> driver;

		[SetUp]
		public void beforeAll(){
			DesiredCapabilities capabilities = new DesiredCapabilities();

			capabilities.SetCapability("deviceName", "Android Emulator");
			capabilities.SetCapability("platformName", "Android");
			capabilities.SetCapability("app", "<Path to your app>");
			driver = new AndroidDriver<AppiumWebElement>(
                           new Uri("http://127.0.0.1:4723/wd/hub"), 
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
			AppiumWebElement el = driver.
                          FindElementsByAndroidUIAutomator (
                            "new UiSelector().enabled(true)");
			el.SendKeys ("abc");
			Assert.AreEqual (el.Text, "abc");
		}
    }
}