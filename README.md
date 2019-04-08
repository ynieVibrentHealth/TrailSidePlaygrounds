# TrailSidePlaygrounds
<b>A Project to test out iTunes's search api. This project allows a user to search for</b>

### Getting Started

1. In order to run this project, please make sure you have [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) installed in your environment. After that, run:

```
pod install
```

2. Then, open the workspace file: <b>TrailsidePlayground.xcworkspace</b>


### Future Improvements

#### Functionality
* Assuming we can access Apple's user account, add in the functionality for buy/rent methods
* Add ability for user to favorite movies directly from the list view
* Add in ability for user to remove movies from their favorites
* Add in more Unit Tests, especially on the helper methods
* Add in more UI Tests for integration testing

#### UI Improvements
* Add indicator that a movie has been favorited on the search results cell
* Use specific branding fonts, colors, and styles. Add those into a struct for better reuse

#### Bug fixes
* Fix the conflicting constraint issue that happens during subview loads
