import RxSwift

class ShowCasePrinter {
    static func run() {
        _ = generateObservable()
            .subscribe(onNext: { (value) in
                debugPrint("RxSwift: Printer onNext: \(value)")
                
            }, onError: { (error) in
                debugPrint("RxSwift: Printer onError: \(error)")
                
            }, onCompleted: {
                debugPrint("RxSwift: Printer onCompleted")
                
            }, onDisposed: {
                debugPrint("RxSwift: Printer onDisposed")
            })
    }
    
    private static func generateObservable() -> Observable<Int> {
        return Observable.create { (observer) -> Disposable in
            
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            
            observer.onError(RxError.unknown)
            
            observer.onCompleted()
            
            observer.onNext(4)
            
            return Disposables.create()
        }
    }
}
