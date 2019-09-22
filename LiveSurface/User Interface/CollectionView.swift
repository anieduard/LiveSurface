//
//  CollectionView.swift
//  LiveSurface
//
//  Created by Ani Eduard on 22/09/2019.
//  Copyright © 2019 Ani Eduard. All rights reserved.
//

import SwiftUI

struct CollectionView<Data: RandomAccessCollection, RowContent: View>: UIViewRepresentable where Data.Element: Identifiable {
    
    private let data: Data
    private let rowContent: (Data.Element) -> RowContent
    
    init(_ data: Data, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) {
        self.data = data
        self.rowContent = rowContent
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        let dataSource = UICollectionViewDiffableDataSource<Section, SectionModel>(collectionView: collectionView) { collectionView, indexPath, sectionModel in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
            let swiftUIView = UIHostingController(rootView: self.rowContent(self.data.first!))
            cell.addSubview(swiftUIView.view)
            return cell
        }
        populate(dataSource: dataSource)
        context.coordinator.dataSource = dataSource
        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        let dataSource = context.coordinator.dataSource
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func populate(dataSource: UICollectionViewDiffableDataSource<Section, SectionModel>) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionModel>()
        snapshot.appendSections([.image])
        snapshot.appendItems([SectionModel(), SectionModel(), SectionModel()])
        dataSource.apply(snapshot)
    }
}

enum Section {
    case image
}

class SectionModel: Hashable {
    private let id = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return lhs.id == rhs.id
    }
}

class Coordinator {
    var dataSource: UICollectionViewDiffableDataSource<Section, SectionModel>?
}
