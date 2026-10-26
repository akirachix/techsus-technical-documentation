# How It Works

## Overview

Redu is a Progressive Web App (PWA) that helps refugee learners in Senior 1 and Senior 2 in Uganda understand lessons in English, catch up on gaps from interrupted schooling, and keep studying when data and connectivity are limited.


## The learner journey

[Redu user flows](https://miro.com/app/board/uXjVHhT12Tw=/?share_link_id=339217939856)


## System architecture
<a href="../assets/images/SAD.png" target="_blank">System Architecture Diagram</a>


## Components

| Step | Frontend | Backend | Data (from the data model) |
|---|---|---|---|
| Register and set up | Registration and profile screens | Authentication and user management | `users` |
| Diagnostic | Assessments screen | Assessment scoring and gap analysis | `learner_assessments` |
| Personalised learning | Learn screens | Recommendations | `topics`, `learning_content`, `lesson_progress` |
| AI study support | Tutor interface | Redu API, then Gemini with File Search | `ai_tutor_interactions` |
| Offline learning | Offline Packages screen, local storage | Package delivery | `offline_packages` |
| Sync | Background sync | Sync event validation | `sync_events` |
| Progress | Progress screen | Progress tracking | `learner_progress` |

## Where it works

Redu is responsive, so the same experience works on smartphones, tablets and school computers, including shared devices.


## Related

- [Product Requirements Document (PRD)](https://docs.google.com/document/d/1ZzsUonfYsgqL1A5Ih9aDHilT-tGYrnPQ-BfTSA_OyJs/edit?tab=t.0)
- [User flows (Miro)](https://miro.com/app/board/uXjVHhT12Tw=/?share_link_id=339217939856)
- [Features](features.md)
- [Architecture](architecture.md)
- [Frontend (PWA)](frontend.md)