# Define installation paths
$mavenVersion = "3.8.8"
$javaVersion = "jdk-17.0.2_windows-x64_bin"
#$chromeDriverVersion = "133.0.6943.126"
#$chromeVersion = "133.0.6943.127"
$javaPath = "C:\Program Files\Java"
$mavenPath = "C:\Program Files\Maven"
$chromeInstallerPath = "C:\temp\chrome_installer.exe"
$chromeDriverZipPath = "C:\temp\chromedriver.zip"  # ChromeDriver ZIP will be downloaded here
$chromeDriverExtractPath = "C:\temp\chromedriver"

# Set Execution Policy to Unrestricted for CurrentUser
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Check if the Java directory exists, create it if not
if (-not (Test-Path $javaPath)) {
    Write-Host "Java directory does not exist. Creating: $javaPath"
    New-Item -Path $javaPath -ItemType Directory -Force
}

# Check if the Maven directory exists, create it if not
if (-not (Test-Path $mavenPath)) {
    Write-Host "Maven directory does not exist. Creating: $mavenPath"
    New-Item -Path $mavenPath -ItemType Directory -Force
}

# Create C:\temp directory if it doesn't exist
if (-not (Test-Path "C:\temp")) {
    Write-Host "C:\temp directory does not exist. Creating: C:\temp"
    New-Item -Path "C:\temp" -ItemType Directory -Force
}

# Install Java (OpenJDK)
$javaUrl = "https://download.java.net/java/GA/jdk17/17.0.2/6/GPL/openjdk-17.0.2_windows-x64_bin.zip"
$javaZip = "C:\temp\openjdk.zip"
Invoke-WebRequest -Uri $javaUrl -OutFile $javaZip
Expand-Archive -Path $javaZip -DestinationPath $javaPath

# Set Java environment variables
$env:JAVA_HOME = "$javaPath\$javaVersion"
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $env:JAVA_HOME, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("Path", "$env:JAVA_HOME\bin;" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine), [System.EnvironmentVariableTarget]::Machine)

# Install Maven
$mavenUrl = "https://downloads.apache.org/maven/maven-3/$mavenVersion/binaries/apache-maven-$mavenVersion-bin.zip"
$mavenZip = "C:\temp\apache-maven.zip"
Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip
Expand-Archive -Path $mavenZip -DestinationPath $mavenPath

# Set Maven environment variables
$env:MAVEN_HOME = "$mavenPath\apache-maven-$mavenVersion"
[System.Environment]::SetEnvironmentVariable("MAVEN_HOME", $env:MAVEN_HOME, [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("Path", "$env:MAVEN_HOME\bin;" + [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine), [System.EnvironmentVariableTarget]::Machine)

# Install Chrome
$chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
Invoke-WebRequest -Uri $chromeUrl -OutFile $chromeInstallerPath
Start-Process -FilePath $chromeInstallerPath -ArgumentList "/silent" -Wait

# Check Chrome installation path
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$chromeDriverDestPath = "C:\Program Files\Google\Chrome\Application\chromedriver.exe"

# Install ChromeDriver
$chromeDriverUrl = "https://storage.googleapis.com/chrome-for-testing-public/133.0.6943.126/win64/chromedriver-win64.zip"
Invoke-WebRequest -Uri $chromeDriverUrl -OutFile $chromeDriverZipPath  # Download ChromeDriver ZIP to C:\temp
Expand-Archive -Path $chromeDriverZipPath -DestinationPath $chromeDriverExtractPath -Force

# Move chromedriver.exe to Chrome's install directory if not already present
$chromeDriverExePath = "$chromeDriverExtractPath\chromedriver-win64\chromedriver.exe"

# Check if ChromeDriver and Chrome paths exist separately
if (Test-Path $chromeDriverExePath) {
    if (Test-Path $chromePath) {
        # Check if chromedriver.exe already exists in the destination directory
        if (-not (Test-Path $chromeDriverDestPath)) {
            Write-Host "Moving chromedriver.exe to $chromeDriverDestPath"
            Move-Item -Path $chromeDriverExePath -Destination $chromeDriverDestPath
        } else {
            Write-Host "chromedriver.exe already exists in the destination."
        }
    } else {
        Write-Host "Chrome not found at $chromePath"
    }
} else {
    Write-Host "ChromeDriver not found at $chromeDriverExePath"
}

Write-Host "Installation Complete: Maven, Java, ChromeDriver, and Chrome are set up."
