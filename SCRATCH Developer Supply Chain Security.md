=== Developer Supply Chain Security ===

# links

- [Developer Software Chain Security](https://bayview0.sharepoint.com/:f:/s/ISRC/IgBXs7tCosqNSb5ZwVQVYWqTARcMCjtus_CpVChmc-CcsgU?e=ISgmUM)

# problem statement

"Implementing control over software development package management resolution, and preventing data infil/exfil."

Currently, we are exposed to software supply chain risk as almost all our developers pull directly from internet package repositories like PyPI and NPM. If we are hit by a "watering-hole attack" such as Shai-Hulud, we would have our developer secrets compromised. We currently only have reactive defenses that can come in after-the-compromise such as Wiz SCA scanning.

We can solve this by preventing developers from pulling packages from external package repositories, and only allowing them to pull from internally managed package repositories.

# Requirements

1. Developers must only pull packages from internally managed package repositories.

# stakeholders

- All of Nick Akl's direct reports
  - Carlos Cortines
  - Mazi F
  - Sid S

- Steve Dixon
- Wing Chau

- Matt Miller
  - Wei Zhang

- Keith Nam
  - Marcelo Olivas

- Henry Post
- Jay Rosario
- Chet Heacox
- Dan F
- Jared Stoll
- Cheryl Klein
- Jay Pearlman

## lakeview

.

## bayview

.

# phase 0: Identify what coding languages are used
- HENRY TODO: use graphql to pull this data from Wiz...
  - <https://bitbucket.org/bayview-asset-management/wizreportinggraphql/src/main/>

# phase 1: SBOM management (artifactory/nexus)
- all devs, regardless of level, will get packages ONLY from internal repos
- we block all external package repos.

## phase 1.1: cleanroom OSS packages from Seal Security

## phase 1.2: cleanroom docker images from ChainGuard


# phase end: 

- HENRY TODO: W/ Jessica G, in Secure Software Standard, require that devs only use internal package repos. Ban external.
  - <https://bayview0.sharepoint.com/sites/DocDB/Published%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FDocDB%2FPublished%20Documents%2FSecure%20Software%20Standard%2Epdf&parent=%2Fsites%2FDocDB%2FPublished%20Documents>