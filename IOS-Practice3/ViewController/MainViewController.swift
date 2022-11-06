//
//  MainViewController.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/04.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var secondView: UICollectionView!
    @IBOutlet weak var kakaoTV: UILabel!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView.backgroundColor = .green
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        let list = Json.shared.parsing()
        print(list)
        kakaoTV.text = list[1].createTime
//        func segmentController(_ sender: UICollectionView) {
            // 새로운 뷰컨트롤러가 나오게 하는 코드
            
            //화면전환버튼
//            let vc =  LiveCollectionView()
//            self.navigationController?.pushViewController(vc, animated: true)

//    }
}
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            collectionView.alpha = 1.0
            secondView.alpha = 0.0
        }else {
            collectionView.alpha = 0.0
            secondView.alpha = 1.0
        }
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath)


        return cell ?? CollectionViewCell()     //return your cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
 
//    func collectionViewcell(_ collectionViewcell: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let itemSpacing: CGFloat = 1 // 가로에서 cell과 cell 사이의 거리
//            let textAreaHeight: CGFloat = 65 // textLabel이 차지하는 높이
//            let width: CGFloat = (collectionViewcell.bounds.width - itemSpacing)/2 // 셀 하나의 너비
//            let height: CGFloat = width * 10/7 + textAreaHeight //셀 하나의 높이
//
//            return CGSize(width: width, height: height)
//        }
}
//// func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:UICollectionViewLayout,
//referenceSizeHeaderinSection section: Int) -> CGSize
//{ㄱㄷㅅ}

