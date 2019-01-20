# CurriculumVitae
The app is an own CV app. The CV data store as a Gists file and show the details like profile picture, professional summary, employment history etc. 

### Api Links
- https://api.github.com/gists/feb733f8c6d6c38b9db4208fb7791567 - For getting the first response for the gistfile
- https://gist.githubusercontent.com/sc010575/feb733f8c6d6c38b9db4208fb7791567/raw/64b0d8d7c9f7bcc151a325d9bc6691b67323b82e/CurriculumVitae - for the JSON response of the file

### Development Platform
- iOS 12 and XCode 10.1
- Swift 4.2

### Swift libraries (Only used for testing perpose)
- Quick.Nimble for BDD testing
- GCDWebServer for mock server

### Targets
- CurriculumVitae - Main application target
- CurriculumVitaeTests - Unit testing target
- CurriculumVitaeUITests - UI testing target

### Instruction to run
- Download the project from URL or .Zip
- open CurriculumVitae.xcworkspace and run in the simulator
[For simpicity I also include the pod projects so that you should not run the pod install]

### Swift architecture
- The application is build with MVVM (Model-View-ViewModel) architecture and use coordinator patern for navigation.


