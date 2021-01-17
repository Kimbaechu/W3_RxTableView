//
//  Country.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import Foundation

struct Countries: Codable {
    let countries: [Country]
}

struct Country: Codable {
    let name, code: String
}
