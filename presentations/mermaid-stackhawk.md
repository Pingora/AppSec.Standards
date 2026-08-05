    generate a mermaid diagram that outlines how StackHawk works - the `hawk` cli, the web app being scanned, and how http traffic flows between `hawk` cli (agent), the web app victim, and the StackHawk SaaS platform. Don't use <br> or special chars for diagram labels.

```mermaid
sequenceDiagram
    participant Dev as Developer or CI Pipeline
    participant Hawk as hawk CLI agent
    participant App as Target Web Application
    participant SaaS as StackHawk SaaS Platform

    Dev->>Hawk: Run hawk scan with stackhawk.yml
    Hawk->>SaaS: Authenticate scan and fetch scan config
    SaaS-->>Hawk: Scan policy and attack definitions

    loop Dynamic security testing
        Hawk->>App: HTTP request with attack payloads
        App-->>Hawk: HTTP response
    end

    Hawk->>SaaS: Send findings metadata and scan status
    SaaS-->>Dev: Findings visible in StackHawk UI
```

---------------------------------------------------------------------------------------------------

    generate a mermaid diagram that outlines how StackHawk Flight Path works - their docker container with TightVNC webcanvas for login, that sends .HAR files to an AI model that then generates .yml files that get stored in their SaaS platform for later use.

    2. make it a sequence diagram

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant FP as Flight Path Docker Container
    participant VNC as TightVNC Web Canvas
    participant App as Target Web App
    participant AI as AI Model
    participant SaaS as StackHawk SaaS Platform

    Dev->>FP: Start Flight Path container
    FP->>VNC: Expose interactive browser via TightVNC
    Dev->>VNC: Log in and navigate application
    VNC->>App: User-driven authentication & app interaction
    App-->>FP: HTTP/S traffic captured
    FP->>FP: Generate .HAR files
    FP->>AI: Send .HAR files for analysis
    AI->>AI: Infer attack surface & auth flows
    AI-->>FP: Generate stackhawk.yml
    FP->>SaaS: Upload .yml scan configuration
    SaaS->>Dev: Config available for reuse in scans
```

---------------------------------------------------------------------------------------------------
