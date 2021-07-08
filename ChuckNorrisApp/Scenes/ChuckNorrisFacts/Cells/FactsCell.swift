//
//  FactsCell.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//

import UIKit
import IGListKit

class FactsCell: UICollectionViewCell, NibLoadable {
    static let defaultHeight: CGFloat = 300
    
    @IBOutlet private weak var categoryContainerView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var factLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    private func prepare() {
        categoryContainerView.layer.cornerRadius = categoryContainerView.frame.height / 2
        categoryContainerView.layer.masksToBounds = true
        categoryContainerView.backgroundColor = Asset.Colors.orange400.color
        categoryLabel.textColor = Asset.Colors.white.color
    }
    
    func setup(with model: ChuckNorrisFactsViewModel.DisplayableModel) {
        categoryLabel.text = model.categories.first
        factLabel.text = model.fact
        
        // MARK: Em um projeto real ele não receberia o tamanho do texto
        // Mas sim o tipo do texto, exemplo: H4 : H6
        let fontSize = model.textSize == .small ? 16 : 18
        factLabel.font = factLabel.font.withSize(CGFloat(fontSize))
    }
}

final class FactsSectionController: ListSectionController {
    var fact: ChuckNorrisFactsViewModel.DisplayableModel!
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        guard let fact =  object as? DiffableBox<ChuckNorrisFactsViewModel.DisplayableModel> else { return }
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
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        // MARK: O card de cada fato possui tamanho diferente de acordo a quantidade de letras
        // portanto, foi criado uma variável matemática para gerencia a altura de cada célula
        // TODO: Falta ajustes
        let fontSizemultiplier = fact.textSize == .small ? 200 : 350
        return CGSize(
            width: collectionContext!.containerSize.width,
            height: (CGFloat(fact.fact.count * fontSizemultiplier) / collectionContext!.containerSize.width) + 56
        )
    }
}
