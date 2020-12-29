//
//  String+trimTrailing.swift
//  nmbr
//
//  Created by Sam Dean on 29/12/2020.
//

import Foundation

extension String {

    func trimTrailing(zeroDigit: String = "0", decimalSeparator: String) -> Substring {
        if !self.contains(decimalSeparator) { return Substring(self) }

        // Go from the rhs of the string, counting the '0'
        var end = self.index(before: self.endIndex)
        let start = self.startIndex
        while (self[end...end] == zeroDigit || self[end...end] == decimalSeparator) && end > start {
            end = self.index(before: end)
        }

        return self[start...end]
    }
}
