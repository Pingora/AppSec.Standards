param(
    [string] $InputCsv = (Join-Path $PSScriptRoot 'sample-transactions.csv'),
    [string] $OutputCsv = (Join-Path $PSScriptRoot 'normal-large-transactions.csv'),
    [decimal] $MinimumAmount = 200
)

$largeTransactions = Import-Csv -LiteralPath $InputCsv |
    Where-Object { [decimal] $_.Amount -ge $MinimumAmount } |
    Sort-Object @{ Expression = { [decimal] $_.Amount }; Descending = $true }

$largeTransactions | Export-Csv -LiteralPath $OutputCsv -NoTypeInformation
$largeTransactions | Format-Table -AutoSize

Write-Host "Wrote transactions >= $MinimumAmount to $OutputCsv"
