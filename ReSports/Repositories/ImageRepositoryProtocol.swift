//
//  ImageRepositoryProtocol.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/01.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import Foundation
import UIKit

protocol ImageRepositoryProtocol:class {
    // 画像を保存。全部保存したらcompletionを実行します。
    func save(image: UIImage, completion: ((_ imageUrl: String)->Void))
}
