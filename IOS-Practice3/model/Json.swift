//
//  Json.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/04.
//
//스태틱은 만들어지면 프로젝트 내에서 하나로 돌려쓸수 있음 shared로 다른 파일에서 사용가능 (데이터 용량 적으로 이득을 볼수 있음)
//싱글톤 패턴 공부 해보기 인스턴스를하나로 돌려씀

import UIKit

enum ParsingType {
    case live
    case original
}

class Json: NSObject {
    static let shared = Json()
    
    func parsing(type: ParsingType) -> [LivelistModel] {
        var liveListModel: [LivelistModel] = []
        let jsonDecoder: JSONDecoder = JSONDecoder()
        var fileName = ""
        if type == .live {
            fileName = "live"
        } else {
            fileName = "original"
        }
        guard let liveDataAsset: NSDataAsset = NSDataAsset.init(name: fileName) else {
            return []
        }
        
        do {
            liveListModel =  try jsonDecoder.decode([LivelistModel].self, from: liveDataAsset.data)
        } catch let error {
            print("error: ", error)
        }
        
        return liveListModel
    }
}

