# Function to get CPU information
function Get-CPUInfo {
    $cpuInfo = Get-WmiObject -Class Win32_Processor
    Write-Output "CPU Manufacturer: $($cpuInfo.Manufacturer)"
    Write-Output "CPU Model: $($cpuInfo.Name)"
    Write-Output "Number of Cores: $($cpuInfo.NumberOfCores)"
    Write-Output "Number of Logical Processors: $($cpuInfo.NumberOfLogicalProcessors)"
}

# Function to get RAM information
function Get-RAMInfo {
    $ramInfo = Get-WmiObject -Class Win32_PhysicalMemory
    $totalRAMBytes = ($ramInfo | Measure-Object -Property Capacity -Sum).Sum
    $totalRAMGB = [math]::Round(($totalRAMBytes / 1GB), 2)
    Write-Output "Total Installed RAM: ${totalRAMGB}GB"
}

# Function to get OS information
function Get-OSInfo {
    $osInfo = Get-WmiObject -Class Win32_OperatingSystem
    Write-Output "Operating System: $($osInfo.Caption)"
    Write-Output "Version: $($osInfo.Version)"
    Write-Output "Installed Date: $($osInfo.InstallDate)"
}

# Function to get disk information
function Get-DiskInfo {
    $diskInfo = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = 3"
    foreach ($disk in $diskInfo) {
        $diskSizeGB = [math]::Round(($disk.Size / 1GB), 2)
        $freeSpaceGB = [math]::Round(($disk.FreeSpace / 1GB), 2)
        Write-Output "Drive Letter: $($disk.DeviceID)"
        Write-Output "Volume Name: $($disk.VolumeName)"
        Write-Output "Total Size: ${diskSizeGB}GB"
        Write-Output "Free Space: ${freeSpaceGB}GB"
        Write-Output ""
    }
}

# Function to get network information
function Get-NetworkInfo {
    $networkInfo = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where { $_.IPEnabled -eq $true }
    foreach ($network in $networkInfo) {
        Write-Output "Network Adapter: $($network.Description)"
        Write-Output "IP Address(es): $($network.IPAddress -join ', ')"
        Write-Output "MAC Address: $($network.MACAddress)"
        Write-Output ""
    }
}

# Function to get GPU information
function Get-GPUInfo {
    $gpuInfo = Get-WmiObject -Class Win32_VideoController
    foreach ($gpu in $gpuInfo) {
        Write-Output "GPU Manufacturer: $($gpu.VideoProcessor)"
        Write-Output "GPU Name: $($gpu.Name)"
        Write-Output "Driver Version: $($gpu.DriverVersion)"
        Write-Output ""
    }
}

# Print computer details
Write-Output "Computer Details:"
Write-Output "-----------------"
Get-CPUInfo
Write-Output ""
Get-RAMInfo
Write-Output ""
Get-OSInfo
Write-Output ""
Get-DiskInfo
Write-Output ""
Get-NetworkInfo
Write-Output ""
Get-GPUInfo
Write-Output ""

# keep terminal open
pause

