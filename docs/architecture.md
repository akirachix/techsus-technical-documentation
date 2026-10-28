# System Architecture

---

## Overview
Redu is a learner-support platform intended to provide structured learning, assessments, and guided tutoring in low-connectivity settings. The project is designed around a single client experience for learners and administrators, supported by a backend service and an AI-assisted learning flow.

> Status: This page describes the intended Redu architecture and should be treated as a design-level proposal until the implementation repositories, deployment configuration, and runtime behavior are verified. The items below are written as planned architecture, not confirmed production implementation.

The system is expected to include a web application, an application programming interface, a shared AI tutoring layer, and storage for learner progress and curriculum data. In the proposed design, the application is organized around a PWA frontend, a centralized API, and AI-grounded lesson content served from curriculum sources.

### Proposed architecture at a glance

* **Client application**: one PWA used by learners and administrators; frontend framework and runtime implementation are still **planned/to be confirmed**.
* **Backend layer**: a centralized API service, expected to use **FastAPI**; host and deployment details are **planned/to be confirmed**.
* **Persistence layer**: expected to use **PostgreSQL** for learner data, progress, assessments, and curriculum metadata; hosting model is **planned/to be confirmed**.
* **AI layer**: planned to use **Google Gemini** with curriculum content grounded in Markdown files and retrieved through an AI file-handling flow.
* **Offline support**: planned to use browser storage such as **IndexedDB** to persist downloaded learning content for offline access.

The proposed design assumes a clean separation of responsibilities: the client does not directly access the database, the AI service is used as a supporting capability rather than a primary workflow controller, and the API is the central access point for application logic.

---

## System Architecture Diagram
<div class="backend-card" autocomplete="off">
    <img src="../assets/images/SAD.png" alt="Redu System Architecture Diagram" style="max-width: 100%; border-radius: 4px; display: block; margin: 0 auto;">
</div>

System Architecture diagram (Lucidspark): [Redu System Architecture Diagram](https://lucid.app/lucidspark/4841b8d1-a8d3-4e68-a6dc-c8f61c3e7c1f/edit?invitationId=inv_02c4820d-c473-464a-9bac-d6ad10fc0f39&page=0_0#)

> Note: This diagram should be read as a design artifact. It reflects the proposed system model and should be validated against actual implementation evidence before being treated as current architecture.

---

## Application Components

### Progressive Web App (PWA)
The PWA is the user-facing layer for learner interaction. In the proposed design, it supports onboarding, lesson delivery, assessments, progress tracking, and downloadable content for offline use. The interface is expected to differentiate learner and administrator views based on user role.

* **Learner view**: select a subject, topic, and lesson; review AI-assisted lesson content; complete diagnostics and quizzes; view progress; download lessons for offline use.
* **Admin view**: monitor usage, engagement, and system-level information.

### Redu API
The API is intended to be the central service layer for the platform. In the proposed design, it authenticates users, enforces access rules, coordinates feature modules, validates data, and acts as the only application-level component that interacts with persistent storage.

### Feature Modules
| Module | Planned responsibility | Uses the AI service |
|---|---|---|
| **Learn** | Display curriculum, generate lesson content, answer learner questions, and record lesson progress. | Yes |
| **Assessments** | Manage assessments, evaluate answers, provide feedback, and produce catch-up guidance. | Yes |
| **View Progress** | Show completed lessons and assessment results. | No |
| **Offline Packages** | Prepare downloadable learning content for use without network access. | No |
| **System Management** | Provide system metrics and operational information to administrators. | No |

### AI Service
The AI service is planned to support lesson generation and assessment feedback by retrieving curriculum content and grounding model responses in approved learning material. In the proposed design, it is a support component rather than a source of business logic or direct database access.

### Curriculum Markdown Files and Gemini Files API
The curriculum is expected to be stored as Markdown content and accompanying media assets. In the proposed model, a one-time content-import process uploads the approved curriculum files to the AI platform so they can be retrieved and used by the tutor during generation.

### Database (PostgreSQL)
The database is intended to store learner data, curriculum metadata, assessment outcomes, progress records, tutor interactions, and offline sync data. In the proposed design, this data is accessed only by the API layer.

### Offline Storage (IndexedDB)
The browser is expected to hold downloaded learning content locally so learners can continue studying without a network connection. This support is intended to improve usability in low-connectivity environments.

---

## Proposed Data Flow

### Learning flow
```text
 [ Learner selects subject, topic, lesson ]
                   │
                   ▼
 [ PWA ] ──► [ Redu API ] ──► [ Learn module ] ──► [ AI service ]
                                                      │
                                   find the relevant curriculum content and related file reference
                                                      │
                                                      ▼
                                        [ Gemini model ]
                           (file reference + prompt → grounded learning response)
                                                      │
                                                      ▼
 [ Learner sees the lesson ] ◄── [ PWA ] ◄── [ Redu API ] ◄── [ Learn module ]
                                                  │
                                                  ▼
                                   [ Persistent storage: progress and lesson data ]
```
1. **Choose**: The learner selects a subject, topic, and lesson in the client application.
2. **Request**: The PWA sends a request to the API, which routes the request to the learning module.
3. **Retrieve content**: The learning module requests curriculum-grounded content from the AI service.
4. **Generate response**: The AI service identifies the relevant curriculum resource and sends the file reference and prompt to the model.
5. **Return result**: The response is returned through the API to the client, where it is presented to the learner and saved as needed.

### Assessment flow
1. The learner starts an assessment. The assessment module requests guidance or evaluation grounded in the relevant curriculum content.
2. The learner submits answers. The AI service evaluates the response against the approved learning material and returns feedback.
3. The API stores the result and progress state for the learner.

### Curriculum-loading flow
1. The curriculum content is prepared in a backend-managed folder as Markdown and related assets.
2. A one-time import or seed process uploads approved curriculum files to the AI platform.
3. The imported content is stored and then used by the application for lesson and assessment generation.
4. The content is refreshed only when the curriculum source changes.

### Offline flow
```text
 [ Learner online ] ──► [ Offline package flow via API ] ──► [ PWA ]
                                                                      │
                                                  stores downloaded lessons in [ IndexedDB ]
                                                                      │
 [ Learner offline ] ◄────── opens saved content from IndexedDB ◄─────┘
```
1. While online, the learner chooses lessons to download.
2. The offline package flow returns the content through the API.
3. The PWA stores the downloaded material locally.
4. While offline, the learner can access the stored content without internet access.
5. When connectivity returns, local progress can be synced back to the backend.

### Administrator flow
The administrator is expected to sign in through the same client experience used by learners. The system-management functions are intended to request aggregated usage information from the API and display operational insights based on persisted data.

---

## Status and review notes

This page is intentionally written as a design brief for Redu rather than a verified implementation record. It should be updated once the real repositories, infrastructure configuration, and runtime behavior are available. At that point, the architecture should be confirmed against code, tests, deployment configuration, and live system behavior.

This document is useful for:
- product and technical planning,
- stakeholder communication,
- architecture review and discussion,
- identifying likely system boundaries and responsibilities.

This document is not yet a verified implementation specification until the following are available:
- actual frontend and backend source code,
- deployment configuration,
- environment variables and hosting setup,
- database schema and migration evidence,
- tests and verification artifacts.

