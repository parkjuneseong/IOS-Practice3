//
//  Theme.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/06.
//컨트롤 커맨드 스페이스 == 이모티콘나오게
//커맨드 쉬프트 a

import SwiftUI
struct Theme {
  static func backgroundColor(scheme: ColorScheme) -> Color {
    let lightColor = Color.white
    let darkColor = Color.gray
    
    switch scheme {
    case .light:
      return lightColor
    case .dark:
      return darkColor
    @unknown default:
      return lightColor
    }
  }
}
