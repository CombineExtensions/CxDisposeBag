import XCTest
import DisposeBag
import Combine

final class DisposeBagTests: XCTestCase {
  var disposeBag: DisposeBag!
  
  let subject = PassthroughSubject<Void, Never>()
  
  override func setUp() {
    disposeBag = DisposeBag()
  }
  
  override func tearDown() {
    disposeBag = nil
  }
  
  func testCancellable_isRetainedByDisposebag() {
    var cancellable = subject.sink { $0 }
    cancellable.disposed(by: disposeBag)
    
    // cancellable and disposeBag both reference the underlying AnyCancellable object returned by `sink`
    XCTAssertFalse(isKnownUniquelyReferenced(&cancellable))
  }
  
  func testCancellable_isReleasedWhenDisposeBagDeinits() {
    var cancellable = subject.sink { $0 }
    cancellable.disposed(by: disposeBag)
    
    disposeBag = nil
    
    // After disposeBag deinits, cancellable is sole reference to the underlying AnyCancellable object.
    XCTAssert(isKnownUniquelyReferenced(&cancellable))
  }
}
