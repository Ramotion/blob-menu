<a href="https://www.ramotion.com/agency/app-development?utm_source=gthb&utm_medium=repo&utm_campaign=blob-menu"><img src="https://github.com/Ramotion/blob-menu/blob/master/Promo/Header.png"></a>

<a href="https://github.com/Ramotion/animated-tab-bar">
<img align="center" src="https://github.com/Ramotion/blob-menu/blob/master/Promo/Blob-Menu-dark.gif" /></a>

<p><h1 align="left">BLOB MENU</h1></p>

<h4>Swift UI menu library.</h4>
___

<p><h6>We specialize in the designing and coding of custom UI for Mobile Apps and Websites.</h6>
<a href="https://www.ramotion.com/agency/app-development?utm_source=gthb&utm_medium=repo&utm_campaign=blob-menu">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
</p>
<p><h6>Stay tuned for the latest updates:</h6>
<a href="https://goo.gl/rPFpid" >
<img src="https://i.imgur.com/ziSqeSo.png/" width="156" height="28"></a></p>

<br>

[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Ramotion/blob-menu)
[![codebeat badge](https://codebeat.co/badges/6f67da5d-c416-4bac-9fb7-c2dc938feedc)](https://codebeat.co/projects/github-com-ramotion-blob-menu)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-green.svg?style=flat)](https://developer.apple.com/swift/)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://paypal.me/Ramotion)


## Requirements

- iOS 13.0
- Xcode 11.4
- Swift 5.0


## Installation
You can install `blob-menu` in several ways:

- By adding the source files to your project.

<br>

- Via [Swift Package Manager](https://swift.org/package-manager/).

<br>

- Via [CocoaPods](https://cocoapods.org):
``` ruby
pod 'blob-menu'
```

<br>

- Via [Carthage](https://github.com/Carthage/Carthage):
```
github "Ramotion/blob-menu"
```

## Usage

### Blob Menu

1. Create several menu items. You need to provide at least one image icon to initialize `BlobMenuItem`.
2. Use these menu items to create a menu model `BlobMenuModel`.

`public init(items: [BlobMenuItem], selectedIndex: Int = 0, isOpened: Bool = false)`

3. Finally, use the menu model to initialize `BlobMenuView`. You can use this view in your layout.

### Example
```
extension BlobMenuItem {
    static let all = [
        BlobMenuItem(icon: <#Image#>),
        BlobMenuItem(icon: <#Image#>),
        BlobMenuItem(icon: <#Image#>),
        BlobMenuItem(icon: <#Image#>)
    ]
}

struct ContentView: View {

    @ObservedObject private var model = BlobMenuModel(items:  BlobMenuItem.all)

    var body: some View {
        VStack {
            Spacer()
            BlobMenuView(model: model).padding(.bottom, 30)
        }
    }
}
```

### Configuration

To configure additional menu parameters, use a custom `BlobMenuConfiguration` in the `BlobMenuView` init method.

`public init(model: BlobMenuModel, configuration: BlobMenuConfiguration = .default)`

Right now we provide only color parameters. If you have ideas on what else should be configurable, please create an issue with `suggestion` label.
For more integration details, please take a look at the `Example` project.

## �� License

Blob Menu is released under the MIT license.
See [LICENSE](./LICENSE) for details.

This library is a part of a <a href="https://github.com/Ramotion/swift-ui-animation-components-and-libraries"><b>selection of our best UI open-source projects.</b></a>

If you use the open-source library in your project, please make sure to credit and backlink to www.ramotion.com


## �� Get the Showroom App for iOS to give it a try
Try this UI component and more like this in our iOS app. Contact us if interested.

<a href="https://itunes.apple.com/app/apple-store/id1182360240?pt=550053&ct=garland-view&mt=8" >
<img src="https://github.com/ramotion/gliding-collection/raw/master/app_store@2x.png" width="117" height="34"></a>

<a href="https://www.ramotion.com/agency/app-development?utm_source=gthb&utm_medium=repo&utm_campaign=blob-menu">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
<br>
<br>
