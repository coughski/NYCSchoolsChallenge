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
- I used the `.searchable` view modifier to enable a simple substring search of the school names, and a `Menu` for sorting options
- To illustrate school test results, I used ***Swift Charts*** to create a [custom horizontal bar chart](https://github.com/coughski/NYCSchoolsChallenge/blob/95cec6da8ceb00e79a9e5f91319e09388cab06b7/NYCSchoolsChallenge/Views/ScoreChart.swift#L15) with `.annotation` modifiers and custom `AxisMarks`
- I used formatters such as `.number.notation(.compactName)` to more elegantly display school statistics
- I used `jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase` so that I could keep the names of my model struct properties Swifty, which is less work than assigning a raw `String` value to every `CodingKey` case
- ***MVVM*** was my choice of architecture to separate models, views, and business logic
- Using ***XCTest***, I wrote [unit tests](https://github.com/coughski/NYCSchoolsChallenge/blob/95cec6da8ceb00e79a9e5f91319e09388cab06b7/NYCSchoolsTests/NYCSchoolsTests.swift#L35) targeting the most sensitive part of my code, the JSON decoding, which can easily break with any change to the model structs
- I chose the newer `async/await` methods of `URLSession` over the older closure-based methods in my [networking service](https://github.com/coughski/NYCSchoolsChallenge/blob/95cec6da8ceb00e79a9e5f91319e09388cab06b7/NYCSchoolsChallenge/NetworkingManager.swift#L21)
- I created a generic Statistic view and a custom `LabeledContent` style to easily display school statistics in an aesthetic format
