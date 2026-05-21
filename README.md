# AppSec Standards

This is a collection of standards documents related to Application Security (AppSec).

## Standards

- [CS-1.1 Code Security Training](<CS-1.1 Code Security Training.md>)
- [CS-2.1 Enable Code Scanning](<CS-2.1 Enable Code Scanning.md>)
- [CS-2.2 Automation of Code Scanning](<CS-2.2 Automation of Code Scanning.md>)
- [CS-3.1 Third Party Licenses](<CS-3.1 Third Party Licenses.md>)
- [CS-4.1 Code Scanning Vulnerability Threshold Achieved](<CS-4.1 Code Scanning Vulnerability Threshold Achieved.md>)
- [CS-5.1 Secrets in Code](<CS-5.1 Secrets in Code.md>)
- [VM-1.1 DAST Scan Report](<VM-1.1 DAST Scan Report.md>)
- [VM-1.2 DAST Vulnerabilities Threshold](<VM-1.2 DAST Vulnerabilities Threshold.md>)
- [VM-1.3 DAST Recurrent Scanning](<VM-1.3 DAST Recurrent Scanning.md>)

## Guidance

- [Citizen Developers and Vibe Coders](<CITIZEN-DEVELOPERS-VIBE-CODERS.md>)
- [Supply Chain Security](<SUPPLY-CHAIN-SECURITY.md>)
- [Supply Chain Security Roadmap](<SUPPLY-CHAIN-ROADMAP.md>)
- [Wiz Adoption Roadmap](<WIZ-ROADMAP.md>)

## PDF

This repository uses Pandoc to render Markdown files to PDF. The renderer finds every `*.md` file in the repo and writes PDFs to `dist/pdf/`.

Prerequisites:

- Pandoc
- A Pandoc-supported PDF engine, such as Typst, MiKTeX, TeX Live, or wkhtmltopdf.

Run the renderer from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/render-markdown-to-pdf.ps1
```

Use a different PDF engine:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/render-markdown-to-pdf.ps1 -PdfEngine typst
```

Render from a specific source directory or write to a different output directory:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/render-markdown-to-pdf.ps1 -Source . -Output dist/pdf
```

The script preserves the repository folder structure under `dist/pdf/` and rewrites internal links that point to `.md` files so they point to the matching `.pdf` files.
