# Penetration Testing Requirements and Scorecard

## Requirements

Penetration testing should focus on web application vulnerabilities and, at a minimum, cover the [OWASP Top 10](https://owasp.org/www-project-top-ten/).

The assessment should also consider common vulnerabilities observed in our web applications, including:

- SQL injection
- Cross-site scripting (XSS), including reflected and stored XSS
- XML external entity (XXE) injection
- XSLT injection
- Information disclosure, including:
  - Exposed log pages
  - Unnecessary exposure of email addresses or cell phone numbers
- Broken object-level authorization (BOLA), such as accessing another user's data when access should not be permitted
- Broken authentication, such as:
  - Routes that are reachable without a token
  - Routes that appear to require a token but do not actually enforce authentication

### Technology Stack

Testing should account for the following technologies:

- Java with Spring Boot
- .NET 2.0, .NET 6.0, and .NET 8.0
- PHP
- React with Node.js

## Scorecard
