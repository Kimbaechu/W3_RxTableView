//
//  Step.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import Foundation
import RxFlow

enum AppStep: Step {
    case list
    case detail(data: Country)
}
