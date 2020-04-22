# Agl Assignment

## Project Specifications
- iOS 13.0+
- Xcode 11.2
- Swift 5
Develop with Xcode 11.2. All code is written in Swift 5. The dependencies are managed with
[CocoaPods](https://cocoapods.org/) version 1.9.1.
- Project Git url: https://github.com/ajinaraju/agl-swift-cats


## Externel Libraries used, SOUP (Software of unknown providence) 
- NVActivitiyView: To show the loading screens. Integrated via cocoapods

## Architecture Used
- MVVM.

##Swift Features used  
- Followed protocol oriented coding approach, protocol extensions, Closures and Property Observables for data binding from View Model to View
- Used Codable protocols for Json Decoding
- Used  Swift 5 features like, Result type for asynchronous API calls which is quite handy. 
- Tried to handle Error handling as much possible.

## Improvements
- Write More tests, currently it covers  only the view models (complete coverage). UI be tested by any good concept XCUITest . Could not cover this because of Time constraints
- Could add more comments inside the classes and  methods.
- Configuring Continous integration with Jenkins / Bamboo. 
