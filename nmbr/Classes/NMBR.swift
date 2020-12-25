
public enum NumberFormat {
    case short
    case long
}

public final class NMBRFormatter {

    public var precision: Int = 2

    public var outputFormat: NumberFormat = .short

    public var locale: Locale = Locale.autoupdatingCurrent

    public init() {
    }

    public func format(_ value: Double) -> String {
        // Anything under the first group is easy - it's just the number itself without any rounding.
        if value < pow(10, Double(self.locale.digitGroupingAtIndex(0))) {
            return "\(Int(value))"
        }

        // Work our way down the groups
        let value2 = value / pow(10, Double(self.locale.digitGroupingAtIndex(0)))

        return ""
    }
}
