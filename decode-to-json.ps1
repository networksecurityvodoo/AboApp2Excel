#==========================================
# Title:  Decode the latest Backup of the App de.simolation.subscriptionmanager to json
# App Download: https://play.google.com/store/apps/details?id=de.simolation.subscriptionmanager&ref=https://github.com/networksecurityvodoo/
# Author: networksecurityvodoo
# Date:   30 April 2023
#==========================================

$currentDate = Get-Date -Format "yyyy-MM-dd"
$fileName = "$currentDate.subscriptions"
$currentDir = Get-Location
$filePath = Join-Path $currentDir $fileName
$outputFilePath = Join-Path $PWD "abos.json"

# read the file content
$fileContent = Get-Content $filePath  -Raw

# remove first three lines
$fileContent = $fileContent -split "`n" | Select-Object -Skip 3 | Out-String

# remove line breaks and white spaces from the base64 encoded string
$base64String = $fileContent.Replace("`n", "").Replace("`r", "").Replace(" ", "")

# decode the base64 string
$jsonContent = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($base64String))

# display the decoded JSON content
$jsonContent

# Write the decoded content to the output file
Set-Content $outputFilePath $jsonContent