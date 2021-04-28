//
//  TTTextg.swift
//  TTText
//
//  Created by Tema.Tian on 2019/10/19.
//  Copyright © 2019 Tema.Tian. All rights reserved.
//

import UIKit

public func attributedText(_ text: TTText) -> NSAttributedString {
  text.attributedString
}

public struct TTText {
  public let attributedString: NSAttributedString
}

extension TTText: ExpressibleByStringLiteral {
  public init(stringLiteral: String) {
    attributedString = NSAttributedString(string: stringLiteral)
  }
}

extension TTText: CustomStringConvertible {
  public var description: String {
    return String(describing: attributedString)
  }
}

extension TTText: ExpressibleByStringInterpolation {
  public init(stringInterpolation: StringInterpolation) {
    attributedString = NSAttributedString(attributedString: stringInterpolation.attributedString)
  }

  public struct StringInterpolation: StringInterpolationProtocol {
    var attributedString: NSMutableAttributedString

    public init(literalCapacity: Int, interpolationCount: Int) {
      attributedString = NSMutableAttributedString()
    }

    public func appendLiteral(_ literal: String) {
      let astr = NSAttributedString(string: literal)
      attributedString.append(astr)
    }

    public func appendInterpolation(_ string: String, attributes: [NSAttributedString.Key: Any]) {
      let astr = NSAttributedString(string: string, attributes: attributes)
      attributedString.append(astr)
    }
  }
}

extension TTText.StringInterpolation {
  public func appendInterpolation(_ string: String, _ style: TTText.Style) {
    let astr = NSAttributedString(string: string, attributes: style.attributes)
    attributedString.append(astr)
  }
}

extension TTText.StringInterpolation {
  public func appendInterpolation(_ string: String, _ style: TTText.Style...) {
    var attrs: [NSAttributedString.Key: Any] = [:]
    style.forEach { attrs.merge($0.attributes, uniquingKeysWith: { $1 }) }
    let astr = NSAttributedString(string: string, attributes: attrs)
    attributedString.append(astr)
  }
}

extension TTText.StringInterpolation {
  public func appendInterpolation(image: UIImage, frame: CGRect = .zero) {
    let attachment = NSTextAttachment()
    let size = image.size
    if frame.equalTo(.zero) {
      attachment.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.width)
    } else {
      attachment.bounds = frame
    }
    attachment.image = image
    attributedString.append(NSAttributedString(attachment: attachment))
  }
}

extension TTText.StringInterpolation {
  public func appendInterpolation(wrap string: TTText, _ style: TTText.Style...) {
    var attrs: [NSAttributedString.Key: Any] = [:]
    style.forEach { attrs.merge($0.attributes, uniquingKeysWith: { $1 }) }
    let mas = NSMutableAttributedString(attributedString: string.attributedString)
    let fullRange = NSRange(mas.string.startIndex ..< mas.string.endIndex, in: mas.string)
    mas.addAttributes(attrs, range: fullRange)
    attributedString.append(mas)
  }
}

extension TTText {
  public struct Style {
    let attributes: [NSAttributedString.Key: Any]
    public static func font(_ font: UIFont) -> Style {
      return Style(attributes: [.font: font])
    }

    public static func color(_ color: UIColor) -> Style {
      return Style(attributes: [.foregroundColor: color])
    }

    public static func bgColor(_ color: UIColor) -> Style {
      return Style(attributes: [.backgroundColor: color])
    }

    public static func link(_ link: String) -> Style {
      return .link(URL(string: link)!)
    }

    public static func link(_ link: URL) -> Style {
      return Style(attributes: [.link: link])
    }

    // Character spacing Positive spacing is widened, negative spacing is narrowed, 0 is the default effect
    public static func kern(_ kern: CGFloat) -> Style {
      return Style(attributes: [.kern: kern])
    }

    public static func lineSpace(_ spaceHeight: CGFloat) -> Style {
      let paraStyle = NSMutableParagraphStyle()
      paraStyle.lineSpacing = spaceHeight
      return Style(attributes: [.paragraphStyle: paraStyle])
    }

    public static func paragraph(_ lineHeight: CGFloat, _ font: UIFont) -> Style {
      let paraStyle = NSMutableParagraphStyle()
      paraStyle.minimumLineHeight = lineHeight
      paraStyle.maximumLineHeight = lineHeight
      paraStyle.lineBreakMode = .byTruncatingTail
      let baselineOffset = (lineHeight - font.lineHeight) / 4
      return Style(attributes: [.paragraphStyle: paraStyle,
                                .baselineOffset: baselineOffset])
    }

    // Positive value is tilted to the right, 0 has no offset effect, negative value is tilted to the left
    public static let oblique = Style(attributes: [.obliqueness: 0.1])
    public static func deleteline(_ color: UIColor, _ style: NSUnderlineStyle) -> Style {
      return Style(attributes: [
        .strikethroughStyle: NSNumber(value: style.rawValue),
        .strikethroughColor: color,
        .baselineOffset: NSNumber(0),
      ])
    }

    public static func underline(_ color: UIColor, _ style: NSUnderlineStyle) -> Style {
      return Style(attributes: [
        .underlineColor: color,
        .underlineStyle: style.rawValue,
      ])
    }

    /*
     The stroke color will take effect with a non-zero stroke width. If only the stroke color is set, the stroke width is 0, there is no stroke effect.
     The stroke width is a positive number, and the text is stroked, but the text center is not filled (a classic hollow text style is at 3.0)
     The stroke width is negative, the text is stroked, and the center of the text is filled at the same time (the color of the fill is the font color of the text)
     */
    public static func stroke(_ color: UIColor, _ width: CGFloat) -> Style {
      return Style(attributes: [
        .strokeColor: color,
        .strokeWidth: width,
      ])
    }

    // Positive value offset upward, negative value downward offset, default 0
    public static func lineOffset(_ offset: CGFloat) -> Style {
      return Style(attributes: [
        .baselineOffset: offset,
      ])
    }

    // Flattened positive lateral stretch, negative lateral compression, default 0 (no stretch)
    public static func expansion(_ expansion: CGFloat) -> Style {
      return Style(attributes: [
        .expansion: expansion,
      ])
    }

    public static func alignment(_ alignment: NSTextAlignment) -> Style {
      let ps = NSMutableParagraphStyle()
      ps.alignment = alignment
      return Style(attributes: [.paragraphStyle: ps])
    }
  }
}
