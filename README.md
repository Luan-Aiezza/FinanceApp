# Coinc (FinanceApp)

An iOS app that teaches **children to handle money**. Parents create tasks, children complete them to earn coins, and the coins go into piggy banks they can save, spend and transfer. The app is called **Coinc** on the Home Screen, and the repository keeps its original name, FinanceApp.

## Features

- **Parent and child profiles:** a parent manages one or more children, each with a name and a profile image, plus edit and delete for both.
- **Tasks with effort and frequency:** parents create tasks with a coin value, an effort level (easy, medium, hard) and a frequency (daily, weekly, monthly or one-off). Tasks are shown as flippable cards, and finishing one shows a success card.
- **Piggy banks:** each child has wallets and goal banks, with coins that can be transferred between them.
- **Spending and history:** every spend is recorded, and a history tab shows past activity for both parents and children.
- **Onboarding:** a five-page introduction on first launch.
- **Localization:** a String Catalog with English and Brazilian Portuguese strings.
- **Accessibility:** VoiceOver support, for example hiding the back of a task card until it is flipped.
- **Custom font:** the Pally typeface.

## Architecture

The app follows **MVVM** on top of **SwiftData**.

| Folder | Contents |
| --- | --- |
| `src/Models` | SwiftData models (`ChildModel`, `ParentModel`, `TaskModel`, `CashBoxModel`, `GoalBankModel`, `SpendModel`) and enums |
| `src/Models/Migrations` | Versioned schemas (v1 to v6) and a migration plan, so existing data survives model changes |
| `src/ViewModels` | Parent, child profile, piggy bank and history view models |
| `src/ViewModels/Services` | A generic SwiftData `Service<T>` that implements a `PCrud` protocol, and navigation |
| `src/Views` | Profile selection, child screens (tasks, piggy bank, history), parent screens (children, settings) and onboarding |
| `src/Views/Components` | Task cards and profile components |

## Tech stack

![Swift](https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white) ![SwiftUI](https://img.shields.io/badge/SwiftUI-007AFF?style=for-the-badge&logo=swift&logoColor=white) ![SwiftData](https://img.shields.io/badge/SwiftData-5856D6?style=for-the-badge&logo=apple&logoColor=white) ![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white)

## Running the project

Requirements: Xcode and an iPhone or simulator running **iOS 17.6 or later**.

1. Clone the repository:
   ```bash
   git clone https://github.com/Luan-Aiezza/FinanceApp.git
   ```
2. Open `Coinc.xcodeproj` in Xcode.
3. Select the **FinanceApp** scheme and an iPhone, then press **Run** (⌘R).

## Team

Built by [Luan Aiezza](https://github.com/Luan-Aiezza), Joseph Bezerra and Grecia Rivera.
