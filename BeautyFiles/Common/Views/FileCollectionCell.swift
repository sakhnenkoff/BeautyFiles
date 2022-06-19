//
//  FileCollectionCell.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 17.06.2022.
//

import UIKit

final class FileCollectionCell: UICollectionViewCell {
        
    var cellType: Layout = .grid
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.numberOfLines = 0
        return label
    }()
    
    var currentConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configure()
    }
    
    deinit {
        NSLayoutConstraint.deactivate(currentConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    
    func configureCell(with file: RawFileObject) {
        cellImageView.image = file.itemType == "f" ? UIImage(systemName: "newspaper") : UIImage(systemName: "folder")
        cellLabel.text = file.name
    }
}

extension FileCollectionCell {
    func configure() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        contentView.layer.cornerRadius = 12 
    }
    
    func configureLayout() {
        switch cellType {
        case .grid:
            NSLayoutConstraint.deactivate(currentConstraints)
            
            let cellStackView: UIStackView = .getStackView(for: cellType)
            contentView.addSubview(cellStackView)
            
            cellStackView.addArrangedSubview(cellImageView)
            cellStackView.addArrangedSubview(cellLabel)
            cellStackView.translatesAutoresizingMaskIntoConstraints = false
            cellStackView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
            self.currentConstraints = [cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                      cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                      cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                                      cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                                      cellImageView.heightAnchor.constraint(equalToConstant: 54),
                                      cellImageView.widthAnchor.constraint(equalToConstant: 54),]
            
            NSLayoutConstraint.activate(currentConstraints)
            
        case .table:
            NSLayoutConstraint.deactivate(currentConstraints)
            let cellStackView: UIStackView = .getStackView(for: cellType, spacing: 8)
            contentView.addSubview(cellStackView)
            
            cellStackView.addArrangedSubview(cellImageView)
            cellStackView.addArrangedSubview(cellLabel)
            cellStackView.translatesAutoresizingMaskIntoConstraints = false
            cellStackView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
            self.currentConstraints = [cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                       cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                       cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
                                       cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
                                       cellImageView.widthAnchor.constraint(equalToConstant: 32),
                                       cellImageView.heightAnchor.constraint(equalToConstant: 32),]
        
            NSLayoutConstraint.activate(currentConstraints)
        }
    }
}
