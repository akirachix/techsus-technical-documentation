# Quality Assurance Process

## Purpose

The Redu Quality Assurance (QA) process ensures that the informational website and student Progressive Web App (PWA) are reliable, accessible, understandable and visually consistent across the devices and connectivity conditions expected by learners.

QA checks more than whether the application loads. It confirms that learners can find the correct subject and topic, understand lessons, complete practice activities, continue learning offline, save their progress and return later without losing their work.

The QA process also protects learner privacy by checking that one learner cannot access another learner’s account, progress, saved content or personal information.

## QA scope

The frontend QA process covers:

- Visual consistency with the approved Redu designs.
- Responsive layouts on smartphones, tablets and desktop computers.
- Navigation and user interactions.
- Accessibility and readable content.
- Browser compatibility.
- PWA installation and updates.
- Service-worker behaviour.
- Offline lessons and approved resources.
- IndexedDB storage.
- Progress synchronisation after reconnection.
- Authentication and learner data separation.
- Loading, empty, success and error states.
- Performance on low-cost devices and slow networks.
- Contact-form behaviour on the informational website.
- Regression testing after frontend changes.

## QA approach

Testing should take place throughout development rather than only before release.

The process follows this sequence:

~~~text
Review the requirement
        ↓
Define the expected user outcome
        ↓
Implement the interface
        ↓
Test the normal user flow
        ↓
Test invalid and interrupted conditions
        ↓
Record and prioritise defects
        ↓
Fix confirmed issues
        ↓
Run regression testing
        ↓
Complete QA sign-off
~~~

Each feature should be tested from the learner’s perspective. The team should verify not only whether the technical action succeeds, but also whether the user understands what happened.

## Test environments

Testing should include the main environments used by Redu learners and project stakeholders.

| Environment | Purpose |
|---|---|
| Chrome on Android | Main mobile browser and PWA installation |
| Chrome on desktop | Development and school-computer testing |
| Firefox | Browser compatibility |
| Safari on iOS | iPhone and iPad behaviour |
| Edge | Desktop compatibility |
| Small Android smartphone | Small-screen and limited-resource testing |
| Tablet | Shared-device and classroom testing |
| Laptop or desktop | Wider-screen experience |

The team should record the browser version, operating system, device and build or commit being tested.

Recommended viewport sizes are:

~~~text
360 × 800 — small smartphone
390 × 844 — modern smartphone
768 × 1024 — tablet
1280 × 800 — laptop
1440 × 900 — desktop
~~~

## Functional testing

Functional testing confirms that every important control performs the correct action and gives the user useful feedback.

The team should test:

- Website navigation links.
- Mobile menu behaviour.
- Subject selection.
- S1 and S2 class selection.
- Topic selection.
- Lesson opening and navigation.
- Glossary and simpler-English explanations.
- Practice and assessment submission.
- Progress updates.
- Recommendations.
- Offline package downloads.
- AI tutor interactions.
- Contact-form submission.
- Logout and account switching.

Each flow should be tested under normal, invalid, empty, loading and interrupted conditions.

### Contact-form testing

The QA team should confirm that:

- Required fields cannot be left empty.
- Invalid email addresses are rejected.
- A loading state appears during submission.
- The submit button prevents accidental duplicate submissions.
- A success message appears after a successful submission.
- A useful error message appears when submission fails.
- Entered information is not unnecessarily lost after a recoverable error.
- The form does not request sensitive information that is not needed.

Suggested messages include:

~~~text
Thank you for contacting the Redu team. We have received your message.
~~~

~~~text
We could not send your message. Please check your connection and try again.
~~~

## Student user-flow testing

The core learner journey should be tested from beginning to end.

~~~text
1. Open Redu.
2. Sign in or complete onboarding.
3. Select S1 or S2.
4. Select a subject.
5. Select a topic.
6. Open a lesson.
7. Read the lesson content.
8. Open a glossary explanation if needed.
9. Ask the AI tutor for support if available.
10. Complete a practice activity.
11. Save or update progress.
12. Close and reopen the application.
13. Confirm that progress is retained.
14. Download content for offline use.
15. Disconnect from the internet.
16. Continue learning offline.
17. Reconnect to the internet.
18. Synchronise progress.
19. Confirm that the update is saved once.
~~~

