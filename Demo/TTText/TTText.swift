//
//  AttrString.swift
//  AttrString
//
//  Created by Tema.Tian on 2019/10/19.
//  Copyright © 2019 Tema.Tian. All rights reserved.
//

import UIKit

struct TTText {
  let attributedString: NSAttributedString
}

extension TTText: ExpressibleByStringLiteral {
  init(stringLiteral: String) {
    self.attributedString = NSAttributedString(string: stringLiteral)
  }
}

extension TTText: CustomStringConvertible {
  var description: String {
    return String(describing: self.attributedString)
  }
}

extension TTText: ExpressibleByStringInterpolation {
  init(stringInterpolation: StringInterpolation) {
    self.attributedString = NSAttributedString(attributedString: stringInterpolation.attributedString)
  }
  
  struct StringInterpolation: StringInterpolationProtocol {
    var attributedString: NSMutableAttributedString
    
    init(literalCapacity: Int, interpolationCount: Int) {
      self.attributedString = NSMutableAttributedString()
    }
    
    func appendLiteral(_ literal: String) {
      let astr = NSAttributedString(string: literal)
      self.attributedString.append(astr)
    }
    
    func appendInterpolation(_ string: String, attributes: [NSAttributedString.Key: Any]) {
      let astr = NSAttributedString(string: string, attributes: attributes)
      self.attributedString.append(astr)
    }
  }
}

extension TTText.StringInterpolation {
  func appendInterpolation(_ string: String, _ style: TTText.Style) {
    let astr = NSAttributedString(string: string, attributes: style.attributes)
    self.attributedString.append(astr)
  }
}

extension TTText.StringInterpolation {
  func appendInterpolation(_ string: String, _ style: TTText.Style...) {
    var attrs: [NSAttributedString.Key: Any] = [:]
    style.forEach { attrs.merge($0.attributes, uniquingKeysWith: {$1}) }
    let astr = NSAttributedString(string: string, attributes: attrs)
    self.attributedString.append(astr)
  }
}

extension TTText.StringInterpolation {
  func appendInterpolation(image: UIImage, frame: CGRect = .zero) {
    let attachment = NSTextAttachment()
    let size = image.size
    if frame.equalTo(.zero) {
      attachment.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.width)
    } else {
      attachment.bounds = frame
    }
    attachment.image = image
    self.attributedString.append(NSAttributedString(attachment: attachment))
  }
}

extension TTText.StringInterpolation {
  func appendInterpolation(wrap string: TTText, _ style: TTText.Style...) {
    var attrs: [NSAttributedString.Key: Any] = [:]
    style.forEach { attrs.merge($0.attributes, uniquingKeysWith: {$1}) }
    let mas = NSMutableAttributedString(attributedString: string.attributedString)
    let fullRange = NSRange(mas.string.startIndex..<mas.string.endIndex, in: mas.string)
    mas.addAttributes(attrs, range: fullRange)
    self.attributedString.append(mas)
  }
}

extension TTText {
  struct Style {
    let attributes: [NSAttributedString.Key: Any]
    static func font(_ font: UIFont) -> Style {
      return Style(attributes: [.font: font])
    }
    static func color(_ color: UIColor) -> Style {
      return Style(attributes: [.foregroundColor: color])
    }
    static func bgColor(_ color: UIColor) -> Style {
      return Style(attributes: [.backgroundColor: color])
    }
    static func link(_ link: String) -> Style {
      return .link(URL(string: link)!)
    }
    static func link(_ link: URL) -> Style {
      return Style(attributes: [.link: link])
    }
    //字符间距 正值间距加宽，负值间距变窄，0表示默认效果
    static func kern(_ kern: CGFloat) -> Style {
      return Style(attributes: [.kern: kern])
    }
    static func paragraph(_ lineHeight: CGFloat, _ font: UIFont) -> Style {
      let paraStyle = NSMutableParagraphStyle()
      paraStyle.minimumLineHeight = lineHeight
      paraStyle.maximumLineHeight = lineHeight
      let baselineOffset = (lineHeight - font.lineHeight) / 4;
      return Style(attributes: [.paragraphStyle : paraStyle,
                                .baselineOffset : baselineOffset])
    }
    //正值向右倾斜，0无偏移效果，负值向左倾斜！
    static let oblique = Style(attributes: [.obliqueness: 0.1])
    static func deleteline (_ color: UIColor, _ style: NSUnderlineStyle) -> Style {
      return Style(attributes: [
        .strikethroughStyle: style,
        .strikethroughColor: color
        ])
    }
    static func underline(_ color: UIColor, _ style: NSUnderlineStyle) -> Style {
      return Style(attributes: [
        .underlineColor: color,
        .underlineStyle: style.rawValue
        ])
    }
    /*
     描边颜色要搭配非0的描边宽度才会生效，如果只设置了描边颜色，描边宽度为0，则没有描边效果
     描边宽度是正数，会对文字进行描边，但文字中心不填充（ 一种经典的空心文本样式是在该值为3.0）
     描边宽度是负数，会对文字进行描边，而且会同时对文字中心进行填充（填充的颜色为文字本来的字体颜色）
     */
    static func stroke(_ color: UIColor, _ width: CGFloat) -> Style {
      return Style(attributes: [
        .strokeColor: color,
        .strokeWidth: width
        ])
    }
    //正值向上偏移，负值向下偏移，默认0
    static func lineOffset(_ offset: CGFloat) -> Style {
      return Style(attributes: [
        .baselineOffset: offset
        ])
    }
    //扁平化正值横向拉伸，负值横向压缩，默认0（不拉伸）
    static func expansion(_ expansion: CGFloat) -> Style {
      return Style(attributes: [
        .expansion: expansion
        ])
    }
    static func alignment(_ alignment: NSTextAlignment) -> Style {
      let ps = NSMutableParagraphStyle()
      ps.alignment = alignment
      return Style(attributes: [.paragraphStyle: ps])
    }
  }
}



