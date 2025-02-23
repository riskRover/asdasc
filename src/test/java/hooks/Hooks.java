package hooks;

import java.io.IOException;
import org.openqa.selenium.WebDriver;
import factory.Base;
import io.cucumber.java.After;
import io.cucumber.java.Before;

public class Hooks {

    WebDriver driver;

    @Before
    public void setup() throws IOException {
        driver = Base.initilizeBrowser();
        driver.get(System.getenv("APP_URL"));
        driver.manage().window().maximize();
    }

    @After
    public void teardown() {
        driver.quit();
    }
}
