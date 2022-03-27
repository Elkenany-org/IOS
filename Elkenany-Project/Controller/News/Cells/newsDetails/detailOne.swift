//
//  detailOne.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/22/22.
//

import UIKit
import WebKit

class detailOne: UITableViewCell, WKUIDelegate {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var descriptionDetail: WKWebView!
    
    @IBOutlet weak var detailDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        descriptionDetail?.scrollView.bounces = false
        
//        func webViewDidFinishLoad(_ webView: UIWebView) {
//           // dynamically set WebView height
////            let pageTitle = descriptionDetail.stringByEvaluatingJavaScript(from: "document.title")
//
//           let tempString = descriptionDetail?.stringByEvaluatingJavaScript(from: "document.body.scrollHeight")
//           var tempHeight: CGFloat = 0.0
//           if let n = NumberFormatter().number(from: tempString!) {
//             tempHeight = CGFloat(n)
//           }
//            descriptionDetail?.frame.size.height = tempHeight
//
//    }
        descriptionDetail.uiDelegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    

    
    func webViewDidFinishLoad(webView: UIWebView) {
         webView.frame.size.height = 1
         webView.frame.size = webView.sizeThatFits(CGSize.zero)
    }
 

}
