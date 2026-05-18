[CmdletBinding()]
param(
    [string]$Source = ".",
    [string]$Output = "dist/pdf",
    [string]$PdfEngine = "",
    [string]$Pandoc = "pandoc",
    [string[]]$ExtraPandocArgs = @()
)

$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$LinkFilter = Join-Path $PSScriptRoot "filters/markdown-links-to-pdf.lua"
$ExcludedDirectories = @(".git", ".venv", "dist", "node_modules")

function Resolve-RepoPath {
    param([string]$PathValue)

    if ([System.IO.Path]::IsPathRooted($PathValue)) {
        return [System.IO.Path]::GetFullPath($PathValue)
    }

    return [System.IO.Path]::GetFullPath((Join-Path $RepoRoot $PathValue))
}

function Get-RelativePath {
    param(
        [string]$BasePath,
        [string]$TargetPath
    )

    $base = [System.IO.Path]::GetFullPath($BasePath)
    $target = [System.IO.Path]::GetFullPath($TargetPath)

    if (-not $base.EndsWith([System.IO.Path]::DirectorySeparatorChar)) {
        $base = "$base$([System.IO.Path]::DirectorySeparatorChar)"
    }

    $baseUri = [System.Uri]$base
    $targetUri = [System.Uri]$target
    $relativeUri = $baseUri.MakeRelativeUri($targetUri)

    return [System.Uri]::UnescapeDataString($relativeUri.ToString()).Replace(
        "/",
        [System.IO.Path]::DirectorySeparatorChar
    )
}

function Test-IsExcluded {
    param(
        [string]$RelativePath
    )

    $parts = $RelativePath -split "[\\/]+"
    foreach ($part in $parts) {
        if ($ExcludedDirectories -contains $part) {
            return $true
        }
    }

    return $false
}

if (-not (Get-Command $Pandoc -ErrorAction SilentlyContinue)) {
    throw "Pandoc executable '$Pandoc' was not found. Install Pandoc or pass -Pandoc with the executable path."
}

if ($PdfEngine -and -not (Get-Command $PdfEngine -ErrorAction SilentlyContinue)) {
    throw "PDF engine '$PdfEngine' was not found. Install it or pass -PdfEngine with another Pandoc-supported PDF engine."
}

if (-not (Test-Path -LiteralPath $LinkFilter)) {
    throw "Pandoc link rewrite filter was not found: $LinkFilter"
}

$SourceRoot = (Resolve-Path -LiteralPath (Resolve-RepoPath $Source)).Path
$OutputRoot = Resolve-RepoPath $Output
New-Item -ItemType Directory -Force -Path $OutputRoot | Out-Null

$markdownFiles = Get-ChildItem -LiteralPath $SourceRoot -Recurse -File -Filter "*.md" |
    Where-Object {
        $relativePath = Get-RelativePath -BasePath $SourceRoot -TargetPath $_.FullName
        -not (Test-IsExcluded -RelativePath $relativePath)
    } |
    Sort-Object FullName

if (-not $markdownFiles) {
    Write-Host "No Markdown files found under $SourceRoot"
    exit 0
}

foreach ($markdownFile in $markdownFiles) {
    $relativePath = Get-RelativePath -BasePath $SourceRoot -TargetPath $markdownFile.FullName
    $relativePdfPath = [System.IO.Path]::ChangeExtension($relativePath, ".pdf")
    $outputFile = Join-Path $OutputRoot $relativePdfPath
    $outputDirectory = Split-Path -Parent $outputFile
    $resourcePath = "$($markdownFile.DirectoryName)$([System.IO.Path]::PathSeparator)$SourceRoot"

    New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null

    $pandocArgs = @(
        "--from=gfm+smart",
        "--standalone",
        "--resource-path=$resourcePath",
        "--lua-filter=$LinkFilter",
        "--output=$outputFile"
    )

    if ($PdfEngine) {
        $pandocArgs += "--pdf-engine=$PdfEngine"
    }

    if ($ExtraPandocArgs) {
        $pandocArgs += $ExtraPandocArgs
    }

    $pandocArgs += $markdownFile.FullName

    Write-Host "Rendering $relativePath -> $outputFile"
    & $Pandoc @pandocArgs

    if ($LASTEXITCODE -ne 0) {
        throw "Pandoc failed while rendering $relativePath"
    }
}

Write-Host ""
Write-Host "Rendered $($markdownFiles.Count) Markdown file(s) to $OutputRoot"