The flow should be tested with both a new learner and a returning learner.

## Visual QA

Visual QA confirms that the implementation follows the approved Redu design and brand guidelines.

The review should check:

- Logo placement and size.
- Correct blue, cool white and maroon colours.
- Typography hierarchy.
- Button styles.
- Card spacing.
- Icon alignment.
- Image quality and cropping.
- Borders, radius and shadows.
- Mobile menu layout.
- Form layout.
- Lesson-content spacing.
- Empty states.
- Loading states.
- Success states.
- Error states.
- Selected, active and disabled states.
- Text wrapping on small screens.

The informational website and the student PWA may use different layouts, but they should remain recognisably part of the same Redu product.

Visual testing should compare the implementation with the approved design, wireframe or component specification rather than relying only on personal preference.

## Responsive testing

The Redu interface must remain usable on shared smartphones, tablets and desktop computers.

QA should confirm that:

- Content does not overflow horizontally.
- Text remains readable without unnecessary zooming.
- Buttons and controls are large enough for touch interaction.
- Menus fit within the viewport.
- Forms are usable on small screens.
- Cards stack correctly on mobile devices.
- Images do not hide important content.
- Lesson navigation remains available in portrait orientation.
- Landscape orientation does not break the learning experience.
- Long headings wrap naturally.
- Dialogues and pop-ups remain fully visible.
- No important action is pushed outside the screen.

The interface must not assume that the learner has a large screen, a mouse, a keyboard or a fast connection.

## Accessibility testing

Redu should follow WCAG 2.1 AA accessibility principles where applicable.

QA should check:

- Keyboard-only navigation.
- Visible focus indicators.
- Correct heading order.
- Semantic HTML.
- Labels for all form fields.
- Descriptive names for buttons and links.
- Alternative text for meaningful images.
- Empty alternative text for decorative images.
- Sufficient colour contrast.
- Accessible error messages.
- No keyboard traps.
- Text resizing without loss of content.
- Reduced-motion support.
- Clear language and readable line length.
- Status information that is not communicated through colour alone.

For example, a completed lesson should include a completion label or icon in addition to a green colour. An offline state should display a text label such as `Offline` or `Saved on this device`.

## PWA testing

The PWA should be tested in both the browser and installed application modes.

QA should confirm that:

- The web app manifest is available.
- The application has the correct name and short name.
- Required icons are available.
- The application can be installed from a supported browser.
- The installed application opens correctly.
- The app shell loads when the network is unavailable.
- Approved resources are available offline.
- Service-worker registration succeeds.
- Service-worker updates are handled safely.
- Old assets are not used after a successful update.
- Learner data is not unexpectedly deleted during an update.
- Offline and online states are clearly communicated.
- The application recovers after a failed update.

Next.js bundles the application during the build process. The service worker is responsible for caching the app shell, approved static resources and offline content. It does not replace Next.js or duplicate the framework’s bundling process.

## Cache storage and IndexedDB testing

The PWA uses different browser storage mechanisms for different types of data.

~~~text
Cache Storage:
App shell, static assets and approved cacheable resources.

IndexedDB:
Lessons, offline-package metadata, progress records, assessment drafts and sync events.
~~~

QA should verify that:

- Downloaded lessons are saved correctly.
- Package versions are recorded.
- Lesson progress is saved locally.
- Assessment drafts remain available after a page refresh.
- Sync events receive unique client identifiers.
- Replayed events are not stored twice.
- Offline content is connected to the correct subject and class.
- Local data is associated with the correct learner.
- Local data is cleared or isolated correctly after logout.
- Storage errors produce a clear message.
- Corrupted or incomplete content is not treated as usable.

## Offline package testing

Offline packages must be tested before being made available to learners.

QA should verify that:

