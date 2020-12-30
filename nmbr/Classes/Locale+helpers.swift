//
//  Locale+helpers.swift
//  nmbr
//
//  Created by Sam Dean on 24/12/2020.
//

import Foundation

extension Locale {

    private static let indiaIdentifiers = Locale.availableIdentifiers
        .filter { $0.contains("_IN") }
        .map { $0.lowercased() }

    /// Returns the digit grouping length
    ///
    /// i.e. UK it's 3 - 1 million is 1,000,000.
    /// In Japan it's 4 - 1 million is 100,0000.
    ///
    /// Finally, India, which is 3 for the first group, and then 2
    /// i.e. 1 million is 10,00,000.
    ///
    func digitGroupingAtIndex(_ index: Int) -> Int {
        let identifier = self.identifier.lowercased()

        if identifier.hasPrefix("zh_hant") || identifier.hasPrefix("ja") || identifier == "zh" || identifier.hasPrefix("ko") {
            return 4
        }

        if Locale.indiaIdentifiers.contains(identifier) {
            return index == 0 ? 3 : 2
        }

        return 3
    }
}
