# 7. Code Standards

## 7.1 Overview

This section describes the rules every contributor follows so the Redu codebase stays consistent, readable and safe to change. In both the backend and the frontend, these rules are not only guidelines. They are checked automatically, and code that fails the checks cannot be merged.

Frontend repository: [techsus-frontend](https://github.com/akirachix/techsus-frontend)

Backend repository: [techsus-backend](https://github.com/akirachix/techsus-backend)

---

## 7.2 Tools

| Part | Tool | Purpose |
|---|---|---|
| Backend | Ruff (`ruff check`) | Linting: finds bugs, unused code and bad patterns |
| Backend | Ruff (`ruff format`) | Formatting: keeps the code style identical across the team |
| Backend | pytest and pytest-cov | Runs the automated tests and measures coverage |
| Backend | uv | Runs every tool inside the project environment |
| Frontend | npm lint script | Linting: finds errors and bad patterns in the Next.js code |
| Frontend | Prettier 3.6.2 | Formatting: keeps the code style identical across the team |
| Frontend | npm build script | Confirms the whole app compiles for production |

---

## 7.3 Backend checks

Run these three commands from the root of the backend repository before every push. They are the same commands the CI/CD pipeline runs.

```bash
uv run --no-sync ruff check .
uv run --no-sync ruff format --check .
uv run --no-sync pytest --cov --cov-report=term-missing
```

| Command | What it does |
|---|---|
| `ruff check .` | Lints every file and lists problems |
| `ruff format --check .` | Reports files that are not formatted correctly, without changing them |
| `pytest --cov --cov-report=term-missing` | Runs all tests and prints which lines are not covered by a test |

The `--no-sync` flag tells `uv` to use the environment as it is, without reinstalling packages first. This keeps the run fast and makes it behave the same way in CI.

If a check fails, these commands fix most issues automatically:

```bash
uv run ruff check . --fix
uv run ruff format .
```

Then run the three checks again to confirm everything passes.

---

## 7.4 Frontend checks

Run these commands from the root of the frontend repository before every push.

```bash
npm install
npm run lint
npx prettier@3.6.2 --check .
npm run build
```

| Command | What it does |
|---|---|
| `npm install` | Installs the exact packages the project needs |
| `npm run lint` | Checks the code for errors and bad patterns |
| `npx prettier@3.6.2 --check .` | Reports files that are not formatted correctly, without changing them |
| `npm run build` | Compiles the app for production and fails if anything is broken |

The Prettier version is fixed at `3.6.2`, so every developer and the CI/CD pipeline format the code in exactly the same way.

If the format check fails, this command fixes the formatting automatically:

```bash
npx prettier@3.6.2 --write .
```

Then run the checks again to confirm everything passes.

A passing build matters for a PWA, because a broken build would stop learners from receiving updates.

---

## 7.5 CI/CD enforcement

The same checks run automatically on every pull request, in both repositories.

1. A developer opens a pull request.
2. The pipeline runs the checks for that repository: lint, format check and tests for the backend, lint, format check and build for the frontend.
3. If any step fails, the pull request is marked as failed and must be fixed before merging.
4. When all steps pass and a teammate approves, the change can be merged into `main`.
5. The merge triggers deployment, as described in [Deployment & DevOps](deployment-process.md).

```text
Backend:   push --> lint --> format check --> tests + coverage --> review --> merge --> deploy
Frontend:  push --> lint --> format check --> build --> review --> merge --> deploy
```

Because the checks run on every pull request, broken or badly formatted code never reaches production.

---

## 7.6 Code style rules

### Backend (Python)

| Area | Rule |
|---|---|
| Files and functions | `snake_case`, for example `get_topic` |
| Classes and schemas | `PascalCase`, for example `AITutorConversationSummary` |
| Constants | `UPPER_SNAKE_CASE` |
| Type hints | Add type hints to function parameters and return values |
| Routes | Group under `/api/v1` and give each route a clear summary for the `/docs` page |

### Frontend (Next.js)

| Area | Rule |
|---|---|
| Components | `PascalCase` names and files, for example `LessonCard` |
| Functions and variables | `camelCase`, for example `getLessons` |
| Constants | `UPPER_SNAKE_CASE` |
| Components | Keep them small and focused on one job |
| Environment variables | Use `NEXT_PUBLIC_` only for values that are safe to show in the browser |

### Both

| Area | Rule |
|---|---|
| Names | Use clear names. Write `topic_id` or `topicId`, not `t` |
| Functions | Do one job and stay short enough to read without scrolling |
| Comments | Explain why something is done, not what the code already says |
| Secrets | Never write keys, passwords or tokens in code. Read them from environment variables |
| Unused code | Delete it instead of commenting it out |

---

## 7.7 Testing standards

Every new feature or bug fix comes with tests. A good test set covers four kinds of cases:

| Type | What it checks | Example |
|---|---|---|
| Happy path | The normal, correct use | Get a topic that exists and receive `200` |
| Negative | Wrong or invalid input | Get a topic that does not exist and receive `404` |
| Boundary | Limits of allowed values | Smallest and largest accepted values |
| Edge | Unusual but possible situations | Empty list of topics, missing optional fields |

Backend test files are named `test_*.py`, and each test name describes the situation it covers. The coverage report from `--cov-report=term-missing` lists lines with no test, and contributors use it to find gaps.

---

## 7.8 Git and review standards

| Rule | Detail |
|---|---|
| Branches | Work on a separate branch, never directly on `main` |
| Commits | Small commits with a short message that says what changed |
| Pull requests | One purpose per pull request, with a clear description |
| Review | At least one teammate reviews before merging |
| Checks | All CI checks must pass before merging |

---

## 7.9 Pre-merge checklist

Before asking for a review, confirm that:

- [ ] Backend: `ruff check .` and `ruff format --check .` pass
- [ ] Backend: all tests pass and new code has tests
- [ ] Frontend: `npm run lint`, `npx prettier@3.6.2 --check .` and `npm run build` pass
- [ ] No secrets or `.env` files are committed
- [ ] The pull request description explains the change