//
//  CollectionViewImage.swift
//  PictureCollectionView
//
//  Created by Matvei  on 01.12.2020.
//

import UIKit

class CollectionViewImage: UICollectionViewCell {
    static let identifier = "Cell"
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    
    func configure(with colors: UIColor, lineStation: [MLines], indexPath: Int) {

        imageView.backgroundColor = colors
        textLabel.text = lineStation[indexPath].name
    }
}
