//
//  Stepper.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import RxFlow
import RxCocoa

class AppStepper: Stepper {
    static let shared = AppStepper()
    let steps = PublishRelay<Step>()
    var initialStep: Step {
        AppStep.list
    }
}

