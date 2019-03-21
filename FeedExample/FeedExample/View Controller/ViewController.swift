//
//  ViewController.swift
//  FeedExample
//
//  Created by Simon Lee on 3/21/19.
//  Copyright © 2019 Shao Ping Lee. All rights reserved.
//

import UIKit
import IGListKit

class ViewController: UIViewController {
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    let data: [FeedItem] = [
        FeedItem(pk: 0, rows: [
            TextRow(pk: 0, text: "Foo"),
            ImageListRow(pk: 1, images: [UIImage(named: "image1")!,
                                         UIImage(named: "image2")!])
        ]),
        FeedItem(pk: 1, rows: [
            TextRow(pk: 2, text: "Bar"),
            ImageListRow(pk: 3, images: [UIImage(named: "image1")!,
                                         UIImage(named: "image2")!,
                                         UIImage(named: "image3")!]),
            ImageListRow(pk: 4, images: [UIImage(named: "image1")!,
                                         UIImage(named: "image2")!,
                                         UIImage(named: "image3")!,
                                         UIImage(named: "image4")!]),
        ])
    ]

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        view.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            ])

        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.performUpdates(animated: true, completion: nil)
    }
}

extension ViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data.flatMap({ $0.rows })
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is TextRow:
            return TextSectionController()
        case is ImageListRow:
            return ImageListSectionController()
        default:
            return ListSectionController()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
