//
//  Flow.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Then

class AppFlow: Flow {
    
    static let `shared`: AppFlow = AppFlow()
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController = UINavigationController().then {
        $0.setNavigationBarHidden(false, animated: false)
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .list:
            return navigateToList()
        case .detail(let data):
            return navigateToDetail(data)
        }
    }
  
}

extension AppFlow {
    
    private func navigateToList() -> FlowContributors {
        let viewModel = ListViewModel()
        let vc = ListViewController.instantiate(withViewModel: viewModel)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }
    
    private func navigateToDetail(_ data: Country) -> FlowContributors {
        let viewModel = DetailViewModel(model: data)
        let vc = DetailViewController.instantiate(withViewModel: viewModel)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.viewModel))
    }
    

 
    
}
