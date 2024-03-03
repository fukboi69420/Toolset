$webRequest = New-Object System.Net.WebClient
$webRequest.Proxy = [System.Net.WebRequest]::DefaultWebProxy
$webRequest.Proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials

try {
    $response = $webRequest.DownloadString("http://www.msftncsi.com/ncsi.txt")
    Write-Host "Internet connection is active."
} catch {
    Write-Host "Internet connection is not active."
}

pause