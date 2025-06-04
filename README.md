# Movie App

## Setup Instructions
1. Clone or download project from this link: https://github.com/jhuynh1208/MovieApp.git
2. Extract download zip file (if any)
3. Open MovieApp.xcodeproj with xcode 14 or later
4. Check if project load SPM properly. If not right click on Package Depndencies and choose reset package cache.
5. Build and run on simulator or device with iOS 15 or above.

## Design & Reasoning
- The app using MVVM pattern to keep the logic seperate form UI rendering.
- Search function using debounce and removeDuplicate operators to reduce unnecessary UI and logic update while user typing.
- Using CoreData for local storage since it optimized for managing large sets of structured data with indexing, faulting, and relationship management.
- Using Alamofire for networking since it have a built-in Codable decoding and automatic validation make it easier to parse API responses.
