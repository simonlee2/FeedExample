//
//  TextSectionController.swift
//  FeedExample
//
//  Created by Simon Lee on 3/21/19.
//  Copyright © 2019 Shao Ping Lee. All rights reserved.
//
import UIKit
import IGListKit

class TextSectionController: ListSectionController {
    var textRow: TextRow?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 44)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: LabelCell.self,
                                                                for: self,
                                                                at: index) as? LabelCell else {
                                                                    fatalError()
        }

        cell.text = textRow?.text

        return cell
    }

    override func didUpdate(to object: Any) {
        textRow = object as? TextRow
    }
}
