//
//  String+trimTrailing.swift
//  nmbr
//
//  Created by Sam Dean on 29/12/2020.
//

import Foundation

extension String {

    func trimTrailing(zeroDigit: String = "0", decimalSeparator: String? = Locale.current.decimalSeparator) -> Substring {
        let decimalSeparator = decimalSeparator ?? "."

        if !self.contains(decimalSeparator) { return Substring(self) }

        // Start from the rhs of the string, until we run out of '0' characters
        var end = self.index(before: self.endIndex)
        let start = self.startIndex
        while self[end...end] == zeroDigit && end > start {
            end = self.index(before: end)
        }

        // If we have a trailing decimal, trim that as well
        if self[end...end] == decimalSeparator {
            end = self.index(before: end)
        }

        return self[start...end]
    }
}
