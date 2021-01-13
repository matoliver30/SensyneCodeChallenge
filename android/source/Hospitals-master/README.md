# QA Engineer - Tech Test - Android

## Running the sample app tests

In order to run the tests as they were implemented natively all you need
to follow to be ready to go are the build instructions on the
[README.md](../../../source/README.md) under the main folder.

Once you can build the app you have everything you need to run it, then
you can run this command on your terminal/shell with one device only
plugged on your computer:

```
$ adb shell am instrument -w -m    -e debug false -e class 'com.sensynehealth.hospitals.SensyneSearchTest' com.sensynehealth.hospitals.test/androidx.test.runner.AndroidJUnitRunner
```

Another option if you prefer to run in directly on Android Studio is:

1. Open the project on Android Studio
2. Navigate to the test folder following this path from the root of the
project *Hospitals-master/app/src/androidTest/java/com.sensynehealth.hospitals/SensyneSearchtest.kt*
3. Press the play icon next to the class name and that should run the
whole suite.

From the tests included one issue was caught:
1. The user is never able to see the last element of the list when the
list is bigger than the size of the RecyclerView, due to that one of the
tests will always fail.

