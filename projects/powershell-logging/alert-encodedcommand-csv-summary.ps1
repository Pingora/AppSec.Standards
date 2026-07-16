param(
    [string] $InputCsv = (Join-Path $PSScriptRoot 'sample-transactions.csv'),
    [string] $OutputCsv = (Join-Path $PSScriptRoot 'alert-encoded-summary-output.csv')
)

# Harmless detection canary:
# This launches a child Windows PowerShell process with -NoProfile, -ExecutionPolicy Bypass,
# and -EncodedCommand so process-creation and script-block detections have something safe to catch.
$escapedInput = $InputCsv.Replace("'", "''")
$escapedOutput = $OutputCsv.Replace("'", "''")

$command = @"
`$rows = Import-Csv -LiteralPath '$escapedInput'
`$summary = `$rows |
    Group-Object Department |
    ForEach-Object {
        `$total = (`$_.Group | Measure-Object -Property Amount -Sum).Sum
        [pscustomobject]@{
            Department = `$_.Name
            Count = `$_.Count
            TotalAmount = [math]::Round([decimal] `$total, 2)
        }
    } |
    Sort-Object Department
`$summary | Export-Csv -LiteralPath '$escapedOutput' -NoTypeInformation
Write-Host "Harmless encoded-command CSV summary wrote $escapedOutput"
"@

$encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($command))
$windowsPowerShell = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'

& $windowsPowerShell -NoProfile -ExecutionPolicy Bypass -EncodedCommand $encoded
