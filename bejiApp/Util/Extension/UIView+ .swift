//
//  UIView+ .swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/07.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func addSubviews(_ views: [UIView]) -> [UIView] {
        views.forEach { view in
            addSubview(view)
        }
        return views
    }

    @discardableResult
    func addSubviews(_ views: UIView...) -> [UIView] {
        addSubviews(views)
        return views
    }
    func iterate(filter: ((UIView) -> Bool)? = nil, _ operation: (UIView) -> Void) {
        if filter?(self) ?? true {
            operation(self)
        }
        subviews.forEach { $0.iterate(filter: filter, operation) }
    }

    func iterate<T: UIView>(_ operation: (T) -> Void) {
        iterate { view in
            if let view = view as? T {
                operation(view)
            }
        }
    }
    func activateAutolayout() {
        iterate { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    func addBackground(image: UIImage) {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = image.resize(size: .init(width: width, height: height))
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}
