//
//  BAImageCaching.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

func main(transaction: @escaping () -> Void) {
    if Thread.isMainThread {
        transaction()
    } else {
        DispatchQueue.main.sync {
            transaction()
        }
    }
}

func mainAsync(transaction: @escaping () -> Void) {
    if Thread.isMainThread {
        transaction()
    } else {
        DispatchQueue.main.async {
            transaction()
        }
    }
}
