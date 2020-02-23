//
//  ProgressView.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation
import UIKit

class ProgressView: UIView {
    var progress: CGFloat {
        get {
            return progressLayer?.progress ?? 0
        }

        set {
            progressLayer?.progress = newValue
        }
    }

    override class var layerClass: AnyClass {
        return ProgressLayer.self
    }

    private var progressLayer: ProgressLayer? {
        return layer as? ProgressLayer
    }
    
}

 class ProgressLayer: CALayer {
    @NSManaged var progress: CGFloat

    private let fillColor = UIColor.white.cgColor

    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "progress" {
            return true
        }

        return super.needsDisplay(forKey: key)
    }

    override func action(forKey key: String) -> CAAction? {
        if key == "progress" {
            let animation = CABasicAnimation(keyPath: key)
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.fromValue = presentation()?.value(forKey: key)
            return animation
        }

        return super.action(forKey: key)
    }

    override init() {
        super.init()
    }

    override init(layer: Any) {
        super.init(layer: layer)

        guard let progressLayer = layer as? ProgressLayer else { return }
        progress = progressLayer.progress
    }

    override func draw(in context: CGContext) {
        context.setFillColor(fillColor)

        let progress = presentation()?.progress ?? 0

        var rect = bounds
        rect.size.width *= progress
        context.fill(rect)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
