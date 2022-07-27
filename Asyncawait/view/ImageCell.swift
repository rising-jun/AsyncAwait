//
//  ImageCell.swift
//  DiskCache
//
//  Created by 김동준 on 2022/07/21.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}

