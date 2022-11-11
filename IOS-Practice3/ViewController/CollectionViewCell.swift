//
//  CollectionViewCell.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/04.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playCount: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var visitCount: UILabel!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    
    func bind(title : String , name : String , image : String,
              create : String, visit : Int, player: Int){
        titleName.text = title
        authorName.text = name
        createTime.text = create
        visitCount.text = "▶︎ \(visit)"
        titleImage.image = UIImage(named: image)
        playCount.text = "\(player)"
    }
    
}
