//
//  FactsCell.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//

import UIKit
import IGListKit

final class FactsCell: UICollectionViewCell, NibLoadable {
    static let defaultHeight: CGFloat = 130
    
    @IBOutlet private weak var factsContainerView: UIView!
    @IBOutlet private weak var factLabel: UILabel!
    @IBOutlet private weak var moreButton: SmallPrimaryButton!
    
    var didSelectFact: ((String) -> Void)?
    private var id: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    private func prepare() {
        factsContainerView.layer.cornerRadius = 24
        factsContainerView.layer.masksToBounds = true
        moreButton.setTitle(L10n.ChuckNorrisFacts.Button.more, for: .normal)
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapOnMore)
        )
        moreButton.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func didTapOnMore() {
        guard let didSelectFact = didSelectFact,
              let id = id else { return }
        didSelectFact(id)
    }
    
    func setup(with model: ChuckNorrisFactsViewModel.DisplayableModel) {
        factLabel.text = model.fact
        id = model.id
    }
}

final class FactsSectionController: ListSectionController {
    var fact: ChuckNorrisFactsViewModel.DisplayableModel!
    var didSelectFact: (String) -> Void
    
    init(didSelectFact: @escaping (String) -> Void) {
        self.didSelectFact = didSelectFact
    }
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        guard let fact = object as? DiffableBox<ChuckNorrisFactsViewModel.DisplayableModel> else { return }
        self.fact = fact.value
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { fatalError() }
        
        let cell = context.dequeueReusableCell(
            withNibName: FactsCell.nibName,
            bundle: FactsCell.nibBundle,
            for: self,
            at: index
        ) as! FactsCell
        
        cell.setup(with: fact!)
        cell.didSelectFact = didSelectFact
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(
            width: collectionContext!.containerSize.width,
            height: FactsCell.defaultHeight
        )
    }
}
