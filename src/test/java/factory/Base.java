package factory;

import java.io.IOException;
import java.net.URL;
import java.time.Duration;
import org.openqa.selenium.Platform;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import io.github.bonigarcia.wdm.WebDriverManager;

public class Base {

    static WebDriver driver;

    public static WebDriver initilizeBrowser() throws IOException {
        String executionEnv = System.getenv("EXECUTION_ENV");
        String browser = System.getenv("BROWSER").toLowerCase();
        String os = System.getenv("OS").toLowerCase();
        
        if (executionEnv.equalsIgnoreCase("remote")) {
            DesiredCapabilities capabilities = new DesiredCapabilities();
            
            // os
            switch (os) {
                case "windows":
                    capabilities.setPlatform(Platform.WINDOWS);
                    break;
                case "mac":
                    capabilities.setPlatform(Platform.MAC);
                    break;
                case "linux":
                    capabilities.setPlatform(Platform.LINUX);
                    break;
                default:
                    System.out.println("No matching OS");
                    return null;
            }
            
            // browser
            switch (browser) {
                case "chrome":
                    ChromeOptions op = new ChromeOptions(); // 3 lines to skip the session not created exception
                    op.addArguments("--no-sandbox");
                    op.addArguments("--disable-dev-shm-usage");
                    // op.addArguments("--incognito");
                    op.addArguments("--disable-application-cache");
                    capabilities.setBrowserName("chrome");
                    break;
                case "edge":
                    // WebDriverManager.edgedriver().setup();
                    capabilities.setBrowserName("MicrosoftEdge");
                    break;
                case "firefox":
                    capabilities.setBrowserName("firefox");
                    break;
                default:
                    System.out.println("No matching browser");
                    return null;
            }
            
            driver = new RemoteWebDriver(new URL(System.getenv("SELENIUM_REMOTE_URL")), capabilities);
            
        } else if (executionEnv.equalsIgnoreCase("local")) {
            switch (browser.toLowerCase()) {
                case "chrome":
                    System.setProperty("webdriver.chrome.driver", System.getenv("CHROME_DRIVER_PATH"));
                    driver = new ChromeDriver();
                    break;
                case "edge":
                    WebDriverManager.edgedriver().setup();
                    driver = new EdgeDriver();
                    break;
                case "firefox":
                    WebDriverManager.firefoxdriver().setup();
                    driver = new FirefoxDriver();
                    break;
                default:
                    System.out.println("No matching browser");
                    driver = null;
            }
        }
        driver.manage().deleteAllCookies();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
        
        return driver;
    }

    public static WebDriver getDriver() {
        return driver;
    }
}
