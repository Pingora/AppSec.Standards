Compared to Nexus/Artifactory, GitHub Packages and Azure Artifacts are not sufficient:

1. They lack a repository firewall that can quarantine or block malicious or typosquatted packages
1. They do not have a dependency cooldown mechanism
1. They have less support for other package managers like npm, PyPI, Maven, NuGet, or containers
1. They don't have the ability to proxy or mirror other repos
1. They don't have centralized policy enforcement, package provenance, or auditability
1. There is platform lock-in to GitHub or Azure*

Nexus and Artifactory are preferred because they provide these features.

If we rely on GitHub Packages or Azure Artifacts, we run these risks:
- We may see developers consuming new packages that are malicious or typosquatted
  - This could leak dev credentials
  - This could introduce malware into local/dev/uat/prod systems
- We lack visibility into package sources
- We may be unable to quarantine or delay a malicious package before first consumption.
- We may lack reliable provenance showing where a package came from, when it entered the organization, and which builds consumed it.
- We may be unable to promote only approved artifacts between environments.
- We may face longer containment and recovery times during a package compromise or registry outage.
- We may need to assemble and operate multiple disconnected security and artifact-management tools.
- We may create inconsistent controls across teams using GitHub, Azure DevOps, and other development platforms.
- We may incur significant migration and rework costs if a more mature repository platform is introduced later.