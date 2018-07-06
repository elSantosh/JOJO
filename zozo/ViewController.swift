//
//  ViewController.swift
//  zozo
//
//  Created by Santosh Guruju | MACROKIOSK on 20/04/18.
//  Copyright © 2018 workstreak. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet var searchTF: UITextField!
    @IBOutlet var enterB: UIButton!
    @IBOutlet var vpnSW: UISwitch!
    @IBOutlet var adbSW: UISwitch!
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var mainWB: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func vpnSWAct(_ sender: Any) {
    }
    
    @IBAction func adbSWAct(_ sender: Any) {
    }
    @IBAction func enterAct(_ sender: Any) {
        print("searching")
    }
  
    //search delegate methods

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        var urlString: String = self.searchBar.text!

        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.allTypes.rawValue)
            let range = NSRange(location: 0, length: urlString.count)
            let block = { (result: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if let result = result, result.resultType == NSTextCheckingResult.CheckingType.link {
                    print(result.url ?? "")
                    self.mainWB.load(NSURLRequest(url: result.url! as URL) as URLRequest)
                }
                else
                {
                    print("googling", self.searchBar.text!)
                    urlString = urlString.replacingOccurrences(of:" ", with: "+", options: NSString.CompareOptions.literal, range: nil)
                    let url = NSURL(string: "https://www.google.com/search?q=\(urlString)")
                    let request = NSURLRequest(url: url! as URL)
                    self.mainWB.load(request as URLRequest)
            }
            }
            detector.enumerateMatches(in: urlString, options: [.reportProgress], range: range, using: block)
        

        } catch {
            print("errrrrrr")
            print(error)
        }
        UIView.animate(withDuration: 0.7, delay: 0.1, options: .allowAnimatedContent, animations: {() -> Void in
            //self.portalsScrollView.transform = CGAffineTransform(a: 1, b: 1, c: 0, d: 0, tx: 1, ty: 1)
            //            self.portalsScrollView.transform = CGAffineTransform(scaleX: 10, y: 15)
            
        }, completion: {(_ finished: Bool) -> Void in
            
        })
        searchBar.resignFirstResponder()
        
    }
    
}


