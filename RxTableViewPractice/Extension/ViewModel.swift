//
//  ViewModel.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import UIKit

protocol ViewModel {
    
}

protocol ViewModelType: ViewModel {
    associatedtype ViewModel: ViewModelType
    associatedtype Input
    associatedtype Output

    func transform(req: ViewModel.Input) -> ViewModel.Output
}

protocol ViewModelProtocol: AnyObject {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}



extension ViewModelProtocol where Self: UIViewController {
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        let viewController = Self()
        viewController.viewModel = viewModel
        return viewController
    }
}

