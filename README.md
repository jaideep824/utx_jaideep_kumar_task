# JaideepKumarTaskCrypto

This project implements a sample iOS app with various features including data fetching with Combine, Core Data, dynamic filtering, dark mode support, pull-to-refresh functionality, and a bottom sheet for showing filters, MVVM Architecture.

## Features

### 1. **Add Dark Mode Switch (`setAppMode` in AppDelegate)**

The app supports **dark mode**. The theme can be toggled based on the user's preferences or manually through a switch in the settings. The `setAppMode` function in the `AppDelegate` handles switching between dark and light mode.

```swift
func setAppMode() {
    if #available(iOS 13.0, *) {
    window?.overrideUserInterfaceStyle = .dark
    }
}
