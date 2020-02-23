//
//  UIViewController+Extensions.swift
//  NewsHeadlineQuiz
//
//  Created by suraj poudel on 22/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
   func showIndicator(withTitle title: String, and Description:String) {
      let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
      indicator.label.text = title
      indicator.isUserInteractionEnabled = false
      indicator.detailsLabel.text = Description
      indicator.show(animated: true)
   }
   func hideIndicator() {
      MBProgressHUD.hide(for: self.view, animated: true)
   }
}
