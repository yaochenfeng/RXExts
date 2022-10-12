#if canImport(RxRelay)
import RxRelay

@propertyWrapper
public struct RxState<Value> {
    public var wrappedValue: Value {
        get {
            _subject.value
        }
        nonmutating set {
            _subject.accept(newValue)
        }
    }
    public var projectedValue: Observable<Value> { return _subject.asObservable() }
    private let _subject: BehaviorRelay<Value>

    public init(wrappedValue: Value) {
        _subject = BehaviorRelay<Value>(value: wrappedValue)
    }
    public init(initialValue: Value){
        _subject = BehaviorRelay(value: initialValue)
    }
}
#endif
