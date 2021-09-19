# VoiceMemo
Oscer technical test

### versions
- OSX 11.4
- Xcode 13 beta
- Tested on iOS 15

### Prerequisites 
- Xcode
- SPM - swift package manager (comes with xcode)

### Running
Open `VoiceMemo.xcodeproj` and press Build + Run. Dependencies should be synced as part of this step by xcode.

### Task
- Voice is recorded and transcribed in realtime thanks to Apple's Speech SDK
- Entries are persisted into a core data model and can be deleted.
- Pause functionality is missing.

Other requiremenets
- Isses can be tracked via github
- travis.yml file exists but travis hasnt ran this yet...

### Notes
- Only tesed on device. My mac mini does not have a microphone so the app would crash when attempting to record.
- screen recording doesnt record voice or playback. so you will have to run this on your device to get the full effect.

### if time permitted...
- would have has like to do some UI tests, there is not a whole load of custom logic, there is a lot of apple frameworks used that are not easily mocked, would have been easier to e2e.
- some kind of UI feedback when doing playback could have been good too.

### Screenshots and Demo

