//
//  HeartViewController.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/18.
//

import UIKit

class HeartViewController: UIViewController{
    
    var liveList = Json.shared.parsing(type: .live)
    var originalList = Json.shared.parsing(type: .original)
    @IBOutlet weak var heartTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        heartTableView.register(UINib(nibName: "HeartTableViewCell", bundle: nil), forCellReuseIdentifier: "HeartTableViewCell")
        //        self.navigationItem.title = "좋아요 목록"
        //        let button = UIBarButtonItem(title: String("clear"),style: .plain, target: self, action: #selector(clearButtonAction(_:)))
        //        self.navigationItem.rightBarButtonItem = button
        //        let vc =  HeartViewController()
        //
        //        self.present(vc, animated: true)
        heartTableView.delegate = self
        heartTableView.dataSource = self
    }
    
    //        @objc
    //        func clearButtonAction(_ sender: Any) {
    //            let vc = MainViewController()
    //            self.navigationController?.pushViewController(vc, animated: true)
    //        }
    
}
extension HeartViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heartTableView.dequeueReusableCell(withIdentifier: "HeartTableViewCell", for: indexPath) as! HeartTableViewCell
        cell.bind(display: liveList[indexPath.row].displayTitle ?? "",
                  id:liveList[indexPath.row].channelId ?? 0,
                  name:liveList[indexPath.row].channel?.name ?? "" )
 
        return cell
    }
    
    
}
