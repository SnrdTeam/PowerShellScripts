
function Test-StrongName {

<#
.SYNOPSIS
    Проверка наличия строгого имени у сборки .NET
.DESCRIPTION
    Выполняет проверку подписи сборки с помощью утилиты sn.exe.
.PARAMETER path
    Путь к файлу сборки .NET.
#>

    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)][string]$path
    )

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