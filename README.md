# SIXT_RideShare_CodingTask


## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Libraries](#libraries)
* [Setup](#setup)
* [Project Explanation](#project-explanation)


## General info
This project is the CodingTask of SIXT company for the iOS Developer position.
    

## Technologies
Project is created with:
* Xcode version: 12.5
* Swift version: 5.4
* Design Patterns used: Singleton pattern & MVVM
* SOLID & CleanCode

## Libraries

`Alamofire`  -  an elegant interface for HTTP network requests in Swift
`KingFisher` -  a powerful, pure-Swift library for downloading and caching images from the web
`NVActivityIndicatorView` -  a collection of loading animations
    
    
## Setup
To run this project, close it locally and then run.


## Project Explanation
Project consist of a
 - `View` which controls the view(UI).
 - `RideModel` which is the model for data receving from server and in app.
 - `NetworkManager` which is a manager for network requests
 - `CustomAnnotation` which is the custom annotation used in app
 - `Main.storyBoard` which is the design.

#### `View`
   the main `View` has 2 parts => `MapView` to show cars in map and `TableView` to show list of cars.
   

 In `RideView` we declare two array of type `CustomAnnotation`, one to make annotations and one for the map to handle them.
 when view appear, we first call the `API` to get the data we need from server, and then extract the data into `CustomAnnotation` arrays.
 
 As for map configutarations, we center the map to the first item of the data received, and register for the annotation.
 
 
    
#### `RideModel` & `RideAPI` & `ViewModel`
 Ride model is a `Codable` model for the rides we receive from server, and we keep this data for the `MapKit` and `TableView` to show them.
 
 `RideAPI` is a network handler that manage network calls, and if received any data, try to decode it with the `RideModel` specified earlier.

`ViewModel` is the viewModel which get the raw data from network requests and make `CustomAnnotaiton` from those data, then pass it to `View`


#### `NetworkManager`
Which is a manager for networks calls, and also handles the errors, and intercept the token(if needed, not used in this project)
So any configuration to the network calls can be managed here, (`EventMonitor`, `Request retries`, etc )

#### `CustomAnnotation`
This is a custom annotation we build for the data we want to show on map, and also the callout.


### TDD

To determine if the API can decode the data correctly, first created a `json` file containing some example of the `data` receive by server.

Then use those data to test `RideAPI`. In addition to that, we that model that `RideAPI` returns, we test `configAnnotations` of the `extractAnnotationsView` 

