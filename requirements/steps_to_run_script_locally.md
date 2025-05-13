## To run this project on your local, you should have system_requirements - that you can get installed by running "system_requirement.ps1" script on your (local) windows machine.

To execute this script on your machine, you need to ensure below 
Open Powershell with 'Run as Administrator' mode and refer below steps

1. This command will give you execution-policy permission
```
Get-ExecutionPolicy
```
2. This command will set execution policy to allow scripts to run (for current session)
```
Set-ExecutionPolicy RemoteSigned -Scope Process
```
3. As this script download Maven, Java and Chromedriver from Open-Source (internet), you need to unblock script to execute. This can be done by running below command.
```
Unblock-File -Path "C:\<Path To Script>\system_requirement.ps1"
```
4. Navigate to script location in powershell session
```
cd "C:\Path\To\Your\Script"
```
5. Run the script
```
.\system_requirement.ps1
```
