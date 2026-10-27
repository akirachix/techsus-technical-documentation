# 8. Deployment & DevOps

## 8.1 Overview

This section explains how the Redu platform is built, deployed and monitored. It covers the Next.js PWA frontend, the FastAPI backend on Heroku and the database, and it is written so a new team member can ship a change without help.

Frontend repository: [techsus-frontend](https://github.com/akirachix/techsus-frontend)

Backend repository: [techsus-backend](https://github.com/akirachix/techsus-backend)

Backend API: [https://redu-8a6d68a6558b.herokuapp.com](https://redu-8a6d68a6558b.herokuapp.com)

API documentation: [https://redu-8a6d68a6558b.herokuapp.com/docs](https://redu-8a6d68a6558b.herokuapp.com/docs)

---

## 8.2 Deployment architecture

```text
Learner device (phone, tablet, school computer)
        |
        |  HTTPS
        v
[Vercel]  ---> Redu PWA (Next.js, service worker for offline use)
        |
        |  HTTPS / REST (/api/v1/...)
        v
[Heroku]  ---> FastAPI backend
        |
        +----------------------+
        |                      |
        v                      v
[PostgreSQL database]    [Google Gemini API]
Learners, topics,        Curriculum-based
progress, conversations  AI tutor
```

!!! note
    The AI tutor works online only. Lessons, quizzes and progress work offline and sync when the connection returns.

---

## 8.3 Environments

| Environment | Frontend | Backend |
|---|---|---|
| Local | http://localhost:3000 | http://127.0.0.1:8000 |
| Production | Vercel | heroku |

---

## 8.4 Environment variables

Secrets are never committed to the repository. They are set in the hosting dashboard for each service, and locally in a `.env` file that is listed in `.gitignore`.

### Backend (Heroku)

| Variable | Description |
|---|---|
| `DATABASE_URL` | Connection string for the PostgreSQL database |
| `REDU_AUTH_SECRET` | Secret key used to sign login tokens |
| `GEMINI_API_KEY` | Key for the Gemini AI tutor service |

### Frontend (Vercel)

| Variable | Description |
|---|---|
| `NEXT_PUBLIC_API_URL` | Address of the backend API |

!!! warning
    Variables that start with `NEXT_PUBLIC_` are included in the browser code and can be seen by anyone. Never put a secret in one.

---

## 8.5 Frontend deployment

The Next.js frontend is deployed on Vercel and served over HTTPS. HTTPS is required for a PWA, because browsers only allow service workers on secure connections.

Build locally to check that everything compiles:

```bash
npm install
npm run build
```

Deployment steps:

1. Connect the `techsus-frontend` repository to Vercel.
2. Add `NEXT_PUBLIC_API_URL` with the backend address from section 8.1.
3. Merge into `main`. Vercel builds and publishes the new version automatically.

### PWA update behaviour

When a new version is published, the service worker downloads it in the background. Learners get the new version the next time they reopen the app. Downloaded lesson packages stay on the device during an update.

---

## 8.6 Backend deployment

The FastAPI backend runs on Heroku. A `Procfile` at the root of the backend repository tells Heroku how to start the app.

Deployment steps:

1. Connect the [techsus-backend](https://github.com/akirachix/techsus-backend) repository to the Heroku app.
2. Add `DATABASE_URL`, `REDU_AUTH_SECRET` and `GEMINI_API_KEY` under Settings, then Config Vars.
3. Merge into `main` to trigger a deployment.
4. Call the health endpoint to confirm the service is running.

### Health check

```http
GET https://redu-8a6d68a6558b.herokuapp.com/health
```

A healthy service returns `200 OK` with a JSON response. The same endpoint can be tried from the API documentation page under the `default` section by selecting Try it out.

---

## 8.7 Database

The backend connects to a PostgreSQL database through the `DATABASE_URL` variable. Schema changes are made with migration scripts, never by editing tables by hand.

Before running a migration in production, test it locally first. Take a backup of the production database before any change that removes or renames columns.

---

## 8.8 CI/CD

Every change follows the same path:

1. Create a branch and make the change.
2. Open a pull request.
3. A teammate reviews it and the team checks that the build passes.
4. Merge into `main`.
5. Vercel and Heroku detect the merge and deploy the new version automatically.

```text
feature branch --> pull request --> review --> main --> Vercel (frontend) + Heroku (backend)
```

---

## 8.9 Monitoring and logs

| What | Where | Why |
|---|---|---|
| Frontend build and runtime logs | Vercel dashboard | Find failed builds and page errors |
| Backend logs | Heroku dashboard, Logs | Find errors and slow requests |
| Health check | `/health` endpoint | Confirm the API is up |
| API testing | `/docs` page | Try endpoints without extra tools |

---

## 8.10 Rollback

If a release causes problems:

1. Open the dashboard for the affected service (Vercel or Heroku).
2. Redeploy the last working version, or revert the merge commit on `main`.
3. Confirm the fix with the health check and by opening the app.

---

## 8.11 Troubleshooting

| Problem | Likely cause | Fix |
|---|---|---|
| Build fails on Vercel | Missing `NEXT_PUBLIC_API_URL` or a code error | Read the build log and check the variable |
| App shows old content after a release | Service worker is serving the cached version | Close all app tabs and reopen, or clear site data |
| Frontend cannot reach the API | Wrong API address or CORS setting | Check `NEXT_PUBLIC_API_URL` and the backend allowed origins |
| Backend crashes on startup | Missing config var | Check that `DATABASE_URL`, `REDU_AUTH_SECRET` and `GEMINI_API_KEY` are set on Heroku |
| Offline lessons do not sync | Learner not signed in or API unreachable | Sign in again and check the backend logs |
| AI tutor does not respond | Invalid `GEMINI_API_KEY` or no internet connection | Check the key on Heroku and confirm the device is online |