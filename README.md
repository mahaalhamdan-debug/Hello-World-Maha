# Journali 📓

**Your thoughts, your story.**

Journali is an iOS journaling app built with SwiftUI. It lets you write, edit, bookmark, and search your personal journal entries, and saves them on your device.

## Features

- Splash screen
- Empty state when there are no journals
- Add a new journal with a title and content
- Edit a journal by tapping its card
- Confirmation before discarding unsaved changes
- Swipe to delete, with a confirmation alert
- Bookmark journals
- Sort by bookmark or by entry date
- Search by title or content
- Voice search using the microphone
- Journals are saved on the device with SwiftData

## Built With

- SwiftUI
- SwiftData
- Speech framework
- MVVM architecture

## Project Structure

| Folder | Contents |
|---|---|
| `DesignSystem` | App colors and fonts |
| `Model` | The `Journal` data model |
| `ViewModels` | `JournalViewModel`: the app logic |
| `Views` | All screens and components |
| `Services` | `SpeechRecognizer` for voice search |

## Requirements

- iOS 27 or later
- Xcode 27 or later
- Voice search needs a real iPhone (it does not work in the Simulator)
