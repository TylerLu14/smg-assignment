Certainly! Here's a sample README.md file tailored for an iOS application project:

---

# Project Name

## Description
SMG Interview Assignment

## Features
- List key features or functionalities of your app.
- Highlight any unique aspects or innovative solutions implemented.

## Screenshots
(Optional) Include screenshots of your application in action. You can either embed images directly in the README or provide a link to a separate folder.

## Technologies Used
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
* If you're running to a problem with the build phase, consider removing the `Generate Mockingbird Mocks` build phase
5. Press `Cmd + U` or click on the "Run Test" button in Xcode to build and run the project unit tests on the iOS Simulator or a connected device.

## Usage
Provide any instructions or guidance on how to use your application. For example:
- Explain the main functionalities and how to access/use them.
- Provide any necessary setup or configuration instructions.

## Credits
Mention any contributors, resources, or tutorials you found helpful.

## License
MIT

---