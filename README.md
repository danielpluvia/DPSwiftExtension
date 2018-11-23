# DPSwiftExtension

[![CI Status](https://img.shields.io/travis/danielpluvia/DPSwiftExtension.svg?style=flat)](https://travis-ci.org/danielpluvia/DPSwiftExtension)
[![Version](https://img.shields.io/cocoapods/v/DPSwiftExtension.svg?style=flat)](https://cocoapods.org/pods/DPSwiftExtension)
[![License](https://img.shields.io/cocoapods/l/DPSwiftExtension.svg?style=flat)](https://cocoapods.org/pods/DPSwiftExtension)
[![Platform](https://img.shields.io/cocoapods/p/DPSwiftExtension.svg?style=flat)](https://cocoapods.org/pods/DPSwiftExtension)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

### DPPagingScrollViewController

```swift
import DPSwiftExtension

class PagingViewController: DPPagingScrollViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        }

    fileprivate func setupPages() {
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        view1.backgroundColor = .red
        view2.backgroundColor = .yellow
        view3.backgroundColor = .green
        set(pages: [view1, view2, view3])
    }
}
```

## Requirements

## Installation

DPSwiftExtension is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DPSwiftExtension'
```

## Author

danielpluvia, danielpluvia@outlook.com

## License

DPSwiftExtension is available under the MIT license. See the LICENSE file for more info.
