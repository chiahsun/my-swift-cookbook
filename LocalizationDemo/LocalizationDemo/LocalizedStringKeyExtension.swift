import Foundation
import SwiftUI

extension LocalizedStringKey {
    var stringKey: String {
        let description = "\(self)"

        let components = description.components(separatedBy: "key: \"")
            .map { $0.components(separatedBy: "\",") }

        return components[1][0]
    }
}

extension String {
    static func localizedString(for key: String, locale: Locale) -> String? {
        let identifier = locale.identifier
        guard let path = Bundle.main.path(forResource: identifier, ofType: "lproj") else {
            print("Fail to get resource for \(identifier)")
            return nil
        }
        guard let bundle = Bundle(path: path) else {
            print("Fail to get bundle")
            return nil
        }
        // TODO: if project exists, if no such key-value paire. localizedString still exists as key value ...
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        print("localizedString: \(localizedString)")
        return localizedString
    }
}

extension LocalizedStringKey {
    private func stringValueInner(locale: Locale) -> String? {
        return .localizedString(for: self.stringKey, locale: locale)
    }
    
    func stringOptionalValue(locale: Locale) -> String? {
        // https://developer.apple.com/documentation/foundation/locale
        // if let stringValue = self.stringValueInner(locale: Locale.current) {
        // if let stringValue = self.stringValueInner(locale: Locale.autoupdatingCurrent) {
        if let stringValue = self.stringValueInner(locale: locale) {
            return stringValue
        }
        if let stringValue = self.stringValueInner(locale: Locale(identifier: "en")) {
            return stringValue
        }
        
        return stringKey
    }
    
    func stringValue(locale: Locale) -> String {
        if let stringValue = stringOptionalValue(locale: locale) {
            return stringValue
        }
        
        return stringKey
    }
}
