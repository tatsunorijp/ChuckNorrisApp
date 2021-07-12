//
//  ChuckNorrisFactsViewController.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewController.swift
import RxCocoa
import RxSwift
import UIKit
import IGListKit
import RxAlamofire
import Alamofire

final class ChuckNorrisFactsViewController: BaseViewController {
    
    private let viewModel: ChuckNorrisFactsViewModelType
    private let router: ChuckNorrisFactsRouting
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private enum Consts {
        static let topCollectionViewMargin: CGFloat = 16
        static let bottomCollectionViewMaring: CGFloat = 32
    }
    
    lazy var adapter: ListAdapter = {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        return adapter
    }()
    
    var chuckNorrisFacts: [ChuckNorrisFactsViewModel.DisplayableModel] = []
    
    init(withViewModel viewModel: ChuckNorrisFactsViewModelType, router: ChuckNorrisFactsRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.output.encounteredFacts
            .drive { [weak self] facts in
                self?.chuckNorrisFacts = facts
                self?.adapter.performUpdates(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .drive(isLoading)
            .disposed(by: disposeBag)
        
        viewModel.output.error
            .drive(error)
            .disposed(by: disposeBag)
    }
    
    override func prepare() {
        super.prepare()
        prepareCollectionView()
        prepareNavigationBar()
        
    }
    
    private func prepareCollectionView() {
        _ = adapter
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Asset.Colors.gray100.color
        collectionView.contentInset = UIEdgeInsets(
            top: Consts.topCollectionViewMargin,
            left: 0,
            bottom: Consts.bottomCollectionViewMaring,
            right: 0
        )
        collectionView.register(
            UINib(nibName: FactsCell.nibName, bundle: FactsCell.nibBundle),
            forCellWithReuseIdentifier: String(describing: FactsCell.self))
    }
    
    private func prepareNavigationBar() {
        title = L10n.ChuckNorrisFacts.title
        let searchButton = UIBarButtonItem(image: Asset.Assets.magnifier.image,
                                           style: .plain,
                                           target: self,
                                           action: #selector(navigateToSearch)
        )
        
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func navigateToSearch() {
        router.navigateToSearch(delegate: self)
    }
}

extension ChuckNorrisFactsViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var items: [ListDiffable] = []
        
        for fact in chuckNorrisFacts {
            items.append(DiffableBox(value: fact, identifier: fact.id as NSObjectProtocol))
        }
        
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return FactsSectionController { factId in
            print(factId)
            Alert.show(in: self, title: "Em produção", message: "Esta funcionalidade ainda não está pronta e será entregue proximamente.")
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return ChuckNorrisFactsEmptyView()
    }
}

extension ChuckNorrisFactsViewController: SearchFactsDelegate {
    func searchFacts(term: String) {
        viewModel.input.didSearchTextChange.onNext(term)
    }
}
