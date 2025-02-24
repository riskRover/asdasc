# Define installation paths
$mavenVersion = "3.8.8"
$javaVersion = "jdk-17.0.2_windows-x64_bin"
$chromeDriverVersion = "133.0.6943.126"
$chromeVersion = "133.0.6943.127"
$chromeDriverPath = "C:\Program Files\Google\Chrome\Application\chromedriver.exe"
$javaPath = "C:\Program Files\Java"
$mavenPath = "C:\Program Files\Maven"

# Set Execution Policy to Unrestricted for CurrentUser
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Install Java (OpenJDK)
$javaUrl = "https://download.java.net/java/GA/jdk17/17.0.2/6/GPL/openjdk-17.0.2_windows-x64_bin.zip"
$javaZip = "$env:temp\openjdk.zip"
Invoke-WebRequest -Uri $javaUrl -OutFile $javaZip
Expand-Archive -Path $javaZip -DestinationPath $javaPath

# Set Java environment variables
$env:JAVA_HOME = "$javaPath\$javaVersion"
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $env:JAVA_HOME, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("Path", "$env:JAVA_HOME\bin;" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine), [System.EnvironmentVariableTarget]::Machine)

# Install Maven
$mavenUrl = "https://downloads.apache.org/maven/maven-3/$mavenVersion/binaries/apache-maven-$mavenVersion-bin.zip"
$mavenZip = "$env:temp\apache-maven.zip"
Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip
Expand-Archive -Path $mavenZip -DestinationPath $mavenPath

# Set Maven environment variables
$env:MAVEN_HOME = "$mavenPath\apache-maven-$mavenVersion"
[System.Environment]::SetEnvironmentVariable("MAVEN_HOME", $env:MAVEN_HOME, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("Path", "$env:MAVEN_HOME\bin;" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine), [System.EnvironmentVariableTarget]::Machine)

# Install ChromeDriver
$chromeDriverUrl = "https://chromedriver.storage.googleapis.com/$chromeDriverVersion/chromedriver_win32.zip"
$chromeDriverZip = "$env:temp\chromedriver.zip"
Invoke-WebRequest -Uri $chromeDriverUrl -OutFile $chromeDriverZip
Expand-Archive -Path $chromeDriverZip -DestinationPath "C:\Program Files\Google\Chrome\Application"

# Install Chrome
$chromeUrl = "https://dl.google.com/chrome/install/$(($chromeVersion).Replace('.', '_'))/chrome_installer.exe"
$chromeInstaller = "$env:temp\chrome_installer.exe"
Invoke-WebRequest -Uri $chromeUrl -OutFile $chromeInstaller
Start-Process -FilePath $chromeInstaller -ArgumentList "/silent" -Wait

Write-Host "Installation Complete: Maven, Java, ChromeDriver, and Chrome are set up."
