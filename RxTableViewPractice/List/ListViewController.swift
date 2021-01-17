//
//  ListViewController.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

class ListViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = ListViewModel
    
    var viewModel: ViewModel!
    let disposeBag = DisposeBag()
    
    let tableView = UITableView().then {
        $0.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "country name"
        searchBar.sizeToFit()
        searchBar.returnKeyType = .search
        
        return searchBar
    }()
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        bindingViewModel()
    }
    
    func updateUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.tableHeaderView = searchBar
        
    }
    
    func bindingViewModel() {
        searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        viewModel.list
            .drive(tableView.rx.items(cellIdentifier: ListTableViewCell.identifier)) { (_, country, cell) in
                cell.textLabel?.text = country.name
                cell.detailTextLabel?.text = country.code
            }.disposed(by: disposeBag)
        
        viewModel.list
            .asDriver()
            .map { "\($0.count) Countries"}
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
//        tableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                self?.viewModel.list.asObservable()
//                    .map {$0[indexPath.row]}
//
//                self?.viewModel.steps.accept(AppStep.detail(data: self?.country ?? Country(name: "error", code: "error")))
//            }).disposed(by: disposeBag)
//
        tableView.rx.modelSelected(Country.self)
            .subscribe(onNext: { [unowned self] item in
                viewModel.steps.accept(AppStep.detail(data: item))
            }).disposed(by: disposeBag)
        
            
    }

}
