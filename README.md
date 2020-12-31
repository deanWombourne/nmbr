# nmbr

[![CI Status](https://img.shields.io/travis/deanWombourne/nmbr.svg?style=flat)](https://travis-ci.org/deanWombourne/nmbr)
[![Version](https://img.shields.io/cocoapods/v/nmbr.svg?style=flat)](https://cocoapods.org/pods/nmbr)
[![License](https://img.shields.io/cocoapods/l/nmbr.svg?style=flat)](https://cocoapods.org/pods/nmbr)
[![Platform](https://img.shields.io/cocoapods/p/nmbr.svg?style=flat)](https://cocoapods.org/pods/nmbr)

This pod is a (hopefully) very small library to short format numbers like this: http://cldr.unicode.org/translation/numbers-currency/number-patterns#TOC-Compact-decimal-formatting-Short-Numbers.

It's main purpose is for formatting pricing information (though it will format any number). 

It should

- deal with localisation (i.e. some locales group by 4 digits, not 3)
- deal with pricing correctly (i.e. put the right currency symbol in the right place)
- deal with long/short versions i.e. 1M vs. 1 million.

Long term, this should just be handled in `Foundation` - there shouldn't really be a need for this pod.

## Example

To run the example project, clone the repo and look in `Example/`.

## Installation

nmbr is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'nmbr'
```

## Usage

Create a NMBRFormatter

```swift
let formatter = NMBRFormatter()
```

Configure the formatter

```swift
// This defaults to 2
formatter.precision = 1

// This is optional - it defaults to the current device locale
formatter.locale = NSLocale(identifier: "en_GB")

// If you want a currency symbol, set the currency code. IF not, leave it as `nil`
formatter.currencyCode = "GBP"
```

Use the formatter

```swift
myLabel.text = formatter.string(123.456) // "£123.46"
```

## Advice

Reuse formatters whenever you can - they aren't going to be free to create (at the moment they are fairly cheap, but we reserve the right to make creating them slower if it will improve the speed when you actually format a number)

Formatting a number isn't going to be free either - I probably wouldn't use a formatter in a tableview / collectionview cell for example - I would cache the text result somewhere (MVVM to the resuce, if that's your thing ;) 

## Author

deanWombourne, deanWombourne@gmail.com

## License

nmbr is available under the MIT license. See the LICENSE file for more info.
