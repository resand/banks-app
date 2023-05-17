//
//  UIImageView+Extensions.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import UIKit.UIImageView

extension UIImageView {
    private enum AssociatedKeys {
        static var CurrentTask = "CurrentTask"
    }

    var currentTask: URLSessionDataTask? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.CurrentTask) as? URLSessionDataTask
        }
        set {
            if let newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.CurrentTask,
                    newValue as URLSessionDataTask?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }

    func setImage(with image: String) {
        if image.isURL {
            setImage(with: URL(string: image))
        } else {
            self.image = UIImage(named: image)
        }
    }

    private func setImage(with url: URL?, placeholder: UIImage? = nil, animated: Bool = true) {
        currentTask?.cancel()

        // Set the placeholder meanwhile the image is downloaded
        image = placeholder

        guard let url else { return }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            replaceImage(cachedImage, animated: animated)
        } else {
            currentTask = URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data,
                   let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    mainAsync { [weak self] in
                        guard let self else { return }
                        self.replaceImage(image, animated: animated)
                    }
                }
            }
            currentTask?.resume()
        }
    }

    func replaceImage(_ image: UIImage, animated: Bool) {
        guard animated else {
            self.image = image
            return
        }

        UIView.transition(
            with: self,
            duration: 0.5,
            options: .transitionCrossDissolve
        ) {
            self.image = image
        }
    }
}
