# NYCSchoolsChallenge

An iOS app for searching, sorting, and viewing details about NYC high schools. Implemented for a take-home assignment.

<img width="360" alt="NYCSchoolsChallenge" src="https://user-images.githubusercontent.com/945761/228920877-2cfe07b5-6ead-47ec-b0f7-e505e3b8f2f2.png"/>

## Technologies
- 🧵 async/await
- 🔁 REST APIs
- 🏛️ MVVM
- ✅ XCTest
- 📊 Swift Charts
- 📐 SwiftUI
- 🏎️ Swift

## Highlights
- I used the `.searchable` view modifier to enable a simple substring search of the school names
- To illustrate school test results, I used **Swift Charts** to create a custom horizontal bar chart with `.annotation` modifiers and custom `AxisMarks`
- I used formatters such as `.number.notation(.compactName)` to more elegantly display school statistics
- `jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase`
- **MVVM** was my choice of architecture to separate models, views, and business logic
