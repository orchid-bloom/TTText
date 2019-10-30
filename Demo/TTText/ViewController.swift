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
    
    let username = "Tema.Tian"
    
    let str: TTText = """
    Hello \(username, .color(.red)), isn't this \("cool", .color(.blue), .oblique, .underline(.purple, .single))?
    
    \(wrap: """
    \(" Pikachu! ", .font(.systemFont(ofSize: 36)), .color(.red), .bgColor(.yellow))
    \(image: #imageLiteral(resourceName: "pikachu"))
    """, .alignment(.center))
    
    Go there to \("learn more about String Interpolation", .link("https://github.com/apple/swift-evolution/blob/master/proposals/0228-fix-expressiblebystringinterpolation.md"), .underline(.blue, .single))!
    """
    
    label.attributedText = str.attributedString
  }


}

