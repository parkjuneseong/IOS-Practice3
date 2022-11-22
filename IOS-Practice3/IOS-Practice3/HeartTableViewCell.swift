//
//  HeartTableViewCell.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/18.
//

import UIKit

class HeartTableViewCell: UITableViewCell {
    var liveList = Json.shared.parsing(type: .live)
    var originalList = Json.shared.parsing(type: .original)
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var displayTitleName: UILabel!
    @IBOutlet weak var idName: UILabel!
    func bind(display: String , id : Int ,name:String){
        displayTitleName.text = display
        idName.text = "\(id)" //String(id)
        authorName.text = name
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//
//        displayTitleName.text =  "쎅스"
//        idName.text = "마렵다"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
