//
//  Bundle+nmbr.swift
//  nmbr
//
//  Created by Sam Dean on 29/12/2020.
//

import Foundation

extension Bundle {

    static let classBundle = Bundle(for: NMBRFormatter.self)

    static let resourceBundle: Bundle = {
        guard let url = Bundle.classBundle.url(forResource: "nmbr", withExtension: "bundle") else {
            fatalError("Failed to find nmbr resource bundle")
        }

        guard let bundle = Bundle(url: url) else {
            fatalError("Failed to load nmbr resource bundle from \(url)")
        }

        return bundle
    }()

    static func resourceBundleForLocale(_ locale: Locale) -> Bundle {
        guard let path = localizedPathForLocale(locale: locale) ??
                localizedPathForLocale(locale: .current) ??
                localizedPathForLocale(locale: Locale(identifier: "en")) else {
            fatalError("Could not find resources for locale \(locale.identifier)")
        }

        guard let bundle = Bundle(path: path) else {
            fatalError("Failed to create bundle for path \(path)")
        }

        return bundle
    }

    private static func localizedPathForLocale(locale: Locale) -> String? {
        Bundle.resourceBundle.path(forResource: locale.identifier, ofType: "lproj")
    }
}
