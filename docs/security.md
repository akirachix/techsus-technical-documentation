# Security & Compliance

## Overview

Redu is designed for shared devices, intermittent connectivity and limited data access, so security and privacy controls focus on three areas: protecting learner data on the device, protecting data sent to the AI provider, and controlling who can access what.

[Security and Privacy Requirements Document](https://docs.google.com/document/d/1-kPxt0l5GAgZ3o5jbz7FttLjaLEyBqhlWSchm8PiShg/edit?tab=t.0#heading=h.pxmp0n9n3ysl).


## Security architecture

<a href="../assets/images/SSAD.png" target="_blank">System Security Architecture Diagram</a>

## Key controls 

| Area | Control |
|---|---|
| Sessions | Inactivity logout after 10 minutes, with a warning first; absolute maximum session of 8 hours |
| Sign-in | Lock-out after 5 failed sign-ins in 15 minutes (QA plan value) |
| Administrators | Multi-factor authentication (MFA) required |
| Data collected | Name, email address and class level only |
| Encryption | Encrypted at rest; TLS 1.2 or higher in transit |
| AI requests | Credentials stay server-side; pseudonymous learner IDs; names and emails redacted |
| AI usage | Quota of 100 questions per day (QA plan value) |
| Offline packages | Signed, versioned and hash-verified |
| Retention | Automated deletion after 3 months (period still to be formally confirmed) |

## Security requirements

| ID | Area | Requirement summary | Priority |
|---|---|---|---|
| SR-001 | Authentication | Minimised learner identifiers, hashed credentials, MFA for all administrator accounts | Must have |
| SR-002 | Data protection | No unnecessary data sent to the AI provider; redaction before AI requests; encryption at rest and in transit; defined retention and automated deletion; minimum group size for aggregated reports; diagnostic fairness testing | Must have |
| SR-003 | API security | Gemini credentials server-side; AI requests only through the Redu API; answers grounded in approved curriculum; `NOT_IN_CURRICULUM` fallback; server-side validation of sync events; idempotent sync; rate limiting and AI quotas; prompt-injection and AI safety testing | Must have |
| SR-004 | Authorization | Role-based access control; object-level authorization on every request; learners cannot see other learners' records or staff functions; least privilege; audited role changes; uploaded content reviewed before AI indexing | Must have |
| SR-006 | Session management | 10-minute inactivity logout with warning; unsaved work saved locally first; 8-hour maximum session; server-side invalidation on logout, timeout or admin revoke; local data cleared on logout or account switch; expiry policy for offline data | Must have |
| SR-007 | Secure configuration | Signed, versioned offline packages with hash verification; safeguarding protocol and named contact; harm disclosures to the AI tutor escalate to a human; no hardcoded secrets; dependency scanning in CI/CD | Must have |
| SR-008 | Input validation | Validated diagnostic inputs; AI output checked for unsafe or age-inappropriate responses; uploads malware-scanned | Must have |
| SR-009 | Logging and monitoring | Security-relevant actions logged; tamper-protected audit logs; no unnecessary learner data in logs; AI budget alerts; AI provider availability monitored | Must have |
| SR-010 | Privacy | Consent model for minors; plain-language privacy notice; data protection impact assessment (DPIA) before the pilot | Must have |
| SR-011 | Incident response | Breach notification workflow; tested incident response process | Must have |
| SR-012 | Governance | Named security and privacy owner; findings tracked through remediation and verification | Must have |
| SR-013 | Backup and recovery | Offline or cached fallback when the AI service is unavailable | Should have |
| SR-014 | Security testing | Penetration testing completed before the learner pilot | Must have |

## Privacy requirements

| Area | Requirement |
|---|---|
| Personal data | Collect only what is needed for accounts, learning, diagnostics, progress and system operation |
| Purpose | Use learner data only for learning services, diagnostics, progress support, security and required administration |
| Data minimisation | Collect name, email address and class level |
| Storage | Approved Redu storage locations only, with access controls and encryption |
| Access | Learners see their own data; staff access is role-based and limited to operational need |
| Sharing | Tutor requests go to the approved AI provider only after minimisation and redaction |
| Retention and deletion | Periods must be formally decided before build or pilot; automated deletion after 3 months |
| User rights | A process for access, correction and deletion requests |
| Cross-border transfer | AI processing may happen outside Uganda; provider terms, location and safeguards must be reviewed and approved before deployment |

## Sensitive data

| Data type | Sensitivity | Protection required |
|---|---|---|
| Learner identifier and account data | High | Minimise, role-based access, encryption, secure authentication |
| Assessment results and progress | High | Object-level authorization, encryption, retention and deletion controls |
| Free-text tutor questions | High | Treat as sensitive, minimise logging, redact identifiers before AI processing |
| Safeguarding and distress disclosures | Critical | Human escalation route, strict access control, minimum necessary data, defined retention |
| Offline cached learner data | High | Local protection, session isolation, expiry and clearing, integrity controls |
| Curriculum uploads and source permissions | Medium | Malware scanning, reviewer approval, permission and source records |

## Main threats and controls

| Threat | Affected component | Control |
|---|---|---|
| Shared-device exposure of learner data | PWA, local storage | Account isolation, inactivity logout, local-data clearing, minimised offline data |
| Learner data sent to the AI provider | Redu API, AI integration | Pseudonymisation, redaction, approved provider terms |
| Prompt injection and unsafe AI answers | AI tutor, File Search | Retrieved content treated as data, fixed system rules, curriculum grounding, output checks, adversarial testing |
| Tampered offline package or cache | PWA, offline package | Signed, versioned packages and hash verification |
| Poisoned curriculum upload | Content pipeline | Malware scanning, reviewer approval, source and permission checks |
| API key theft or abuse | AI integration | Server-side secrets, rotation, quotas, rate limits |
| Login or API flooding | API | Rate limiting, quotas, monitoring |
| Broken access control | API, database | Object-level authorization and automated authorization tests |
| Unauthorised staff access | Admin and content functions | RBAC, least privilege, MFA, audit logging |
| Excessive retention | Database, logs | Approved retention schedule and automated deletion |
| Safeguarding disclosure not reaching a person | AI tutor, safeguarding workflow | Defined human escalation route, tested process |
| Small-group report re-identification | Reporting | Minimum group size and suppression of small groups |
| AI provider outage or quota exhaustion | AI integration | Monitoring, quotas, rate limits, offline or cached fallback |
| Third-party library vulnerabilities | Dependencies | Software composition analysis (SCA), updates, security review |


## Third-party services

| Service | Purpose | Data shared | Requirement |
|---|---|---|---|
| Google Gemini API and File Search | AI study support and curriculum retrieval | Pseudonymous learner prompts and approved curriculum content | Server-side API key; provider terms and processing location reviewed; no unnecessary identifiers; monitor quotas and cost |

## Security testing

All of the following must be completed before the learner pilot.

| Test | What it covers |
|---|---|
| Source code review | Peer review plus static analysis (SAST) |
| Dependency and security scanning | SCA, secret scanning and infrastructure-as-code checks in CI/CD |
| Penetration testing | API, PWA, authorization and upload workflow, plus a dynamic (DAST) scan of a staging build |
| Privacy review | DPIA, consent model, redaction, retention and deletion |
| Prompt-injection and AI safety testing | Jailbreaks, injection through uploaded files, off-syllabus requests, the fallback and output filtering |
| Diagnostic fairness testing | Results compared across learner groups, exceptions documented |
| Safeguarding testing | A harm disclosure reaches the named human contact |
| Offline integrity testing | Signature and hash checks, tampered packages, forged and replayed sync events, offline session expiry |
| Authorization testing | Automated proof that a learner cannot read another learner's records or reach staff functions |
| Load and abuse testing | Rate limits, AI quotas, upload limits and the AI-outage fallback |


## Compliance

- Uganda's Data Protection and Privacy Act, 2019 (lawful basis and consent, minimisation, safeguards, cross-border transfer, breach notification, individual rights). Any registration obligation is to be confirmed by legal counsel.
- OWASP Top 10 as the reference list of web application risks.
- This project's security and privacy requirements.
- UNHCR data protection principles (purpose limitation, confidentiality, minimisation) and partner child safeguarding policies, including a protocol for disclosures of harm.
- GDPR and ISO/IEC 27001 as benchmarks where EU funders or partners are involved.
- AI provider data-processing terms approved before deployment, covering no-training terms, retention and processing location.

