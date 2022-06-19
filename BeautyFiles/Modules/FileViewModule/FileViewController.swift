//
//  FileViewController.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 17.06.2022.
//

import UIKit

enum Layout {
    case grid
    case table
    
    func toggle() -> Self {
        switch self {
        case .grid:
            return .table
        case .table:
            return .grid
        }
    }
}

final class FileViewController: UIViewController, StoryboardInstantiable {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    enum VCType {
        case main
        case secondary
    }
    
    var viewModel: FileViewModel?
    
    var type: VCType = .main
    
    var layout: Layout = .grid
    
    var dataForPushedVC: Node<RawFileObject>?
    
    // MARK: Views
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createGridLayout())
        collectionView.register(FileCollectionCell.self, forCellWithReuseIdentifier: FileCollectionCell.identifier)
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configure()
        viewModel?.viewDidLoad()
    }
    
    // MARK: Actions
    
    @objc private func switchLayout() {
        layout = layout.toggle()
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.collectionViewLayout = getCollectionViewLayout(for: layout)
    
        collectionView.layoutSubviews()
    }

}

// MARK: Configuration

private extension FileViewController {
    func configure() {
        configureNavBar()
        configureCollectionView()
    }
    
    func configureNavBar() {
        title = viewModel?.title
        let item = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .done, target: self, action: #selector(switchLayout))
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = item
    }
    
    
    // MARK: Collection View
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
    
    func getCollectionViewLayout(for layoutType: Layout) -> UICollectionViewCompositionalLayout {
        switch layoutType {
        case .grid:
            return createGridLayout()
        case .table:
            return createTableLayout()
        }
    }
    
    func createGridLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 16)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(144)), subitems: [item])
        
        group.contentInsets.leading = 16
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createTableLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 16)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64)), subitems: [item])
        group.contentInsets.leading = 16
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension FileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == .main { return viewModel?.fileTree?.children.count ?? 0 } else {
            print(dataForPushedVC?.children.count ?? 0)
            return dataForPushedVC?.children.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FileCollectionCell.identifier, for: indexPath) as! FileCollectionCell
        cell.cellType = layout
        cell.configureLayout()
        
        if type == .main {
            if let item = viewModel?.fileTree?.children[indexPath.item] {
                cell.configureCell(with: item.value)
            }
            return cell
        } else {
            if let item = dataForPushedVC?.children[indexPath.item] {
                cell.configureCell(with: item.value)
                print(item.value)
            }
            
            return cell
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if type == .main {
             let currentItem = viewModel?.fileTree?.children[indexPath.item]
            guard currentItem?.value.itemType == "d" else { return }
            
            let vc: FileViewController = .instantiate(storyboard: .main)
            vc.type = .secondary
            vc.dataForPushedVC = currentItem
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // MARK: TO-DO      
        }
    
    }
}
