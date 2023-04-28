//
//  RecipeWebPageViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 05/04/2023.
//

import UIKit
import WebKit

class RecipeWebPageViewController: UIViewController {
    
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    var recipeURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        initRecipeWebPage()
    }
    
    private func initRecipeWebPage() {
        guard let recipeURL else { return }
        let request = URLRequest(url: recipeURL)
        webView.load(request)
        webView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}

extension RecipeWebPageViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
