@resultBuilder public struct ArrayBuilder<T> {
    public static func buildOptional(_ component: [T]?) -> [T] {
        return component ?? []
    }

    public static func buildBlock(_ components: [T]...) -> [T] {
        return Array(components.joined())
    }

    public static func buildExpression(_ expression: T) -> [T] {
        return [expression]
    }

    public static func buildArray(_ components: [[T]]) -> [T] {
        return Array(components.joined())
    }

    public static func buildEither(first component: [T]) -> [T] {
        return component
    }

    public static func buildEither(second component: [T]) -> [T] {
        return component
    }

    public static func buildLimitedAvailability(_ component: [T]) -> [T] {
        return component
    }
}

public extension Array {
    init(@ArrayBuilder<Element> builder: () -> [Element]) {
        self.init(builder())
    }
}
