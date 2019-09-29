# DisposeBag

## A µFramework to retain `Cancellable` objects.

Working with Combine is great, but I'm not a big fan of having to assign a `Cancellable` to a variable just to keep it around. 

With a `DisposeBag` we can omit assigning an object conforming to`Cancellable` to a variable and worry less about the semantic meaning of the variable and let the declaritive nature of Combine speak for itself:

```swift
let passthrough = PassthroughSubject<Void, Never>)()
let disposeBag = DisposeBag()

// The `DisposeBag` retains the Cancellable until it is deinitialized

passthrough.sink { _ in print("Received Event") }
  .disposed(by: disposeBag)
```

The reason we need to retain is so that we can still receive events.
```swift
let passthrough = PassthroughSubject<Void, Never>()

// Immediately deinitializes and we will never receive events
_ = passthrough.sink { _ in 
    print("Received Event") 
}
```

Without `DisposeBag`:

```swift
let passthrough = PassthroughSubject<Void, Never>()

let cancellable = passthrough.sink { _ in 
  print("Received Event") 
}
```

This isn't so cumbsersome with one value, but when you have several events you want to receive, coming up with meaningful variable names is not such an easy task. 

____

### A less contrived example:

```swift
var someDecodableValue: DecodableValue?
let disposeBag = DisposeBag()

/*
  What would be a good variable name for this subscription? 
  decodableValueAssigner? decodableValueCancellable? Even those names
  don't really fully describe what is going on.
*/
URLSession.shared
  .dataTaskPublisher(for: someUrl)
  .flatMap { data, _ in
    Just(data)
      .decode(type: DecodableValue.self, decoder: JSONDecoder())
      .catch { _ in
        DecodeableValue.default
      }
  }
  .assign(to: \Example.someDecodableValue, on: self)
  .disposed(by: disposeBag)
```
___

This µFramework was heavily inspired by RxSwift's [DisposeBag]("https://github.com/ReactiveX/RxSwift/blob/master/RxSwift/Disposables/DisposeBag.swift")