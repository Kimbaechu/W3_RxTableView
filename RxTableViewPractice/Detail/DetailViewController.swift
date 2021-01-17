//
//  DetailViewController.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class DetailViewController: UIViewController, ViewModelProtocol {
    typealias ViewModel = DetailViewModel
    
    var viewModel: ViewModel!
    let disposeBag = DisposeBag()
    
    
    let stackView = UIStackView(frame: .zero).then {
        $0.axis = .vertical
    }
    let nameLabel = UILabel().then {
        $0.text = "nameLabel"
    }
    let codeLabel = UILabel().then {
        $0.text = "codeLabel"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        bindingViewModel()
    }

    func createUI() {
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(codeLabel)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        view.backgroundColor = .systemBackground
    }
    
    func bindingViewModel() {
        nameLabel.text = viewModel.detail?.name
        codeLabel.text = viewModel.detail?.code
    }
    
}
