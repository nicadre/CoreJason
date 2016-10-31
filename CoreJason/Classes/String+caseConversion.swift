//
//  String+caseConversion.swift
//  Pods
//
//  Created by Nicolas Chevalier on 31/10/16.
//
//

import Foundation

extension String {

    func toCamelCase() -> String {

        var camel: String = ""

        let items: [String] = self.components(separatedBy: "_")

        items.enumerated().forEach { (offset, element) in

            if offset == 0 {
                camel += element
            } else {
                camel += element.capitalized
            }

        }

        return camel

    }

    func toSnakeCase() -> String {

        let option: EnumerationOptions = EnumerationOptions.byComposedCharacterSequences
        let range: Range<String.Index> = self.startIndex ..< self.endIndex

        var snake: String = ""

        self.enumerateSubstrings(in: range, options: option) { substring, _, _, _ in

            if let substring = substring {
                if substring.lowercased() != substring {
                    snake += "_" + substring.lowercased()
                } else {
                    snake += substring
                }
            }

        }

        return snake

    }

}
