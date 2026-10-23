# Techsus_Technical_Documentation

## Technical Documentation Manifest

Technical documentation for **Redu**, a Progressive Web App (PWA) for refugee S1-S2 learners in Uganda, built by Team Techsus.

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

Open `http://127.0.0.1:8000/` in your browser. The site reloads when you save a file.

### Contributing to the Docs
* Create a branch from `main` (for example `docs/overview-draft`) and open a PR when done.
* Put images in `docs/assets/images/`.
* Follow the shared page shape: title, one-line summary, sections, then a Related links section.

### Code Standards
* **Git Workflow:** Branch naming, PR process and reviews.
* **Conventions:** Linting, naming and folder structure.