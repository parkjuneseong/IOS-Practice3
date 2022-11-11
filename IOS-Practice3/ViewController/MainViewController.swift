//
//  MainViewController.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/04.
//

import UIKit
import CloudKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var kakaoTV: UILabel!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headerView: UIView!
    var liveList: [VideoModel] = []
    var originalList: [VideoModel] = []
//    var list1 = ["1", "2", "3", "4", "5", "6"] // segmentControl index == 0 --> 오리지날
//    var list2 = ["2", "4", "6", "8"]    // segmentControl index == 1 --> 라이브
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(UINib(nibName:"CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        collectionView.register(UINib(nibName:"CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionReusableView")
        liveList = Json.shared.parsing(type: .live)
        originalList = Json.shared.parsing(type: .original)
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as? CollectionViewCell
        if segmentController.selectedSegmentIndex == 1 {
            cell?.bind(
                title: liveList[indexPath.row].displayTitle ?? "",
                name: liveList[indexPath.row].channel?.name ?? "",
                image: liveList[indexPath.row].live?.thumbnailUrl ?? "",
                create: liveList[indexPath.row].createTime ?? "",
                visit: liveList[indexPath.row].channel?.visitCount ?? 0,
                player: liveList[indexPath.row].live?.playCount ?? 0
            )
        } else{
            cell?.bind(
                title: originalList[indexPath.row].displayTitle ?? "",
                name: originalList[indexPath.row].channel?.name ?? "",
                image: originalList[indexPath.row].clip?.thumbnailUrl ?? "",
                create: originalList[indexPath.row].createTime ?? "",
                visit: originalList[indexPath.row].channel?.visitCount ?? 0,
                player: originalList[indexPath.row].clip?.duration ?? 0
            )
        }
        
        return cell ?? CollectionViewCell()     //return your cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentController.selectedSegmentIndex == 1 {
            return liveList.count
        } else {
            return originalList.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - 40
        let height: CGFloat = 270 // collectionViewCell 높이
        
        return CGSize(width: width, height: height)
    }
//
//    func collectionViewcell(_ collectionViewcell: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSpacing: CGFloat = 1 // 가로에서 cell과 cell 사이의 거리
//        let textAreaHeight: CGFloat = 65 // textLabel이 차지하는 높이
//        let width: CGFloat = (collectionViewcell.bounds.width - itemSpacing)/2 // 셀 하나의 너비
//        let height: CGFloat = width * 10/7 + textAreaHeight //셀 하나의 높이
//
//        return CGSize(width: width, height: height)
//    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath)
          
            return view
        } else {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath)
   
            return view
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
}


