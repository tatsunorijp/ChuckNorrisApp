//
//  SearchFactsViewController.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 09/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewController.swift
import RxCocoa
import RxSwift
import UIKit

protocol SearchFactsDelegate {
    func searchFacts(term: String)
}

final class SearchFactsViewController: BaseViewController {
    
    private let viewModel: SearchFactsViewModelType
    private let router: SearchFactsRouting
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var searchLabel: UILabel!
    @IBOutlet private weak var searchButton: PrimaryButton!
    @IBOutlet private weak var bottomButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textField: LineTextField!
    
    private var delegate: SearchFactsDelegate?
    
    private enum Consts {
        static let bottomButtonConstraintValue = CGFloat(32)
    }
    
    init(withViewModel viewModel: SearchFactsViewModelType, router: SearchFactsRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
    override func prepare() {
        super.prepare()
        observeKeyboardNotifications()
        dismissKeyboardWhenTappedAround()
        title = L10n.SearchFacts.title
        searchLabel.text = L10n.SearchFacts.Label.search
        searchButton.setTitle(L10n.SearchFacts.Button.search, for: .normal)
        scrollView.showsVerticalScrollIndicator = false
        textField.placeholder = L10n.SearchFacts.Textfield.placeholder
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        searchButton.rx.tap
            .bind { _ in
                guard let delegate = self.delegate else { return }
                delegate.searchFacts(term: self.textField.text ?? "")
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func keyboardWillAppear(with size: CGSize, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.bottomButtonConstraint.constant = size.height + Consts.bottomButtonConstraintValue
        }
    }
    
    override func keyboardWillDisappear(with size: CGSize, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.bottomButtonConstraint.constant = Consts.bottomButtonConstraintValue
        }
    }
    
    func setDelegate(_ delegate: SearchFactsDelegate) {
        self.delegate = delegate
    }
}
