<p align="center" >
  ![Delivery App](https://user-images.githubusercontent.com/18611539/138923029-1967467b-b663-4756-aa90-93ce4c2f8ba8.png)
</p>

# Delivery App
> Application for ordering Pizza and Sushi.

![Language](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)

## Version

1.0

## Requirements

- iOS 13.0+
- Xcode 11+

## Getting Started

1. First download the project by cloning this repository on Xcode or by downloading the Zip file.
2. Open shell window and navigate to the project.
3. Run `pod install`.
4. Open the corresponding `.xcworkspace` file.
5. Select any iPhone Simulator to run the app on.

## Pods used

```ruby
pod 'SDWebImage'
```

## Summary

The main page of this app contains a list of offer images that can be manually scrolled and automatically every 3 seconds in a collection view.
The Menu which is a bottom sheet showing on top of the main view contains a segmented control to choose the menu category. This menu model consists of a 3 different categories and a list of items for each category. This page is a collection view having a table view inside each cell. This will allow it to have several gestures like scrolling up/down or left/right. The item in each category is a reusable view created with an image view, label and a button to select the item. Upon scrolling up a floating cart button is shown to view our selected items in the cart list controller with the total price and the ability to remove any item in the list.

## Application Architecture

The Delivery App follows the Clean Swift architecture using Xcode Templates I create to ease the creation of each scene. The ViewController, Interactor and Presenter are the three main components of Clean Swift.
### Clean Swift Life Cylce: 
- The view controller accepts a user event, constructs a request object, and send it to the interactor.
- The interactor does some work with the request, constructs a view model and send it to the presenter.
- The presenter formats the data in the response and constructs a view model object and send it to the view controller.
- the view controller displays the results contained in the view model to the use.

## Features

- [x] Clean Swift Architecture
- [x] Custom Designs
- [x] Reusable Views
- [x] Extensions
- [x] Mock JSON Response
- [x] Dark Mode Support
