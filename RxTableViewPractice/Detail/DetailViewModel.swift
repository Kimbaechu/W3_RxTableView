//
//  DetailViewModel.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow

class DetailViewModel: ViewModelType, Stepper {
   
    typealias ViewModel = DetailViewModel
    
    var steps = PublishRelay<Step>()
    
    var detail: Country?
    
    init(model: Country) {
        detail = model
    }
    
    struct Input {
        
    }
    
    struct Output {
        let detail: Observable<Country>
    }
    
    func transform(req: DetailViewModel.Input) -> DetailViewModel.Output {
        
        return Output(detail: Observable.just(detail).compactMap { $0 })
    }
    
}
