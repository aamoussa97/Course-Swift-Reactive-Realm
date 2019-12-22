import RxSwift

extension ConcurrentDispatchQueueScheduler {

    static var background: ConcurrentDispatchQueueScheduler {
        return ConcurrentDispatchQueueScheduler(qos: .background)
    }
}
