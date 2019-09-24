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
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
        
        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
//        let dataSource = context.coordinator.dataSource
        uiView.reloadData()
        print(context.coordinator.data.count)
    }
    
    func makeCoordinator() -> Coordinator<Data, RowContent> {
        return Coordinator(data: data)
    }
}

class Coordinator<Data: RandomAccessCollection, RowContent: View>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource where Data.Element: Identifiable {
    
//    private let data: Data
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        let swiftUIView: UIView = UIHostingController(rootView: Text("MUIE")).view
//        swiftUIView.preservesSuperviewLayoutMargins = false
        swiftUIView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(swiftUIView)
        
        NSLayoutConstraint.activate([
            swiftUIView.leftAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.leftAnchor),
            swiftUIView.rightAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.rightAnchor),
            swiftUIView.topAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.topAnchor),
            swiftUIView.bottomAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.bottomAnchor),
        ])
        
        return cell
    }
}
