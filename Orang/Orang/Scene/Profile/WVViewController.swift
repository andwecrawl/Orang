//
//  WVViewController.swift
//  Orang
//
//  Created by yeoni on 2/13/24.
//

import Foundation
import WebKit

class WVViewController: BaseViewController, WKUIDelegate {
    var webView: WKWebView!
    var settingType: Setting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView()
    }
    
    func setWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
    }
    
    func loadWebView() {
        
        var link: String
        
        switch settingType {
        case .bugReport:
            link = "https://forms.gle/kZDrCuPwBHgqRoDUA"
        case .emailToDeveloper:
            link = "https://forms.gle/CBbHdFGzhC7s2gvT6"
        case .information:
            link = "https://andwecrawl.notion.site/f240807f535241f19ab7f275f6fba24c?pvs=4"
        default: return
        }
        
        let myURL = URL(string: link)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func setNavigationBar() {
        title = settingType?.rawValue
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        setWebView()
        view.addSubview(webView)
    }
    
    override func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}
