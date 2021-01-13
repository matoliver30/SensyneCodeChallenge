# Sensyne - iOS technical test - Demo app

Requirements iOS 13+ , Xcode 11+

## Installation and running

Prerequisites: CocoaPods (to install run `brew install cocoapods` for example)

1. Clone repo (`develop` branch is default)
2. Run `pod install`
3. Open workspace in Xcode and run `tech-test` target on any device/simulator running iOS13+

## Using the app

When the app starts it lands on the screen (Hospital List). The Hospital List screen contains:
    - Filter bar - the User can search for hospitals by their name using the search bar on the top. As the User types, the list is filtered by the query in the search bar.  When using filter keyboard is presented and it is dismissed on scroll or Search button
    - List of all hospitals from downloaded data or CSV file
    - pull to refresh option

The User can tap on a particular hospital in the list which results in presenting the Hospital Detail Screen. The Detail Screen contains:
    1. all data from CSV file, map with the pin on the hospital address and all data from the CSV data source.
    2. a map with the pin on the hospital address - the user can tap pin and it will be redirected to Apple Maps navigation
    3. if phone number is available when the user tap on label it will be asked to make a call
    4. if email is available when the user tap on label it will be asked to send email
    5. if website is available when the user tap on label it will be redirected to web browser
    6. support for landscape mode

## Implementation

- App architecture: MVVM
- 3rd party library:
    1. CSV Swift (https://github.com/yaslab/CSV.swift) - used for CSV manipulation
    2. SnapKit (https://github.com/SnapKit/SnapKit) - used for auto layout
    3. Realm (https://realm.io/docs/swift/latest#installation) - used for local database
- Unit tests - added exemplary test for Models, Services and View Models
- UI tests - added exemplary test for Hospital List, Hospital Detail, Search bar text filter and Hospital Detail - open website
- Data fetch flow - the app will try to download CSV data from provided URL. If succeeds it will save data to Realm DB for future application launches. If it fails, it will try to use Realm database and parse data. If database is empty or parsing data fails it will use local copy of Hospital.csv file to parse data from there.

## TODO
- More unit and UI tests
- Dark Mode support
- UI enhancements

08 Nov 2020, Robert Majtan

## Running the demo app tests

In order to run the tests as they were implemented natively all you need
to follow to be ready to go are the build instructions above.

Once you can build the app you have everything you need to run it, then
you can run this command on your terminal/shell to run the tests on the
simulator:

```
xcodebuild -workspace tech-test.xcworkspace -scheme "tech-testUITests" -sdk iphonesimulator -destination <your-device-here> test
```

You can also run on a real device by plugging it on your computer and running:

```
$ xcodebuild -workspace tech-test.xcworkspace -scheme "tech-testUITests" -destination <your-device-here> test
```

Where *<your-device-here>* is the name and description of your device,
for example:
1. 'platform=iOS Simulator,name=iPhone Xs Max,OS=14.0'

Another option if you prefer to run in directly on Xcode is:

1. Open the project on Xcode
2. Navigate to the test folder following this path from the root of the
project *tech-test/tech-testUITests/Tests/SearchTest.swift*
3. Press the play icon next to the class name and that should run the
whole suite on the selected device.

From the tests included one issue was caught:
1. The search results between words containing capital letters and the
words with all letters in lowercase were different.
That means the user'll always need to type the exact title of the company
following all the capitals.
For that reason a test in the suite will always fail.

