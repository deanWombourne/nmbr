
public enum NumberFormat {
    case short
    case long
}

public final class NMBRFormatter {

    private enum Constants {
        static let initialLocaleValue: Locale = .autoupdatingCurrent
    }

    private struct Scale: CustomStringConvertible {
        let min: Decimal
        let format: String

        var description: String {
            "Scale(min: \(min), format: \"\(format)\")"
        }
    }

    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Constants.initialLocaleValue
        formatter.numberStyle = .decimal
        return formatter
    }()

    public var precision: Int = 2
    public var outputFormat: NumberFormat = .short

    public var locale: Locale = Constants.initialLocaleValue {
        didSet {
            self.formatter.locale = self.locale
        }
    }

    public var currencyCode: String? = nil {
        didSet {
            self.formatter.currencyCode = self.currencyCode
            self.formatter.numberStyle = self.currencyCode != nil ? .currency : .decimal
        }
    }

    public init() {
    }

    public func format(_ value: Double) -> String {
        let decimalValue = Decimal(value)

        let formats = self.formatStrings(style: self.outputFormat, locale: self.locale)

        // Get the format which is closest to our value (but not bigger)
        guard let format = formats.filter({ $0.min <= decimalValue }).last else {
            return self.outputString(value: value, format: "")
        }

        guard format.min != 0 else {
            return self.outputString(value: value, format: format.format)
        }

        let scaledValue = ((decimalValue / format.min) as NSNumber).doubleValue
        return self.outputString(value: scaledValue, format: format.format)
    }

    private func formatStrings(style: NumberFormat, locale: Locale) -> [Scale] {
        // Go through each group in this locale in turn, getting its format string
        let resourceBundle = Bundle.resourceBundleForLocale(locale)

        let styleName: String
        switch style {
        case .long: styleName = "long"
        case .short: styleName = "short"
        }

        var formats: [Scale] = []

        var index = 1
        var group = locale.digitGroupingAtIndex(index)
        while true {
            let key = "\(styleName) scale \(group)"

            let format = NSLocalizedString(key,
                                           tableName: "localisations",
                                           bundle: resourceBundle,
                                           comment: "")
            if format == key {
                break
            }

            let min = pow(10, group)
            formats.append(Scale(min: min, format: format))

            group += locale.digitGroupingAtIndex(index)
            index += 1
        }

        return formats
    }

    private func outputString(value: Double, format: String) -> String {

        let rounded = value.rounded(to: self.precision)

        //let numberPart = String(format: "%.\(self.precision)f", value)
        let numberPart = self.formatter.string(from: NSNumber(value: rounded))!
            .trimTrailing(decimalSeparator: self.locale.decimalSeparator)

        let format = String.localizedStringWithFormat(format, value)

        return numberPart + format
    }
}

extension Double {

    func rounded(to: Int, rule: FloatingPointRoundingRule = .toNearestOrEven) -> Double {
        let mul = (pow(10, to) as NSNumber).doubleValue
        return (self * mul).rounded(rule) / mul
    }
}