- Only published packages can be downloaded.
- The package title, subject and class are correct.
- The package version is displayed.
- The package size is displayed where appropriate.
- Download progress is visible.
- Interrupted downloads can be retried.
- The package checksum is verified.
- Corrupted packages are rejected.
- Required lessons are available after download.
- Supporting images and diagrams open offline.
- Package content matches the selected subject and class.
- Withdrawn or outdated packages are handled safely.
- The learner can remove an offline package when appropriate.

## Progress synchronisation testing

Offline progress must be saved locally and synchronised safely when the connection returns.

The main test flow is:

~~~text
1. Log in while online.
2. Open a lesson.
3. Disconnect the device.
4. Change the lesson progress.
5. Confirm that the progress is stored locally.
6. Close and reopen the PWA while offline.
7. Confirm that the progress is still available.
8. Reconnect to the internet.
9. Start synchronisation.
10. Confirm that the server accepts the update once.
11. Repeat the sync request.
12. Confirm that no duplicate progress is created.
~~~

QA should also test:

- Network failure during synchronisation.
- App closure during synchronisation.
- Expired login sessions.
- Duplicate sync events.
- Partial synchronisation.
- Invalid content IDs.
- Server errors.
- Outdated package versions.
- Incorrect device time.
- Multiple offline changes to the same lesson.
- Synchronisation after a long period offline.

The client device timestamp should not be treated as the authoritative ordering mechanism. The server should record when the event was received and processed.

## Assessment testing

Assessment testing should confirm that learner answers and progress are not lost.

QA should test:

- Starting a diagnostic, practice activity or quiz.
- Displaying the correct question set.
- Saving an unfinished attempt.
- Leaving and resuming an attempt.
- Selecting and changing answers before submission.
- Submitting an answer once.
- Handling a slow or interrupted submission.
- Displaying feedback.
- Completing an assessment.
- Saving identified learning gaps.
- Displaying recommendations.
- Preventing duplicate attempts caused by repeated clicks.
- Preserving an offline attempt until it can be synchronised.

## AI tutor testing

The AI tutor should be tested as a learning-support feature rather than as an unrestricted chatbot.

QA should confirm that:

- The learner can ask a question from the correct lesson or topic.
- The request includes the relevant learning context.
- The response is displayed clearly.
- The learner can request a simpler explanation.
- Loading states are shown while the response is being generated.
- Errors are explained in plain language.
- Out-of-scope questions are handled safely.
- Responses are associated with the correct learner and topic.
- Saved responses can be accessed offline where supported.
- Personal information is not unnecessarily included in the AI request.
- The interface does not claim that the AI response is always correct.

## Authentication and privacy testing

The frontend must protect learner information.

QA should confirm that:

- Unauthenticated users cannot access protected learner routes.
- A learner cannot view another learner’s progress.
- Changing an identifier in a URL or request does not expose another account.
- Logout removes the active session.
- Cached private data is not visible after logout.
- A second learner using the same device sees only their own data.
- Admin-only screens are not available to student accounts.
- Session expiry is handled safely.
- Passwords are never displayed in error messages.
- Learner codes and personal information are not exposed in logs.
- AI requests do not include unnecessary personal information.
- Protected data is not included in public website pages.

## Performance testing

Performance testing is important because Redu targets learners who may use low-cost devices and slow or unreliable networks.

QA should review:

- Initial page-load time.
- Lesson-loading time.
- Image sizes.
- JavaScript bundle size.
- Time required to open downloaded lessons.
- IndexedDB read and write performance.
- Offline-package download behaviour.
- Memory usage during long study sessions.
- AI response loading behaviour.
- Performance when many topics are displayed.
- Recovery after a slow or interrupted connection.

The application should load content progressively. It should not load every subject, topic and lesson at the same time when the learner has selected only one subject.

## Defect severity

### Critical

The product cannot be used or a serious privacy or security problem exists.

Examples:

- A learner can access another learner’s data.
- The application cannot open after installation.
- Progress is permanently deleted.
- Authentication exposes sensitive information.
- Offline data is corrupted.

