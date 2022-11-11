//
//  LiveModel.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/04.
//

import UIKit
struct VideoModel : Codable {
    let id : Int?
    let channelId: Int?
    let displayTitle: String?
    let createTime : String?
    let channel: ChannelModel?
    let live: LiveModel?
    let clip: ClipModel?
}
