//
//  SplashViewController.swift
//  Runner
//
//  Created by Harish Reddy on 24/05/23.
//

import UIKit

public class SplashViewController: UIViewController {
    
    
    public override func viewDidAppear(_ animated: Bool) {
        self.startFlutterApp()
    }
    
    func startFlutterApp() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let flutterEngine = appDelegate.flutterEngine
        let flutterViewController =
           FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)

       flutterViewController.modalPresentationStyle = .custom
       flutterViewController.modalTransitionStyle = .crossDissolve

        present(flutterViewController, animated: true, completion: nil)
        
    }
}
