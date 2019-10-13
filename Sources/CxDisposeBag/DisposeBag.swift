import Combine
import Foundation

/// A thread-safe container to cancel `Cancellable` objects when it is deinitialized.
public final class DisposeBag {
  private var cancellables: [Cancellable] = []
  private let semaphore = DispatchSemaphore(value: 1)
  
  public init() { }
  
  /// Inserts a `Cancellable` into the `DisposeBag` object
  /// - Parameter cancellable: The cancellable to retain
  func insert(cancellable: Cancellable) {
    semaphore.wait()
    
    defer { semaphore.signal() }
    
    cancellables.append(cancellable)
  }
  
  deinit {
    cancellables.forEach { $0.cancel() }
  }
}

public extension Cancellable {
  /// Retains an object conforming to `Cancellable`  for the lifetime of the `DisposeBag` object
  /// - Parameter disposeBag: The `DisposeBag` to retain the `Cancellable` object
  func disposed(by disposeBag: DisposeBag) {
    disposeBag.insert(cancellable: self)
  }
}

