/*:
 > # IMPORTANT: To use **Rx.playground**:
 1. Open **Rx.xcworkspace**.
 1. Build the **RxPlaygrounds** scheme for **Mac** (**Product** → **Build**).
 1. Open **Rx** playground in the **Project navigator** (under RxExample project).
 1. Show the Debug Area (**View** → **Debug Area** → **Show Debug Area**).
 */
import RxPlaygrounds
/*:
 # Try Yourself
 
 It's time to play with Rx 🎉
 */
playgroundShouldContinueIndefinitely()

example("Try yourself") {
  // let disposeBag = DisposeBag()
  _ = Observable.just("Hello, RxSwift!")
    .debug("Observable")
    .subscribe()
    // .disposed(by: disposeBag) // If dispose bag is used instead, sequence will terminate on scope exit
}
