# BabylonDemo

This is a demo iOS app for Babylon Health displaying a list of posts and their author and their comments.
See the project requirements here: https://github.com/Babylonpartners/iOS-Interview-Demo/blob/master/demo.md#1-the-babylon-demo-project

## Installation

Checkout this project on your machine. [Carthage](https://github.com/Carthage/Carthage) is used to manage dependencies (The only dependency being RxSwift version 4.4.1).
The RxAtomic, RxBlocking, RxCocoa, RxSwift and RxTest are already embedded in the project.

## App Architecture

This section coverts the design patterns and general implementation choices for this project.

### MVVM

The app follows the Model-View-ViewModel design pattern. Navigation between view controllers is handled by the `NavigationCoordinator` object that can take an `AppPath` to route the user to the relevant section of the app.

For each view controller we have:
* A **view model**: Injected in the view controller `init` method, it conforms to a protocol defined by the view controller and is responsible for passing on data received from the data service

* A **nib file**

* A **navigation coordinator** conforming to `NavigationCoordinatorProtocol`, injected via the `init` method

### Collection View Adapter

The `CollectionViewAdapter` is an object conforming to `UICollectionViewDataSource` and `UICollectionViewDelegate` accepting a list of `CollectionViewDataSourceItem` to populate a collection view.

`CollectionViewDataSourceItem` is a wrapper structure around the protocol `CellViewRepresentable`. This protocol is used to bind a model to a UICollectionViewCell. This kind of type erasure mechanism allows us to populate the collection view with different types of cell.

The size of each `UICollectionViewCell` is also cached and computed once for collection view bounds changes and model updates.

### NetworkKit

NetworkKit is a simple networking framework relying on `URLSession` and `URLSessionDataTask` to perform API calls to a web service. 
* To use it, simply instanciate a `Service`, injecting it a `URLSession` and a configuration structure. 
* Create a data strucuture that conforms to `RequestProtocol`.
* Call the `perform(request:onCompletion:)` to make the call, the completion closure will return a type conforming to `ResponseProtocol`.
* The concrete class `DecodableResponse` can be used to return a model conforming to `Decodable`, allowing instant JSON parsing.

### Data persistence

Data persistence is handled by NetworkKit and relies on simple HTTP caching. Each request sent to the web service carries a `if-none-match` HTTP header that allows the server to return a simple 304 status code, informing the client that the data hasn't changed since last time. In that situation the response is simply returned from the local cache.
Data is persisted on the disk and is available when the app goes offline.

### Future improvements

* Pagination: It doesn't look like the web service supports pagination at the moment, this can be an issue in terms of performance although at the moment the dataset of posts and users is quite small.

* Diffing for collection view data source: With a pagination mechanism in place, new pages of content can be added to a collection view avoiding reloading everything at once.

* Support for sections in the collection view adapter
