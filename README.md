# Techsus_Technical_Documentation

> Documentation status: This repository contains the Techsus technical documentation for Redu. It is a design and planning document for the product and its proposed architecture. Implementation details should be treated as design-level guidance until they are verified against the actual application repositories, infrastructure configuration, and deployment setup.
>
> Verification boundary: This workspace contains documentation assets only. Live application code, runtime behavior, infrastructure configuration, and deployment state are not verified in this repository and should be treated as proposed or unverified unless confirmed elsewhere.

## Technical Documentation Manifest

Technical documentation for **Redu**, a Progressive Web App (PWA) for refugee S1-S2 learners in Uganda, built by Team Techsus.

### Documentation maturity

| Area | Status | Evidence in this repo |
|---|---|---|
| Project overview | Verified as design-level documentation | README + docs/index.md |
| Architecture | Partially verified as proposed architecture | docs/architecture.md, diagram references |
| Backend/API | Partially verified as target design | docs/backend.md |
| Frontend | Partially verified as target design | docs/frontend.md |
| Security | Partially verified as requirements and design controls | docs/security.md |
| Deployment | Partially verified as target deployment model | docs/deployment-process.md |
| Local docs site | Verified | MkDocs configuration and successful local build |
| Professional app code and runtime configuration | Not available in this workspace | Not yet present in repo |

This documentation set is intentionally explicit about its evidence boundary: it documents the Redu product vision and proposed implementation approach, but it is not a runtime-verified implementation record.

### Review and validation automation

This repository now includes lightweight review support to improve traceability and consistency:

- `scripts/evidence_collector.sh` lists the key documentation and repository evidence files
- `scripts/mkdocs_build_and_link_check.sh` runs the local docs validation build
- `.github/workflows/ci-review.yml` runs the documentation checks in CI
- `templates/architecture-template.md` and `templates/testing-template.md` provide starter sections for future authors

These files are designed to make the documentation review process more repeatable without inventing implementation details.

### 1. Overview
* **Product Purpose:** Plain-language explanation of what Redu does.
* **Problem Statement:** The secondary-transition dropout problem Redu addresses.
* **Target Audience:** Learners (MVP 1), administrators and teachers (MVP 2).
* **Key Features:** Learn, Assessments, View Progress, Offline Packages, AI Tutor.

### 2. Architecture & Design
* **System Diagram:** PWA, Redu API, database and Gemini.
* **Component Breakdown:** Responsibilities of every component.
* **Data Model:** ERD and data dictionary.
* **Brand Guidelines:** Colours, typography, icons and UI patterns.

### 3. Engineering
* **Frontend (PWA):** Next.js structure, routing, PWA setup, offline storage and sync.
* **Backend & Database:** FastAPI structure, API reference, authentication and database.
* **AI Tutor:** Gemini usage, curriculum grounding, guardrails and evaluation.

### 4. Quality & Security
* **Security & Compliance:** Threat model, data protection and OWASP mapping.
* **QA Process:** Test strategy, coverage and defect management.

### 5. Deployment & DevOps
* **CI/CD Pipelines:** Automated workflows from push to production.
* **Environments:** Local, staging and production.

---

## Operational Guide

### Getting Started
* **Prerequisites:** Python 3.11 and Git.
* **Installation:** Clone the repository and install the dependencies.

### Running the Docs Locally

```bash
git clone <repository-url>
cd techsus-technical-documentation
pip install -r requirements.txt
mkdocs serve
```

Open http://127.0.0.1:8000/ in your browser. The site reloads when you save a file.

> The repository URL should be replaced with the actual project remote for this documentation repo. This command is only for local documentation preview and does not imply that the Redu app or backend is available in this workspace.

### Contributing to the Docs
* Create a branch from `main` (for example `docs/overview-draft`) and open a PR when done.
* Put images in `docs/assets/images/`.
* Follow the shared page shape: title, one-line summary, sections, then a Related links section.

### Code Standards
* **Git Workflow:** Branch naming, PR process and reviews.
* **Conventions:** Linting, naming and folder structure.