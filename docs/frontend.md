# 3. Frontend (PWA)

## Overview

The Redu PWA is described here as the app Senior 1 and Senior 2 learners use on phones, tablets, and shared school computers. It is expected to keep working offline and sync progress when the connection returns.

> Documentation status: This frontend guide reflects the intended Redu PWA design and product requirements. It should be treated as a planning document until the actual frontend repository and build setup are available for verification.
>
> Verification boundary: This repo does not include the live frontend application code, the production build, or the deployment configuration. Product and technical details in this section are therefore unverified unless confirmed elsewhere.

**Repository reference:** [techsus-frontend](https://github.com/akirachix/techsus-frontend)  

## Main functions

- **Learn:** subjects, topics and lessons
- **Assessments:** quizzes with feedback and a catch-up plan
- **AI tutor:** curriculum-based help, online only
- **Progress:** results and next steps
- **Offline packages:** lessons downloaded to the device
- **Sync:** progress saved locally and sent when back online

## Getting started

**Prerequisites:** Node.js, npm, Git, the environment variables, and the [Backend](backend.md) running or its URL.

```bash
git clone <frontend-repository-url>
cd techsus-frontend
npm install
npm run dev
```
```bash
npm run build
npm run start
```

## Tech stack

| Area | Choice |
|---|---|
| Framework | Next.js (app router) |
| Styling | Tailwind CSS |
| Language | JavaScript (`.jsx`) |
| Offline storage | IndexedDB through Dexie |
| PWA | Web app manifest and a Serwist service worker |

## Project structure

```text
techsus-frontend/
├── app/
│   ├── (learner)/           
│   │   ├── dashboard/        
│   │   ├── learn/            
│   │   ├── lessons/[lessonsId]/  
│   │   ├── offline/          
│   │   ├── profile/
│   │   └── progress/
│   └── (admin)/              
├── components/               
├── features/                 
├── hooks/
├── lib/
│   ├── db.js                 
│   └── sync.js               
└── public/                   
```


## Screen

[Figma](https://figma.com) 

[![Homepage Preview](assets/images/homepage.png)](https://vercel.app)
