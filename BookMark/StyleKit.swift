//
//  StyleKit.swift
//  Bookmark
//
//  Created by Joshua Kuehn on 5/7/16.
//  Copyright (c) 2016 KuehnLLC. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class StyleKit : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfBmArtPlaceHolder: UIImage?
        static var bmArtPlaceHolderTargets: [AnyObject]?
        static var imageOfCanvas1: UIImage?
        static var canvas1Targets: [AnyObject]?
        static var imageOfBookmarkid: UIImage?
        static var bookmarkidTargets: [AnyObject]?
    }

    //// Drawing Methods

    public class func drawBmArtPlaceHolder() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let fillColor = UIColor(red: 0.971, green: 0.907, blue: 0.109, alpha: 1.000)
        let fillColor5 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let textForeground = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let fillColor7 = UIColor(red: 0.816, green: 0.008, blue: 0.107, alpha: 1.000)
        let fillColor11 = UIColor(red: 0.256, green: 0.460, blue: 0.020, alpha: 1.000)
        let fillColor12 = UIColor(red: 0.564, green: 0.073, blue: 0.995, alpha: 1.000)
        let fillColor13 = UIColor(red: 0.191, green: 0.143, blue: 1.000, alpha: 1.000)
        let fillColor14 = UIColor(red: 0.740, green: 0.061, blue: 0.879, alpha: 1.000)
        let fillColor15 = UIColor(red: 0.962, green: 0.650, blue: 0.139, alpha: 1.000)
        let fillColor16 = UIColor(red: 0.721, green: 0.913, blue: 0.527, alpha: 1.000)
        let fillColor17 = UIColor(red: 0.000, green: 0.866, blue: 1.000, alpha: 1.000)
        let fillColor18 = UIColor(red: 0.494, green: 0.826, blue: 0.130, alpha: 1.000)
        let fillColor19 = UIColor(red: 0.314, green: 0.888, blue: 0.760, alpha: 1.000)
        let fillColor20 = UIColor(red: 0.289, green: 0.565, blue: 0.886, alpha: 1.000)

        //// Group 3
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip 5
        let clip5Path = UIBezierPath()
        clip5Path.moveToPoint(CGPoint(x: 40, y: 80))
        clip5Path.addCurveToPoint(CGPoint(x: 80, y: 40), controlPoint1: CGPoint(x: 62.09, y: 80), controlPoint2: CGPoint(x: 80, y: 62.09))
        clip5Path.addCurveToPoint(CGPoint(x: 40, y: 0), controlPoint1: CGPoint(x: 80, y: 17.91), controlPoint2: CGPoint(x: 62.09, y: 0))
        clip5Path.addCurveToPoint(CGPoint(x: 0, y: 40), controlPoint1: CGPoint(x: 17.91, y: 0), controlPoint2: CGPoint(x: 0, y: 17.91))
        clip5Path.addCurveToPoint(CGPoint(x: 40, y: 80), controlPoint1: CGPoint(x: 0, y: 62.09), controlPoint2: CGPoint(x: 17.91, y: 80))
        clip5Path.closePath()
        clip5Path.usesEvenOddFillRule = true;

        clip5Path.addClip()


        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: -5, y: -5, width: 90, height: 90))
        fillColor5.setFill()
        rectanglePath.fill()


        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 57, y: 11.02, width: 14.7, height: 12.85), cornerRadius: 5)
        fillColor11.setFill()
        rectangle2Path.fill()


        //// Rectangle 3 Drawing
        let rectangle3Path = UIBezierPath(roundedRect: CGRect(x: 71.73, y: 45.95, width: 12.85, height: 13.8), cornerRadius: 5)
        fillColor13.setFill()
        rectangle3Path.fill()


        //// Rectangle 4 Drawing
        let rectangle4Path = UIBezierPath(roundedRect: CGRect(x: 41.38, y: 59.77, width: 44.15, height: 12.85), cornerRadius: 5)
        fillColor7.setFill()
        rectangle4Path.fill()


        //// Rectangle 5 Drawing
        let rectangle5Path = UIBezierPath(roundedRect: CGRect(x: 6.45, y: -3.7, width: 32.2, height: 18.4), cornerRadius: 5)
        fillColor14.setFill()
        rectangle5Path.fill()


        //// Rectangle 6 Drawing
        let rectangle6Path = UIBezierPath(roundedRect: CGRect(x: 7.35, y: 14.72, width: 14.7, height: 16.55), cornerRadius: 5)
        fillColor15.setFill()
        rectangle6Path.fill()


        //// Rectangle 7 Drawing
        let rectangle7Path = UIBezierPath(roundedRect: CGRect(x: 22.98, y: 14.7, width: 15.65, height: 42.3), cornerRadius: 5)
        fillColor16.setFill()
        rectangle7Path.fill()


        //// Group 4
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip
        let clipPath = UIBezierPath(roundedRect: CGRect(x: 57, y: 23.93, width: 14.7, height: 35.85), cornerRadius: 5)
        clipPath.addClip()


        //// Rectangle 8 Drawing
        let rectangle8Path = UIBezierPath(rect: CGRect(x: 52, y: 18.93, width: 24.7, height: 45.85))
        fillColor12.setFill()
        rectangle8Path.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)


        //// Rectangle 10 Drawing
        let rectangle10Path = UIBezierPath(roundedRect: CGRect(x: 22.98, y: 57.02, width: 17.45, height: 30.35), cornerRadius: 5)
        fillColor.setFill()
        rectangle10Path.fill()


        //// Group 5
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip 2
        let clip2Path = UIBezierPath(roundedRect: CGRect(x: 6.45, y: 23.92, width: 71.7, height: 22.05), cornerRadius: 5)
        clip2Path.addClip()


        //// Rectangle 11 Drawing
        let rectangle11Path = UIBezierPath(rect: CGRect(x: 1.45, y: 18.92, width: 81.7, height: 32.05))
        fillColor5.setFill()
        rectangle11Path.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)


        //// Group 6
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip 3
        let clip3Path = UIBezierPath(roundedRect: CGRect(x: 58.88, y: 72.65, width: 26.65, height: 13.8), cornerRadius: 5)
        clip3Path.addClip()


        //// Rectangle 13 Drawing
        let rectangle13Path = UIBezierPath(rect: CGRect(x: 53.88, y: 67.65, width: 36.65, height: 23.8))
        fillColor17.setFill()
        rectangle13Path.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)


        //// Label Drawing
        let labelRect = CGRect(x: 23.99, y: 25.71, width: 43.31, height: 22)
        let labelTextContent = NSString(string: "Book")
        let labelStyle = NSMutableParagraphStyle()
        labelStyle.alignment = .Center

        let labelFontAttributes = [NSFontAttributeName: UIFont(name: "ArialMT", size: 19)!, NSForegroundColorAttributeName: textForeground, NSParagraphStyleAttributeName: labelStyle]

        let labelTextHeight: CGFloat = labelTextContent.boundingRectWithSize(CGSize(width: labelRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: labelFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, labelRect)
        labelTextContent.drawInRect(CGRect(x: labelRect.minX, y: labelRect.minY + (labelRect.height - labelTextHeight) / 2, width: labelRect.width, height: labelTextHeight), withAttributes: labelFontAttributes)
        CGContextRestoreGState(context)


        //// Rectangle 16 Drawing
        let rectangle16Path = UIBezierPath(roundedRect: CGRect(x: 41.38, y: 72.65, width: 17.45, height: 14.7), cornerRadius: 5)
        fillColor18.setFill()
        rectangle16Path.fill()


        //// Rectangle 17 Drawing
        let rectangle17Path = UIBezierPath(roundedRect: CGRect(x: 40.48, y: 51.5, width: 16.55, height: 8.3), cornerRadius: 4.15)
        fillColor19.setFill()
        rectangle17Path.fill()


        //// Group 7
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip 4
        let clip4Path = UIBezierPath(roundedRect: CGRect(x: 7.33, y: 31.25, width: 15.65, height: 56.1), cornerRadius: 5)
        clip4Path.addClip()


        //// Rectangle 18 Drawing
        let rectangle18Path = UIBezierPath(rect: CGRect(x: 2.32, y: 26.25, width: 25.65, height: 66.1))
        fillColor20.setFill()
        rectangle18Path.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
    }

    public class func drawCanvas1() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let fillColor = UIColor(red: 0.971, green: 0.907, blue: 0.109, alpha: 1.000)
        let fillColor5 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let fillColor7 = UIColor(red: 0.816, green: 0.008, blue: 0.107, alpha: 1.000)
        let fillColor11 = UIColor(red: 0.256, green: 0.460, blue: 0.020, alpha: 1.000)
        let fillColor12 = UIColor(red: 0.564, green: 0.073, blue: 0.995, alpha: 1.000)
        let fillColor13 = UIColor(red: 0.191, green: 0.143, blue: 1.000, alpha: 1.000)
        let fillColor14 = UIColor(red: 0.740, green: 0.061, blue: 0.879, alpha: 1.000)
        let fillColor15 = UIColor(red: 0.962, green: 0.650, blue: 0.139, alpha: 1.000)
        let fillColor16 = UIColor(red: 0.721, green: 0.913, blue: 0.527, alpha: 1.000)
        let fillColor17 = UIColor(red: 0.000, green: 0.866, blue: 1.000, alpha: 1.000)
        let fillColor18 = UIColor(red: 0.494, green: 0.826, blue: 0.130, alpha: 1.000)
        let fillColor19 = UIColor(red: 0.314, green: 0.888, blue: 0.760, alpha: 1.000)
        let fillColor20 = UIColor(red: 0.289, green: 0.565, blue: 0.886, alpha: 1.000)
        let fillColor21 = UIColor(red: 0.000, green: 0.659, blue: 0.533, alpha: 1.000)

        //// Group 3
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip 4
        let clip4Path = UIBezierPath()
        clip4Path.moveToPoint(CGPoint(x: 40, y: 80))
        clip4Path.addCurveToPoint(CGPoint(x: 80, y: 40), controlPoint1: CGPoint(x: 62.09, y: 80), controlPoint2: CGPoint(x: 80, y: 62.09))
        clip4Path.addCurveToPoint(CGPoint(x: 40, y: 0), controlPoint1: CGPoint(x: 80, y: 17.91), controlPoint2: CGPoint(x: 62.09, y: 0))
        clip4Path.addCurveToPoint(CGPoint(x: 0, y: 40), controlPoint1: CGPoint(x: 17.91, y: 0), controlPoint2: CGPoint(x: 0, y: 17.91))
        clip4Path.addCurveToPoint(CGPoint(x: 40, y: 80), controlPoint1: CGPoint(x: 0, y: 62.09), controlPoint2: CGPoint(x: 17.91, y: 80))
        clip4Path.closePath()
        clip4Path.usesEvenOddFillRule = true;

        clip4Path.addClip()


        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: -5, y: -5, width: 90, height: 90))
        fillColor5.setFill()
        rectanglePath.fill()


        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 57.95, y: 11.02, width: 14.7, height: 12.85), cornerRadius: 5)
        fillColor11.setFill()
        rectangle2Path.fill()


        //// Rectangle 3 Drawing
        let rectangle3Path = UIBezierPath(roundedRect: CGRect(x: 72.68, y: 45.95, width: 12.85, height: 13.8), cornerRadius: 5)
        fillColor13.setFill()
        rectangle3Path.fill()


        //// Rectangle 4 Drawing
        let rectangle4Path = UIBezierPath(roundedRect: CGRect(x: 41.38, y: 59.77, width: 44.15, height: 12.85), cornerRadius: 5)
        fillColor7.setFill()
        rectangle4Path.fill()


        //// Rectangle 5 Drawing
        let rectangle5Path = UIBezierPath(roundedRect: CGRect(x: 6.45, y: -3.7, width: 32.2, height: 18.4), cornerRadius: 5)
        fillColor14.setFill()
        rectangle5Path.fill()


        //// Rectangle 6 Drawing
        let rectangle6Path = UIBezierPath(roundedRect: CGRect(x: 7.35, y: 14.72, width: 14.7, height: 16.55), cornerRadius: 5)
        fillColor15.setFill()
        rectangle6Path.fill()


        //// Rectangle 7 Drawing
        let rectangle7Path = UIBezierPath(roundedRect: CGRect(x: 22.98, y: 14.7, width: 15.65, height: 42.3), cornerRadius: 5)
        fillColor16.setFill()
        rectangle7Path.fill()


        //// Group 4
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip
        let clipPath = UIBezierPath(roundedRect: CGRect(x: 57.95, y: 23.93, width: 14.7, height: 35.85), cornerRadius: 5)
        clipPath.addClip()


        //// Rectangle 8 Drawing
        let rectangle8Path = UIBezierPath(rect: CGRect(x: 52.95, y: 18.93, width: 24.7, height: 45.85))
        fillColor12.setFill()
        rectangle8Path.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)


        //// Rectangle 10 Drawing
        let rectangle10Path = UIBezierPath(roundedRect: CGRect(x: 22.98, y: 57.02, width: 17.45, height: 30.35), cornerRadius: 5)
        fillColor.setFill()
        rectangle10Path.fill()


        //// Group 5
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip 2
        let clip2Path = UIBezierPath(roundedRect: CGRect(x: 58.88, y: 72.65, width: 26.65, height: 13.8), cornerRadius: 5)
        clip2Path.addClip()


        //// Rectangle 11 Drawing
        let rectangle11Path = UIBezierPath(rect: CGRect(x: 53.88, y: 67.65, width: 36.65, height: 23.8))
        fillColor17.setFill()
        rectangle11Path.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)


        //// Rectangle 13 Drawing
        let rectangle13Path = UIBezierPath(roundedRect: CGRect(x: 41.38, y: 72.65, width: 17.45, height: 14.7), cornerRadius: 5)
        fillColor18.setFill()
        rectangle13Path.fill()


        //// Rectangle 14 Drawing
        let rectangle14Path = UIBezierPath(roundedRect: CGRect(x: 40.48, y: 51.5, width: 16.55, height: 8.3), cornerRadius: 4.15)
        fillColor19.setFill()
        rectangle14Path.fill()


        //// Group 6
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip 3
        let clip3Path = UIBezierPath(roundedRect: CGRect(x: 7.33, y: 31.25, width: 15.65, height: 56.1), cornerRadius: 5)
        clip3Path.addClip()


        //// Rectangle 15 Drawing
        let rectangle15Path = UIBezierPath(rect: CGRect(x: 2.32, y: 26.25, width: 25.65, height: 66.1))
        fillColor20.setFill()
        rectangle15Path.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)


        //// Rectangle 17 Drawing
        let rectangle17Path = UIBezierPath(roundedRect: CGRect(x: 39.55, y: -12.88, width: 18.4, height: 63.45), cornerRadius: 5)
        fillColor21.setFill()
        rectangle17Path.fill()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
    }

    public class func drawBookmarkid() {
        //// Color Declarations
        let fillColor7 = UIColor(red: 0.816, green: 0.008, blue: 0.107, alpha: 1.000)
        let strokeColor4 = UIColor(red: 0.816, green: 0.008, blue: 0.107, alpha: 1.000)

        //// Group 2
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: 2, y: 2, width: 29.6, height: 31.7))
        strokeColor4.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 10.08, y: 6.92))
        bezierPath.addLineToPoint(CGPoint(x: 23.55, y: 6.92))
        bezierPath.addLineToPoint(CGPoint(x: 23.55, y: 28.78))
        bezierPath.addLineToPoint(CGPoint(x: 10.08, y: 28.78))
        bezierPath.addLineToPoint(CGPoint(x: 10.08, y: 6.92))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: 16.81, y: 21.13))
        bezierPath.addLineToPoint(CGPoint(x: 22.98, y: 28.78))
        bezierPath.addLineToPoint(CGPoint(x: 10.64, y: 28.78))
        bezierPath.addLineToPoint(CGPoint(x: 16.81, y: 21.13))
        bezierPath.closePath()
        bezierPath.usesEvenOddFillRule = true;

        fillColor7.setFill()
        bezierPath.fill()
    }

    //// Generated Images

    public class var imageOfBmArtPlaceHolder: UIImage {
        if Cache.imageOfBmArtPlaceHolder != nil {
            return Cache.imageOfBmArtPlaceHolder!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            StyleKit.drawBmArtPlaceHolder()

        Cache.imageOfBmArtPlaceHolder = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfBmArtPlaceHolder!
    }

    public class var imageOfCanvas1: UIImage {
        if Cache.imageOfCanvas1 != nil {
            return Cache.imageOfCanvas1!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 80, height: 80), false, 0)
            StyleKit.drawCanvas1()

        Cache.imageOfCanvas1 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfCanvas1!
    }

    public class var imageOfBookmarkid: UIImage {
        if Cache.imageOfBookmarkid != nil {
            return Cache.imageOfBookmarkid!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 33, height: 36), false, 0)
            StyleKit.drawBookmarkid()

        Cache.imageOfBookmarkid = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfBookmarkid!
    }

    //// Customization Infrastructure

    @IBOutlet var bmArtPlaceHolderTargets: [AnyObject]! {
        get { return Cache.bmArtPlaceHolderTargets }
        set {
            Cache.bmArtPlaceHolderTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector(NSSelectorFromString("setImage:"), withObject: StyleKit.imageOfBmArtPlaceHolder)
            }
        }
    }

    @IBOutlet var canvas1Targets: [AnyObject]! {
        get { return Cache.canvas1Targets }
        set {
            Cache.canvas1Targets = newValue
            for target: AnyObject in newValue {
                target.performSelector(NSSelectorFromString("setImage:"), withObject: StyleKit.imageOfCanvas1)
            }
        }
    }

    @IBOutlet var bookmarkidTargets: [AnyObject]! {
        get { return Cache.bookmarkidTargets }
        set {
            Cache.bookmarkidTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector(NSSelectorFromString("setImage:"), withObject: StyleKit.imageOfBookmarkid)
            }
        }
    }

}