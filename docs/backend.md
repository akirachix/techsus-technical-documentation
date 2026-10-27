# Backend

## Overview
The Redu backend is a FastAPI service that stores learner accounts, the curriculum, assessments and progress, and connects the Redu PWA to the AI tutor. It runs on Heroku and keeps its data in PostgreSQL.

Repository: [techsus-backend](https://github.com)

Live API: [https://herokuapp.com](https://herokuapp.com)

API documentation: [https://herokuapp.com/docs](https://herokuapp.com/docs)

The backend has three main jobs:

- Serve the curriculum (subjects, topics, lessons and questions) for the learner's class level
- Mark assessments and track progress using Redu rules, never the AI
- Answer learner questions through the AI tutor, grounded only on curriculum records

---

## Tech stack

| Part | Technology |
|---|---|
| Framework | FastAPI (Python) |
| Database | PostgreSQL |
| AI service | Google Gemini API and Gemini Files API |
| Hosting | Heroku |
| Package manager | uv |
| Code quality | Ruff and pytest (see [Code Standards](code-standards.md)) |

---

## Getting started

Prerequisites: Python, uv, Git, a PostgreSQL database and a Gemini API key.

```bash
git clone https://github.com.git
cd techsus-backend
uv sync
```

Create a `.env` file in the repository root with the variables from section 4.5, then start the server:

```bash
uv run fastapi dev
```

The API runs at http://127.0.0.1:8000 and the interactive documentation is at http://127.0.0.

---

## Database schema

The data model has eight tables. User ids are UUIDs created on the device or the server, so the same account works across devices and offline.

| Table | What it stores |
|---|---|
| `users` | Every person on the platform: students and administrators. Holds display name, role, class level, hashed password and optional email |
| `topics` | The curriculum outline. One row per topic, with its subject, class level, term, title and order |
| `learning_content` | Lessons, examples and the question bank, tagged to a topic. The AI tutor is grounded only on this table |
| `learner_assessments` | One row per diagnostic, practice set or quiz attempt, with answers, score, gaps found and the catch-up plan |
| `learner_progress` | How far each student has got in each topic, mastery percentage and which lessons are completed |
| `ai_tutor_interactions` | Each question a student asks the AI tutor and the answer, with an option to save it for offline reading |
| `offline_packages` | Downloadable bundles of lessons, exercises and tests for use without internet |
| `sync_events` | A log of every time a device syncs offline progress or downloads a package |

### Main relationships

| From | To | Relationship |
|---|---|---|
| `topics` | `learning_content` | One topic has many lessons and questions |
| `users` | `learner_assessments` | One student has many attempts over time |
| `users` and `topics` | `learner_progress` | One student has one progress record per topic |
| `users` | `ai_tutor_interactions` | One student has many tutor interactions |
| `learning_content` | `ai_tutor_interactions` | Each answer is grounded on one curriculum record |
| `users` | `sync_events` | One student's device can sync many times |
| `offline_packages` | `sync_events` | One package can be downloaded by many learners |

---

## 4.5 Environment variables

Secrets are never committed to the repository. Locally they are kept in a `.env` file that is listed in `.gitignore`. On Heroku they are set under Settings, then Config Vars.

| Variable | Description |
|---|---|
| `DATABASE_URL` | Connection string for the PostgreSQL database |
| `REDU_AUTH_SECRET` | Secret key used to sign login tokens |
| `GEMINI_API_KEY` | Key for the Gemini AI tutor service |

See [Deployment & DevOps](deployment-devops.md) for the frontend variable and the production setup.

---

## Live API docs

FastAPI generates interactive documentation from the code. Every endpoint can be tried directly from the page by selecting Try it out.

| Environment | Address |
|---|---|
| Local | http://127.0.0 |
| Production | https://herokuapp.com/docs |

The page also lists the request and response schemas at the bottom, for example `AITutorConversationSummary`.

---

## Endpoints

Endpoints are grouped under `/api/v1`. The topics endpoints and the health check are shown below. The remaining groups (users, assessments, progress, AI tutor, offline packages and sync) are listed with their parameters on the `/docs` page, which always matches the running code.

| Method | Path | Purpose |
|---|---|---|
| GET | `/health` | Confirms the service is running |
| GET | `/api/v1/topics` | List topics |
| GET | `/api/v1/topics/{topic_id}` | Get one topic |
| PATCH | `/api/v1/topics/{topic_id}` | Update a topic |
| DELETE | `/api/v1/topics/{topic_id}` | Deactivate a topic |

---

## Example API usage

Request:
```http
GET /api/v1/topics/3fa85f64-5717-4562-b3fc-2c963f66afa6
```

Response, `200 OK`:
```json
{
  "topic_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "subject_name": "Mathematics",
  "class_level": "S1",
  "term": 1,
  "title": "Quadratic Equations",
  "sequence_no": 3,
  "created_at": "2026-08-28T11:37:48.770Z"
}
```

Health check:
```http
GET https://herokuapp.com/health
```

A healthy service returns `200 OK`.

---

## Error handling

When a request breaks a schema rule, FastAPI returns `422 Unprocessable Entity` with the exact field and reason. Example: updating a topic with a class level that does not exist.

```json
{
  "detail": [
    {
      "type": "enum",
      "loc": ["body", "class_level"],
      "msg": "Input should be 'S1' or 'S2'",
      "input": "S5",
      "ctx": { "expected": "'S1' or 'S2'" }
    }
  ]
}
```

| Status | Meaning |
|---|---|
| `200 OK` | The request succeeded |
| `404 Not Found` | The record does not exist |
| `422 Unprocessable Entity` | The request data is missing or invalid |

---

## Security and authentication

| Area | How it is handled |
|---|---|
| Passwords | Stored only as a hash. The real password is never saved |
| Roles | Each user is a `student` or an `admin`, and the role decides what they can access |
| Login tokens | Signed with `REDU_AUTH_SECRET` |
| Secrets | Kept in environment variables, never in the code |
| AI key | `GEMINI_API_KEY` stays on the server and is never sent to the browser |
| AI answers | The tutor is grounded only on `learning_content`, to prevent off-syllabus answers |
| Scoring | Answers are marked by Redu rules, never by the AI |
| Transport | All traffic uses HTTPS |

---

## Testing and code quality

The backend is checked on every pull request with lint, format and test commands:

```bash
uv run --no-sync ruff check .
uv run --no-sync ruff format --check .
uv run --no-sync pytest --cov --cov-report=term-missing
```

Tests cover happy path, negative, boundary and edge cases. The full rules are in [Code Standards](code-standards.md).

---

## Deployment

The backend is deployed on Heroku when a change is merged into `main`. Steps, rollback and troubleshooting are in [Deployment & DevOps](deployment-devops.md).
