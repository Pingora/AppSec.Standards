
    Generate a mermaid diagram that outlines how Wiz does SAST/IaC/Secrets/SCA scanning - their scan backend periodically connecting to Git providers like BitBucket, and then showing results in their web portal. make it a sequence diagram.

```mermaid

sequenceDiagram
    autonumber
    participant Dev as Developer
    participant Git as Git Provider (Bitbucket)
    participant WizConn as Wiz Git Integration
    participant WizScan as Wiz Scan Backend
    participant WizCtx as Wiz Cloud Context Engine
    participant WizUI as Wiz Web Portal

    Dev->>Git: Push / Update repo (code + IaC)
    Note right of Git: Source code, dependencies, IaC templates, secrets-at-rest

    WizConn-->>Git: Periodic poll or webhook trigger
    Git-->>WizConn: Repo metadata, commit refs

    WizConn->>WizScan: Fetch relevant repo content
    Note right of WizScan: Stateless analysis jobs (run per repo / commit)

    WizScan->>WizScan: SAST (custom + OSS rules)
    WizScan->>WizScan: SCA (dependencies & CVEs)
    WizScan->>WizScan: IaC misconfiguration analysis
    WizScan->>WizScan: Secrets detection

    WizScan->>WizCtx: Send raw findings
    WizCtx->>WizCtx: Correlate with cloud runtime context
    Note right of WizCtx: Exposure paths, IAM, network reachability, asset criticality

    WizCtx->>WizUI: Enriched findings & risk prioritization

    Dev->>WizUI: View issues, risk scoring, repos & cloud assets
```


------------------------------------------------------------------------------------------

    Generate two short mermaid sequence diagrams showing how Wiz IDE plugins work, and also how Wiz CICD scans work to break builds and give devs quick feedback.

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant IDE as IDE Plugin
    participant Wiz as Wiz Platform

    Dev->>IDE: Write / save code
    IDE->>Wiz: Send code context
    Wiz-->>IDE: Findings & severity
    IDE-->>Dev: Inline warnings + fixes
```

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant CI as CI/CD Pipeline
    participant Wiz as Wiz Platform

    Dev->>CI: Push code / open PR
    CI->>Wiz: Run security scan
    Wiz-->>CI: Results + policy verdict
    CI-->>Dev: Fail build & actionable feedback
```