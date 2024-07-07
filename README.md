# Project Name

## Description
SMG Interview Assignment

## Features
- Realestate Listings
- Favorite Items

## Demo Video
https://github.com/TylerLu14/smg-assignment/assets/20063699/7e8e7c8f-02a0-41e3-96c8-c46da995d013
https://github.com/TylerLu14/smg-assignment/assets/20063699/bf8fc2c0-aa9a-4be0-b01a-864474a4ed0f



## Technologies Used
- **XCode 15.4**, **Swift 5**
- SwiftUI
- Combine
- Dependency Injections
- XCTests
- Mockingbird

## Installation
1. Clone the repository to your local machine using `git clone git@github.com:TylerLu14/smg-assignment.git` or `https://github.com/TylerLu14/smg-assignment.git`
2. Open `SMGAssignment.xcodeproj` in Xcode.
3. Press `Cmd + R` or click on the "Run" button in Xcode to build and run the project on the iOS Simulator or a connected device.
4. The Project using `Mockingbird` to generate mockup data. Run `DERIVED_DATA="$(xcodebuild -showBuildSettings | sed -n 's|.*BUILD_ROOT = \(.*\)/Build/.*|\1|p')"` to root the `DERIVED_DATA` folder before building Unit Tests.
* If you're running to a problem with the build phase, consider removing the `Generate Mockingbird Mocks` build phase. This script will do nothing unless, you're creating more mocks
<img width="500" alt="Screenshot 2024-07-07 at 5 36 16 PM" src="https://github.com/TylerLu14/smg-assignment/assets/20063699/212762dd-b0d9-426d-aba5-efc36e966463">

5. Press `Cmd + U` or click on the "Run Test" button in Xcode to build and run the project unit tests on the iOS Simulator or a connected device.

## License
MIT

---
