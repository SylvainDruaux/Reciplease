//
//  RecipeWebPageViewController.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 05/04/2023.
//

import UIKit
import WebKit

class RecipeWebPageViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var recipeURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecipeWebPage()
    }
    
    private func initRecipeWebPage() {
        guard let recipeURL else { return }
        let config = webView.configuration
        let prefs = config.defaultWebpagePreferences
        prefs?.allowsContentJavaScript = true
        webView.load(URLRequest(url: recipeURL))
    }
}
