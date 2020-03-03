# CxDisposeBag

## A µFramework to retain `Cancellable` objects.

![Build Status](https://github.com/CombineExtensions/DisposeBag/workflows/CI/badge.svg) ![swift-package-manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-red.svg) ![platforms](https://img.shields.io/badge/Platform-iOS%20|%20macOS%20|%20watchOS-informational.svg) ![swift-version](https://img.shields.io/badge/Swift-5.1-orange.svg) ![license](https://img.shields.io/badge/License-MIT-c41d3a.svg)

~~Working with Combine is great, but I'm not a big fan of having to assign a `Cancellable` to a variable just to keep it around.~~

When this was written, I was unaware of AnyCancellable's [`store(in:)` method](https://developer.apple.com/documentation/combine/anycancellable/3333294-store). Which, makes this library pretty pointless! Don't use it!