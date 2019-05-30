# Labs 12 - first-date-iOS

## Project Overview
This is a Lambda Labs Capstone Project designed as a dating app that provides a safe space for people with unique circumstances to find new friends or someone special. We remove the need for that uncomfortable conversation, allowing our users to focus on what really matters.

#### Our project on IOS can be found at  [**IOS UnBlush**](https://github.com/labs12-first-date/labs12-first-date-iOS)
#### You can find the project at [**UnBlush**](https://awk-dating.firebaseapp.com)

## Contributors
### iOS Development
|  ![Jocelyn](https://img.shields.io/badge/Jocelyn-Stuart-blueviolet.svg)                                                      |                                                  ![Frulwinn](https://img.shields.io/badge/Frulwinn-Collick-ff69b4.svg)                                                       |                                                      
| :-----------------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------: | 
| <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRIUUZb9WpQPm7eAwp1MA_TwA5_c9qgsnMbTneJbVf4BNrq0OK" width = "200" /> | <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAQ2hTxRAECl0pPCzSz3kBBOV3SBWFrvswkJ0ZN72FmeMO0VTJ" width = "200" /> | 
|  [<img src="https://github.com/favicon.ico" width="35"> ](https://github.com/jocate)                                |                                                  [<img src="https://github.com/favicon.ico" width="35"> ](https://github.com/Frulwinn)  
<br>

### Web Development
|                                                      ![Gill](https://img.shields.io/badge/Gill-Abada-orange.svg)                                                      |                                                       ![James](https://img.shields.io/badge/James-Basile-brightgreen.svg)                                                       |                                                      ![Joel](https://img.shields.io/badge/Joel-Bartlett-red.svg)                                                       |                                                       ![Jonas](https://img.shields.io/badge/Jonas-Walden-yellow.svg)                                                       |                                                      ![Steve](https://img.shields.io/badge/Steve-Alverson-blue.svg)                                                      |
| :-----------------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------: |
| <img src="https://www.dalesjewelers.com/wp-content/uploads/2018/10/placeholder-silhouette-male.png" width = "200" /> | <img src="https://www.dalesjewelers.com/wp-content/uploads/2018/10/placeholder-silhouette-male.png" width = "200" /> | <img src="https://www.dalesjewelers.com/wp-content/uploads/2018/10/placeholder-silhouette-male.png" width = "200" /> | <img src="https://www.dalesjewelers.com/wp-content/uploads/2018/10/placeholder-silhouette-male.png" width = "200" /> | <img src="https://www.dalesjewelers.com/wp-content/uploads/2018/10/placeholder-silhouette-male.png" width = "200" /> |
|                                [<img src="https://github.com/favicon.ico" width="35"> ](https://github.com/gabada)                                |                            [<img src="https://github.com/favicon.ico" width="35"> ](https://github.com/jbasile6)                             |                          [<img src="https://github.com/favicon.ico" width="35"> ](https://github.com/murbar)                           |                          [<img src="https://github.com/favicon.ico" width="35"> ](https://github.com/UnknownMonk)                           |                           [<img src="https://github.com/favicon.ico" width="35"> ](https://github.com/VaderSteve76)  
<br>

### Project Managers
Austin Cole 
Michael Ney 

[Deployed App](add link to deployed app here)

## Tech Stack
### iOS
Xcode version 10.2.1
[![Swift Version][swift-image]][swift-url]

Cocoa Pods Used
Boring SSL-GRPC
Firebase, Firebase Analytics, Firebase AnalyticsInterop, Firebase Auth, Firebase Auth Interop, Firebase Core, Firebase Database, Firebase Firestore, Firebase Instance ID, Firebase Messaging, Firebase Storage
Google-Mobile-Ads-SDK, Google App Measurement, Google Utilities
gRPC-C++, gRPC-Core
GTM Session Fetcher
leveldb-library
MessageInputBar
MessageKit
nanopb
Protobuf

### Front end
React w/ React Hooks
Firebase/Cloud Firestore, Firebase Functions
Node.js
Stripe 
ZipCodeAPI.com

### Back end
Firestore/Cloud Firestore noSQL database Firebase Functions
Node.js

## Firebase
This app uses Firebase to allow users to login using Google, Facebook, Twitter, Github, email, and phone. This is a feature that many users demand as they might not wish to have a separate login for every website. We use Firebase in conjunction with JSON web tokens (JWT) to authenticate users and ensure that all information in the app is handled securely. Information about the Firebase API can be found [in their documentation](https://firebase.google.com/docs/reference/).

## Installation Instructions
To install this app you will need Xcode version 10.2.1 and you will need to install all the pods mentioned in the tech stack.

## Features
* Sign up via email
* Upload image to Profile
* Add bio information
* Check off which STD(s) the user has
* Check off which STD(s) the user is open to a partner having
* Match recommendations based off user's disclosed/"open to" STD(s), age, gender, and distance
* Liked or Disliked on other users' profiles resulting in a match if a yes is reciprocated
* In-App chat once users mutually like each other

## Contributing
When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.

Please note we have a code of conduct. Please follow it in all your interactions with the project.

### Issue/Bug Request
* If you are having an issue with the existing project code, please submit a bug report under the following guidelines:
* Check first to see if your issue has already been reported.
* Check to see if the issue has recently been fixed by attempting to reproduce the issue using the latest master branch in the repository.
* Create a live example of the problem.
* Submit a detailed bug report including your environment & browser, steps to reproduce the issue, actual and expected outcomes,  where you believe the issue is originating from, and any potential solutions you have considered.

### Feature Request
We would love to hear from you about new features which would improve this app and further the aims of our project. Please provide as much detail and information as possible to show us why you think your new feature should be implemented.

### Pull Request
If you have developed a patch, bug fix, or new feature that would improve this app, please submit a pull request. It is best to communicate your ideas with the developers first before investing a great deal of time into a pull request to ensure that it will mesh smoothly with the project.
Remember that this project is licensed under the MIT license, and by submitting a pull request, you agree that your work will be, too.

### Pull Request Guidelines
* Ensure any install or build dependencies are removed before the end of the layer when doing a build.
* Update the README.md with details of changes to the interface, including new plist variables, exposed ports, useful file locations and container parameters.
* Ensure that your code conforms to our existing code conventions and test coverage.
* Include the relevant issue number, if applicable.
* You may merge the Pull Request in once you have the sign-off of two other developers, or if you do not have permission to do that, you may request the second reviewer to merge it for you.

### Attribution
These contribution guidelines have been adapted from this good-Contributing.md-template.

## Documentation
See https://github.com/labs12-first-date