### High

A major learning or product flow is blocked.

Examples:

- A learner cannot open lessons.
- Offline progress cannot synchronise.
- Assessment answers disappear.
- The PWA cannot be installed.
- The contact form loses submitted information.

### Medium

The feature works incorrectly but a workaround exists.

Examples:

- A recommendation opens the wrong lesson.
- A glossary control fails on one browser.
- An image is missing while the lesson text remains available.
- A non-critical offline package update is delayed.

### Low

The issue does not prevent the user from completing the task.

Examples:

- Minor spacing inconsistency.
- Small icon misalignment.
- Slight colour difference.
- Non-critical text-wrapping issue.

## Defect report format

Each defect should include:

~~~text
Title:
Environment:
Device and browser:
Build or commit:
Precondition:
Steps to reproduce:
Expected result:
Actual result:
Severity:
Screenshot or recording:
Related requirement:
~~~

### Example defect report

~~~text
Title: Lesson progress is duplicated after reconnection

Environment: Chrome on Android
Device: Shared Android smartphone
Build: feature/offline-progress
Precondition: Biology S1 package is downloaded

Steps:
1. Open the Cell Structure lesson.
2. Disconnect the network.
3. Complete the lesson.
4. Close and reopen the PWA.
5. Reconnect to the network.
6. Start synchronisation.
7. Repeat synchronisation.

Expected result:
The lesson remains completed and the progress event is processed once.

Actual result:
Two identical progress events are created.

Severity:
High
~~~

## Regression esting

Regression testing should be completed after changes to:

- Navigation.
- Authentication.
- Service-worker logic.
- IndexedDB schemas.
- Offline packages.
- Progress handling.
- Assessment submission.
- AI tutor screens.
- Shared design components.
- Responsive layouts.
- Brand colours or typography.
- Contact-form behaviour.

A change to a shared component should be checked in both:

~~~text
Informational website
Student PWA
~~~

The team should not assume that a component that works on the homepage will automatically work correctly inside the learning experience.

## Definition of Done

A frontend task is complete when:

- The approved design has been implemented.
- The feature works on mobile, tablet and desktop layouts.
- Loading, empty, success and error states are included.
- Keyboard navigation works.
- Controls have accessible labels.
- Offline behaviour has been tested where applicable.
- Learner data is correctly isolated.
- No new console errors or warnings are introduced.
- Relevant tests have been recorded.
- Another team member has reviewed the change.
- Documentation has been updated where the behaviour changed.
- No critical or high-severity defects remain open.
- Final regression testing is complete.

## QA sign-off checklist

Before a release or demonstration, the team should confirm:

~~~text
[ ] Website navigation works
[ ] PWA navigation works
[ ] Responsive layouts have been checked
[ ] Redu colours and typography are consistent
[ ] Logo usage is correct
[ ] Contact-form validation works
[ ] Subject and class selection works
[ ] Topics and lessons open correctly
[ ] Glossary and simpler explanations work
[ ] Practice and assessment flows work
[ ] AI tutor loading and error states work
[ ] Progress is saved correctly
[ ] Offline packages download correctly
[ ] Downloaded lessons and images work offline
[ ] IndexedDB data persists correctly
[ ] Service-worker behaviour has been checked
[ ] Synchronisation does not create duplicates
[ ] Logout protects the previous learner’s data
[ ] Accessibility checks are complete
[ ] Performance has been reviewed on a low-cost device
[ ] No critical or high-severity defects remain
[ ] Final regression testing is complete
[ ] QA results have been reviewed by the team
~~~

## QA summary

The Redu QA process ensures that the product is visually consistent, technically reliable and suitable for real learning conditions.

The main quality goal is for a learner to:

~~~text
Open Redu
    ↓
Find the correct subject and topic
    ↓
Understand the lesson
    ↓
Continue learning offline
    ↓
Save progress safely
    ↓
Reconnect without losing work
    ↓
Access only their own information
~~~

QA is complete only when the interface works for the learner’s real environment, not only when it works on a developer’s computer.
