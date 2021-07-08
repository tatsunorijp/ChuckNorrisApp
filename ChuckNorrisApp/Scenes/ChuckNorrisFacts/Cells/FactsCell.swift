//
//  FactsCell.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//

import UIKit
import IGListKit

class FactsCell: UICollectionViewCell, NibLoadable {
    static let defaultHeight: CGFloat = 100
    @IBOutlet weak var factLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    private func prepare() {
        factLabel.textColor = Asset.Colors.orange400.color
    }
    
    func setup(with model: String) {
        self.factLabel.text = model
    }

}

final class FactsSectionController: ListSectionController {
    var identifier: String?
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        guard let identifier =  object as? DiffableBox<String> else { return }
        self.identifier = identifier.value
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { fatalError() }
        
        let cell = context.dequeueReusableCell(
            withNibName: FactsCell.nibName,
            bundle: FactsCell.nibBundle,
            for: self,
            at: index
        ) as! FactsCell
        
        cell.setup(with: identifier ?? "")
        return cell
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(
            width: collectionContext!.containerSize.width,
            height: FactsCell.defaultHeight
        )
    }
}
