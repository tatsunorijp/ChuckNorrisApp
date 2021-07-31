//
//  ChuckNorrisFactDetailsViewController.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 12/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewController.swift
import RxCocoa
import RxSwift
import UIKit

final class ChuckNorrisFactDetailsViewController: BaseViewController {
    
    private let viewModel: ChuckNorrisFactDetailsViewModelType
    private let router: ChuckNorrisFactDetailsRouting
    
    @IBOutlet private weak var shareButton: PrimaryButton!
    @IBOutlet private weak var factLabel: UILabel!
    @IBOutlet private weak var categoryContentView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var discoveredIn: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var factContentView: UIView!
    
    init(withViewModel viewModel: ChuckNorrisFactDetailsViewModelType, router: ChuckNorrisFactDetailsRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.onViewDidLoad.onNext(())
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.output.selectedFact
            .drive { [weak self] fact in
                guard let self = self else { return }
                self.categoryLabel.text = fact.categorie
                self.factLabel.text = fact.value
                self.discoveredIn.text = L10n.ChuckNorrisFactDetails.Label.discoveredIn(fact.discoveredIn)
                
                if fact.textSize == .small {
                    self.factLabel.font = self.factLabel.font.withSize(15)
                }
            }
            .disposed(by: disposeBag)
        
        shareButton.rx.tap
            .bind { _ in
                let fact = self.factContentView.snapshot()
                let activityViewController = UIActivityViewController(
                    activityItems: [fact],
                    applicationActivities: nil
                )
                self.present(activityViewController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    override func prepare() {
        super.prepare()
        prepareButton()
        categoryContentView.layer.masksToBounds = true
        categoryContentView.layer.cornerRadius = categoryContentView.frame.size.height / 2
        
        // TODO: Seria bom colocar estes numeros em uma constante... seria bom...
        scrollView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 16,
            right: 0
        )
    }
    
    private func prepareButton() {
        shareButton.setTitle(L10n.ChuckNorrisFactDetails.Button.share, for: .normal)
        shareButton.isEnabled = true
        
        let shareIcon = UIImage(asset: Asset.Assets.share)
        shareButton.semanticContentAttribute = .forceRightToLeft
        shareButton.imageView?.contentMode = .scaleAspectFit
        shareButton.tintColor = Asset.Colors.white.color
        shareButton.imageEdgeInsets = UIEdgeInsets(
            top: 8,
            left: 32,
            bottom: 8,
            right: 0
        )
        shareButton.setImage(shareIcon, for: .normal)
    }
    
    func getScrollView() -> UIScrollView {
        return self.scrollView
    }
}
