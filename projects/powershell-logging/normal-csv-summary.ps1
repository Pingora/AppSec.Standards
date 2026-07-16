param(
    [string] $InputCsv = (Join-Path $PSScriptRoot 'sample-transactions.csv'),
    [string] $OutputCsv = (Join-Path $PSScriptRoot 'normal-summary-output.csv')
)

$rows = Import-Csv -LiteralPath $InputCsv

$summary = $rows |
    Group-Object Department |
    ForEach-Object {
        $total = ($_.Group | Measure-Object -Property Amount -Sum).Sum
        [pscustomobject]@{
            Department = $_.Name
            Count = $_.Count
            TotalAmount = [math]::Round([decimal] $total, 2)
        }
    } |
    Sort-Object Department

$summary | Export-Csv -LiteralPath $OutputCsv -NoTypeInformation
$summary | Format-Table -AutoSize

Write-Host "Wrote normal CSV summary to $OutputCsv"
