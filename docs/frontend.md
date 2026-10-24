# 3. Frontend (PWA)

## 3.1 Overview

The Redu PWA is the app Senior 1 and Senior 2 learners use on phones, tablets and shared school computers. It keeps working offline and syncs progress when the connection returns.

**Repository:** [techsus-frontend](https://github.com/akirachix/techsus-frontend)  

**Live Informational Website:** [techsus-informational-website](https://techsus-informational-website.vercel.app/) 

**Figma Design:** [techsus-figma](https://www.figma.com/design/hUEsE9K1gWfhSikpvKXHp1/Techsus?node-id=0-1&p=f&t=2PJh07Go9hSBUXCN-0)

**Miro User Flows:** [User flows](https://miro.com/app/board/uXjVHhT12Tw=/?share_link_id=339217939856)  

**PRD:** [View the PRD](https://docs.google.com/document/d/1ZzsUonfYsgqL1A5Ih9aDHilT-tGYrnPQ-BfTSA_OyJs/edit?tab=t.0)

## 3.2 Main functions

- **Learn:** subjects, topics and lessons
- **Assessments:** quizzes with feedback and a catch-up plan
- **AI tutor:** curriculum-based help, online only
- **Progress:** results and next steps
- **Offline packages:** lessons downloaded to the device
- **Sync:** progress saved locally and sent when back online

## 3.3 Getting started

**Prerequisites:** Node.js, npm, Git, the environment variables, and the [Backend](backend.md) running or its URL.

```bash
git clone https://github.com/akirachix/techsus-frontend.git
cd techsus-frontend
npm install
npm run dev
```
```bash
npm run build
npm run start
```

## 3.4 Tech stack

| Area | Choice |
|---|---|
| Framework | Next.js (app router) |
| Styling | Tailwind CSS |
| Language | JavaScript (`.jsx`) |
| Offline storage | IndexedDB through Dexie |
| PWA | Web app manifest and a Serwist service worker |

## 3.5 Project structure

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


## 3.6 Screens

Each screen is built from its [Figma](https://www.figma.com/design/hUEsE9K1gWfhSikpvKXHp1/Techsus?node-id=0-1&p=f&t=2PJh07Go9hSBUXCN-0) mockup first, then connected to the API.

| Area | Screens |
|---|---|
| Start | Splash, Welcome, Sign up, Sign in (with **Use offline mode**), Setup |
| Learn | Home, My Learning, Subject, Lesson |
| AI tutor | Conversations, Chat |
| Assessments | Practice quiz, Check-in, Quiz result |
| Progress | Progress overview |
| Offline | Offline Packages (in progress) |
| Admin | Overview, Learner Management, Curriculum |



