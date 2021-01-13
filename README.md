# QA Engineer - Tech Test - Mobile Automation

## Introduction

Provided in this directory are two sample applications: one for Android and the other for iOS, alongside their corresponding source code you can build if you should need it. 
Note the Android app requires Android Studio 4.1 or greater to build. The iOS App requires Xcode 11.x.

Pick an app for the operating system for which you're doing your test. Your task is to test the search functionality:
1. Design test scenarios to exercise search flow (don't forget negative tests!)
2. Automate test scenarios using a test framework of your choice
3. Report any bugs you've found

It's up to you how you do this, but we'll want to re-run your UI automation tests to verify the results, and for that we expect you to have chosen a suitable framework.


## Running the sample app - Android

1. Create an Android virtual device (AVD). Refer to [Android Studio Create and manage virtual devices](https://developer.android.com/studio/run/managing-avds) page if you need any help with this step.
2. Start the AVD. If you're using Android Studio, you can do this in AVD Manager. If not, you can [start the emulator from the command line](https://developer.android.com/studio/run/emulator-commandline).
2. Install the sample app
```
# find your running device
% adb devices
List of devices attached
emulator-5554	device

# install the sample app
% adb -s emulator-5554 install -r android/apk/app-release.apk
Performing Streamed Install
Success
```
You can now start the app. 

Note: if you get the following error (this can happen e.g. if you've installed the app from the apk directory and you're replacing it with the one you've built):
```
% adb -s emulator-5554 install -r android/apk/app-release.apk
Performing Streamed Install
adb: failed to install android/apk/app-release.apk: Failure [INSTALL_FAILED_UPDATE_INCOMPATIBLE: Package com.sensynehealth.hospitals signatures do not match previously installed version; ignoring!]
```
Uninstall the app and try installing it again:
```
% adb -s emulator-5554 uninstall com.sensynehealth.hospitals
Success
```

## Building the sample app - Android

Open Android Studio, select "Open an Existing project" and import `android/source/Hospitals-master`.

## Running the sample app - iOS

1. Create a simulator
```
% xcrun simctl create "test" "iPhone 11 Pro Max"
No runtime specified, using 'iOS 13.5 (13.5 - 17F61) - com.apple.CoreSimulator.SimRuntime.iOS-13-5'
77BC1E16-00CC-4D4C-858B-501D3045962A
```
2. Boot the simulator created in step 1 (depending on your workstation performance, this could take a few minutes)
```
# replace 77BC1E16-00CC-4D4C-858B-501D3045962A with device uuid returned in step 1
% xcrun simctl boot 77BC1E16-00CC-4D4C-858B-501D3045962A
```
3. Open the simulator UI:
```
% open -a Simulator --args -CurrentDeviceUDID 77BC1E16-00CC-4D4C-858B-501D3045962A
```
4. Install the app:
```
% xcrun simctl install 77BC1E16-00CC-4D4C-858B-501D3045962A ios/app/tech-test.app
```
5. Run the app:
```
% xcrun simctl launch 77BC1E16-00CC-4D4C-858B-501D3045962A com.ro8i.techtest.tech-test
com.ro8i.techtest.tech-test: 68059
```

## Building the sample app - iOS

Refer to [iOS README.md](./ios/source/README.md) for detailed instructions.

## Requirements

You may use any test framework that you like and are not constrained to the tools bundled with Android or iOS SDKs.

You must:

* Submit your completed solution either as link to a git repository (using a public repo service such as Github or Bitbucket), or as a zip file (making sure you include the .git directory). Commit early and often rather than in a single large commit; trial and error is acceptable and even encouraged as it really helps us capture your thinking.

* Your solution should contain instructions sufficient to allow a technical user to run and replicate your results (ideally like a README.md). Do not make any assumptions about the user's specific language or tool knowledge; for instance, do not assume that they know Java if you use a Java-based toolset.

* Produce a report highlighting any bugs in the application which you have found.

## Notes and suggestions:

* Solutions will be judged favourably if they demonstrate an ability to embed your tests in a framework suitable for a modern CICD pipeline. For instance, providing a Dockerfile with a suitable return code that could be executed in a pipeline is a benefit.

* We estimate this task should take no more than 2 hours once you have a suitable environment running. If it is taking you significantly longer than this, tidy up what you have and then submit it. This is not supposed to be a task to test your endurance and your work and thoughts will provide a valuable discussion point in any interview.
