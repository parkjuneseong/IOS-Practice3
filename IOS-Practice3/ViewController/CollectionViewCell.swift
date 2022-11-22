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
    
    @IBOutlet weak var animationImageView: UIImageView!
    
    func bind(title : String , name : String , image : String,
              create : String, visit : Int, playCnt: Int,dur : Int,type:ParsingType){
        titleName.text = title
        authorName.text = name
        titleImage.image = UIImage(named: image)
        createTime.text = Convert.shared.convertTime(time:create)
        visitCount.text = "▶︎ \( Convert.shared.convertCount(count:visit))"
        if type == .original{
            playCount.text = Convert.shared.convertDuration(duration: dur)}
        else{
            playCount.text = "🎧\(playCnt)"
        }
    }
    
    
}


