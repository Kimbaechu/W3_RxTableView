//
//  ListViewModel.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxFlow

enum ListInput {
    case cellSelect(Country)
}
class ListViewModel: ViewModelType, Stepper {
    
    typealias ViewModel = ListViewModel
    
    var steps = PublishRelay<Step>()
    
    let disposeBag = DisposeBag()
    
    let searchText = BehaviorRelay(value: "")
    
    lazy var list: Driver<[Country]> = {
        
        return self.searchText.asObservable()
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(ListViewModel.loadJson)
            .asDriver(onErrorJustReturn: [])
    }()
    
    struct Input {
        let action: Observable<ListInput>
    }
    
    struct Output {
        let list: Observable<[Country]>
    }
    
    func transform(req: Input) -> Output {
        req.action.bind(onNext: actionProcess).disposed(by: disposeBag)
        
        return Output(list: list.asObservable())
    }
    
    static func loadJson(searchWord: String) -> Observable<[Country]> {
        var countries = [Country]()
        
        do {
            guard let file = Bundle.main.url(forResource: "Country", withExtension: "json") else {
                fatalError()
            }
            
            let data = try Data(contentsOf: file)
            //            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let json = try JSONDecoder().decode(Countries.self, from: data)
            countries.append(contentsOf: json.countries)
            countries = countries.filter { $0.name.hasPrefix(searchWord)}
            
        } catch {
            print(error.localizedDescription)
        }
        
        return Observable.of(countries)
    }
    
    func actionProcess(action: ListInput) {
        switch action {
        case .cellSelect(let country):
            self.steps.accept(AppStep.detail(data: country))
        }
        
    }
}

