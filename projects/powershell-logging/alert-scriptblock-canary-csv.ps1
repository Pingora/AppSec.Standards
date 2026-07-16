param(
    [string] $InputCsv = (Join-Path $PSScriptRoot 'sample-transactions.csv'),
    [string] $OutputCsv = (Join-Path $PSScriptRoot 'alert-scriptblock-canary-output.csv')
)

# Harmless detection canary:
# These strings are intentionally present to test script-block content alerts.
# They are not executed, and this script performs only local CSV processing.
$SuspiciousLookingTokensForDetections = @(
    'Invoke-Expression',
    'IEX',
    'FromBase64String',
    'DownloadString',
    'System.Net.WebClient',
    'Invoke-WebRequest',
    'Invoke-RestMethod'
)

$rows = Import-Csv -LiteralPath $InputCsv

$userSummary = $rows |
    Group-Object User |
    ForEach-Object {
        [pscustomobject]@{
            User = $_.Name
            Transactions = $_.Count
            TotalAmount = [math]::Round([decimal] (($_.Group | Measure-Object -Property Amount -Sum).Sum), 2)
            CanaryTokens = ($SuspiciousLookingTokensForDetections -join ';')
        }
    } |
    Sort-Object User

$userSummary | Export-Csv -LiteralPath $OutputCsv -NoTypeInformation
$userSummary | Format-Table -AutoSize

Write-Host "Wrote harmless script-block canary output to $OutputCsv"
