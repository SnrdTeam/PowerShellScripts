
function Test-StrongName {

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)][string]$path
    )

    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

    $netFxTools = $env:NETFX_TOOLS
    if ($netFxTools -ne $null) {
        $snTool = "$netFxTools\x64\sn.exe"
    }
    else {
        $snTool = "sn.exe"
    }

    $output = & $snTool -vf $path
    if ($LASTEXITCODE -eq 0) {
        Write-Output "Assembly $path OK"
    } else {
        Write-Output $output
        Write-Error "Assembly $path FAIL"        
    }
}

#$dir = "D:\Projects\SourceControl\AgentNetwork\Gateway\src\Gateway\bin\Debug\netcoreapp1.1"
#Get-ChildItem -Depth 1 -File -Filter *.dll -Path $dir | %{Check-StrongName -path $_.FullName}