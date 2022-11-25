//
//  MainViewController.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/04.
//

import UIKit
import CloudKit

class MainViewController: UIViewController{
    
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var kakaoTV: UILabel!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headerView: UIView!
    var liveList: [VideoModel] = []
    var originalList: [VideoModel] = []
    
    //    var list1 = ["1", "2", "3", "4", "5", "6"] // segmentControl index == 0 --> 오리지날
    //    var list2 = ["2", "4", "6", "8"]    // segmentControl index == 1 --> 라이브purchaseButton.addTarget(self, action:
    override func viewDidLoad() {
        super.viewDidLoad()
//        if UIDevice.current.isiPad{
//            func numberOfSections(in collectionView: UICollectionView) -> Int {
//                return 1
//            }
//            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//                let width: CGFloat = collectionView.bounds.width - 40
//                let height: CGFloat = 270 // collectionViewCell 높이
//
//                return CGSize(width: width, height: height)
//            }
//        }
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(UINib(nibName:"CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        collectionView.register(UINib(nibName:"CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionReusableView")
        liveList = Json.shared.parsing(type: .live)
        originalList = Json.shared.parsing(type: .original)
    }
    @objc
    func longPressAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.ended{
            return
        }
        let touch : CGPoint = sender.location(in: self.collectionView)
        let indexPath: IndexPath = self.collectionView.indexPathForItem(at: touch) ?? IndexPath()
        var userDefaultsArray = UserDefaults.standard.array(forKey: "like") as? [Int] ?? []  // 가져오기
        var isLike = false
        if segmentController.selectedSegmentIndex == 1 {
            if userDefaultsArray.contains(liveList[indexPath.row].id ?? 0 ) {
                isLike = true
                if let index = userDefaultsArray.firstIndex(of: liveList[indexPath.row].id ?? 0){
                    userDefaultsArray.remove(at:index)
                }
            } else {
                isLike = false
                userDefaultsArray.append(liveList[indexPath.row].id ?? 0)
                }
            }
            else {
                if userDefaultsArray.contains(originalList[indexPath.row].id ?? 0){
                isLike = true
                if let index = userDefaultsArray.firstIndex(of: originalList[indexPath.row].id ?? 0){
                    userDefaultsArray.remove(at:index)
                }
            } else {
                    isLike = false
                    userDefaultsArray.append(originalList[indexPath.row].id ?? 0)
                
            }
        }
        let image = isLike ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
        
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        cell?.animationImageView.image = image
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
            cell?.animationImageView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            cell?.animationImageView.alpha = 1.0
        }) {
            finished in
            cell?.animationImageView.alpha = 0.0
            cell?.animationImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        UserDefaults.standard.set(userDefaultsArray, forKey: "like")
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        collectionView.reloadData()
        
    }
    
    
    @IBAction func touchButton(_ sender: Any) {
        
        let vc =  HeartViewController()
        
        self.present(vc, animated: true)
        
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as? CollectionViewCell
        
        if segmentController.selectedSegmentIndex == 1 {
            cell?.bind(
                title: liveList[indexPath.row].displayTitle ?? "",
                name: liveList[indexPath.row].channel?.name ?? "",
                image: liveList[indexPath.row].live?.thumbnailUrl ?? "",
                create: liveList[indexPath.row].createTime ?? "",
                visit: liveList[indexPath.row].channel?.visitCount ?? 0,
                playCnt: liveList[indexPath.row].live?.playCount ?? 0,
                dur: liveList[indexPath.row].live?.playCount ?? 0,
                type:.live
            )
        } else{
            cell?.bind(
                title: originalList[indexPath.row].displayTitle ?? "",
                name: originalList[indexPath.row].channel?.name ?? "",
                image: originalList[indexPath.row].clip?.thumbnailUrl ?? "",
                create: originalList[indexPath.row].createTime ?? "",
                visit: originalList[indexPath.row].channel?.visitCount ?? 0,
                playCnt: originalList[indexPath.row].clip?.duration ?? 0,
                dur:originalList[indexPath.row].clip?.duration ?? 0,
                type:.original
            )
            
        }
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        cell?.addGestureRecognizer(longPressRecognizer)
        
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
extension Date{
    var realativeTime_abbreviated:String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    

}
//
//extension UIDevice {
//    public var isiPhoneSE: Bool {
//        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 568 || UIScreen.main.bounds.size.width == 320) {
//            return true
//        }
//        return false
//    }
//    public var isiPhonePlus: Bool {
//        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 736 || UIScreen.main.bounds.size.width == 414) {
//            return true
//        }
//        return false
//    }
//
//    public var isiPad: Bool {
//        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad && (UIScreen.main.bounds.size.height == 1024 || UIScreen.main.bounds.size.width == 768) {
//            return true
//        }
//        return false
//    }
//    public var isiPadPro12: Bool {
//        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad && (UIScreen.main.bounds.size.height == 1366 || UIScreen.main.bounds.size.width == 1366) {
//            return true
//        }
//        return false
//    }
//
//}
