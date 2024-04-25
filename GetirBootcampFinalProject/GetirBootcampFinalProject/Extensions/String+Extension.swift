//
//  String+Extension.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 19.04.2024.
//

import Foundation

extension String {
    mutating func insert(_ string: String, at index: Int) {
        self.insert(contentsOf: string, at: self.index(self.startIndex, offsetBy: index))
    }
}
