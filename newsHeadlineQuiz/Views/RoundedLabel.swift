//
//  RoundLabel.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedLabel: UILabel {
    
       override func layoutSubviews() {
           super.layoutSubviews()

            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.frame.height/2.0
       }
    
      override func draw(_ rect: CGRect) {
        
           //Draw the circle
           let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2,y: self.frame.width / 2), radius: self.frame.width/2 - 10, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)

           let circleLayer = CAShapeLayer()
           circleLayer.path = circlePath.cgPath
           circleLayer.fillColor = UIColor.clear.cgColor
           circleLayer.strokeColor = UIColor.white.cgColor
           circleLayer.lineWidth = 2

           self.layer.addSublayer(circleLayer)
        
           //Now the text Layer
        
            let textLayer = CATextLayer()
            let combination = NSMutableAttributedString()
            let fontOne = UIFont(name: "MarkerFelt-Wide", size: self.frame.width/10)
            let fontTwo = UIFont(name: "MarkerFelt-Wide", size: self.frame.width/5)
            let attributedString1 = NSAttributedString(string: "THAT'S RIGHT\n",
                                             attributes: [.font: fontOne!,
                                                         .foregroundColor: UIColor.white,.underlineStyle:NSUnderlineStyle.thick.rawValue])
            let attributedString2 = NSAttributedString(string: "YOU WON\n",
                                                       attributes: [.font:fontOne!,.foregroundColor: UIColor.white])
            let attributedString3 = NSMutableAttributedString(string:"8 POINTS",attributes: [.font: fontOne!,
                                                                                             .foregroundColor: UIColor.white,NSAttributedString.Key.underlineStyle:NSUnderlineStyle.thick.rawValue])
            combination.append(attributedString1)
            combination.append(attributedString2)
            let biggerFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font:fontTwo!]
            let range = NSString(string: "8 POINTS").range(of: "8")
            attributedString3.addAttributes(biggerFontAttribute, range: range)
            combination.append(attributedString3)
        
            let textwidth = ((self.frame.width-20)*(self.frame.width-20)/2).squareRoot()
            let textHeight = ((self.frame.width-20)*(self.frame.width-20)/2).squareRoot()
            let xPosition = ((self.frame.width)-(textwidth))/2
            let yPosition = ((self.frame.height)-(textHeight))/2
                                textLayer.string = combination
            textLayer.alignmentMode = .center
            textLayer.frame = CGRect(x: xPosition, y: yPosition, width: textwidth, height:textHeight)
            self.layer.addSublayer(textLayer)
    }
    
    func clear(){
        self.layer.sublayers?.removeAll()
        setNeedsDisplay()
    }
    
    
}
