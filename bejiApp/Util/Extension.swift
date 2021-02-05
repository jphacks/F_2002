//
//  Extension.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}

public extension CALayer {
    func applyShadow(color: UIColor, alpha: CGFloat, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        shadowColor = color.cgColor
        shadowOpacity = Float(alpha)
        shadowOffset = .init(width: x, height: y)
        shadowRadius = blur / 2
        if spread == 0 {
            shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

public func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
class CustomView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = 10

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.1
        self.layer.backgroundColor = UIColor.white.cgColor
    }
}

class CustomCircleView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = 41

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.1
        self.layer.backgroundColor = UIColor.white.cgColor
    }
}

extension UIViewController {
    private final class StatusBarView: UIView { }

    func setStatusBarBackgroundColor(_ color: UIColor?) {
        for subView in self.view.subviews where subView is StatusBarView {
            subView.removeFromSuperview()
        }
        guard let color = color else {
            return
        }
        let statusBarView = StatusBarView()
        statusBarView.backgroundColor = color
        self.view.addSubview(statusBarView)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        statusBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
extension UIImage {
    func resize(size: CGSize) -> UIImage? {
        //比率が1/1だからそりゃ変わらないわ
        let widthRatio = size.width / size.width
        let heightRatio = size.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }
}
extension UIStackView {
    @discardableResult
    func addArrangedSubviews(_ views: [UIView]) -> [UIView] {
        views.forEach { addArrangedSubview($0) }
        return views
    }

    @discardableResult
    func addArrangedSubviews(_ views: UIView...) -> [UIView] {
        addArrangedSubviews(views)
    }
}
public extension UIViewController {
    /// Set translatesAutoresizingMaskIntoConstraints = false to all subviews (Not self.view)
    func activateAutolayout() {
        view.iterate { if $0 != view { $0.translatesAutoresizingMaskIntoConstraints = false } }
    }
}
public extension Array where Element: UIView {
    @discardableResult
    func activateAutoLayout() -> Self {
        forEach { $0.activateAutolayout() }
        return self
    }
}

