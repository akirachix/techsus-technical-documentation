# Developer Guide

## Scope

This guide explains how to work with this documentation repository, how to validate the site locally, and how to maintain the project documentation with an explicit evidence boundary.

> Verification boundary: This repository contains documentation and design artifacts only. It does not include the production application source code, deployment configuration, or live runtime evidence. Any implementation detail that is not backed by repository evidence should be treated as planned or unverified.

---

## Repository purpose

This repository exists to document the Redu product vision, system plan, technical design, quality approach, and security considerations. It is intended to support stakeholder review, architecture discussion, implementation planning, and project communication.

The docs are useful for:

- understanding the project purpose and user experience
- reviewing the proposed system design
- recording requirements and risks
- explaining security and quality expectations
- preparing technical handoff work for implementation teams

This repository is not the implementation repository for the product itself.

---

## Repository structure

```text
techsus-technical-documentation/
├── README.md
├── mkdocs.yml
├── requirements.txt
├── docs/
│   ├── index.md
│   ├── architecture.md
│   ├── backend.md
│   ├── frontend.md
│   ├── security.md
│   ├── qa-process.md
│   ├── code-standards.md
│   ├── deployment-process.md
│   ├── developer-guide.md
│   └── assets/
│       └── images/
├── site/
│   └── generated MkDocs output
└── doc-review-skill.md
```

---

## Local setup

### Prerequisites

- Python 3.9+
- pip
- Git

### Install dependencies

```bash
git clone <repository-url>
cd techsus-technical-documentation
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Run the documentation site locally

```bash
mkdocs serve
```

Then open the local URL shown in the terminal, usually:

```text
http://127.0.0.1:8000/
```

### Build the site

```bash
mkdocs build
```

This command checks that the documentation site can be generated successfully and is the best local validation step for this repository.

---

## Documentation workflow

When updating project documentation, follow this sequence:

1. Confirm whether the claim is supported by repository evidence.
2. If it is not supported, label it as planned, proposed, or unverified.
3. Keep the wording specific to the actual project scope.
4. Prefer clear status language over unsupported certainty.
5. Build the site before finishing the change.

### Status language to use

Use wording like:

- Verified: supported directly by repository evidence
- Partially verified: supported in part but missing evidence elsewhere
- Planned: intentionally described as a future design or implementation target
- Unverified: not enough evidence available in this repo

Avoid wording like:

- “production-ready”
- “live system”
- “confirmed deployment”
- “implemented”

unless the relevant evidence is directly available in the project.

---

## Quality checks for documentation changes

Before merging a documentation update, confirm the following:

- [ ] The content matches the project scope of this repo
- [ ] Claims are labelled as verified, planned, or unverified
- [ ] No private credentials, tokens, or personal data are included
- [ ] Internal navigation still works
- [ ] The MkDocs build completes successfully
- [ ] Any external links are still relevant and safe

### Minimum validation command

```bash
mkdocs build
```

This is the main validation command for this repository and should be run after every documentation change.

---

## Troubleshooting

### The site does not start

Check:

- Python environment is active
- requirements are installed
- the repo is the correct root directory
- the `mkdocs` command is available

### Build fails

Check:

- broken file references in the docs
- invalid Markdown structure
- missing files referenced in `mkdocs.yml`
- invalid navigation entries

### Claims feel too certain

If a claim cannot be proven from the repo, rewrite it as a proposal, design note, or open question instead of presenting it as fact.

---

## Common terms

| Term | Meaning |
|---|---|
| Redu | The learner-support platform and product concept described in this documentation |
| PWA | Progressive Web App |
| MVP | Minimum viable product |
| AI tutor | Proposed educational assistant layer grounded in approved learning content |
| Verification boundary | The limit of what has evidence in this repository |
| Planned design | A proposed implementation not yet confirmed by runtime code |

---

## Contribution guidance

When contributing:

- keep edits specific to the project and repo scope
- document assumptions explicitly
- identify missing evidence instead of filling gaps with guesses
- prefer clear project language over generic technical statements
- keep one change per update when possible

A good documentation update is one that is traceable, honest, and easy to validate.
