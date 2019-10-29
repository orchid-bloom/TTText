//
//  ViewController.swift
//  TTText
//
//  Created by Tema.Tian on 2019/10/22.
//  Copyright © 2019 Tema.Tian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let username = "AliGator"
    
    let str: TTText = """
    Hello \(username, .color(.red)), isn't this \("cool", .color(.blue), .oblique, .underline(.purple, .single))?
    
    \(wrap: """
    \(" Merry Xmas! ", .font(.systemFont(ofSize: 36)), .color(.red), .bgColor(.yellow))
    \(image: #imageLiteral(resourceName: "santa.jpg"))
    """, .alignment(.center))
    
    Go there to \("learn more about String Interpolation", .link("https://github.com/apple/swift-evolution/blob/master/proposals/0228-fix-expressiblebystringinterpolation.md"), .underline(.blue, .single))!
    """
    
    label.attributedText = str.attributedString
    
    
    let str1: TTText = """
    Hello \(username, .color(.red)), isn't this \("cool", .color(.blue), .oblique, .underline(.purple, .single))?
    \(wrap: """
    \(" Merry Xmas! ", .font(.systemFont(ofSize: 36)), .color(.red), .bgColor(.yellow))\(image: #imageLiteral(resourceName: "santa.jpg"), frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
    """)
    Go there to \("learn more about String Interpolation", .link("https://github.com/apple/swift-evolution/blob/master/proposals/0228-fix-expressiblebystringinterpolation.md"), .underline(.blue, .single),
        .stroke(.red, 2),
        .font(UIFont.systemFont(ofSize: 44)))!
    """
    
    label.attributedText = str1.attributedString
  }


}

