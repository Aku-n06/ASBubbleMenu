//
//  ASMenuBubble.swift
//
//
//  Created by alberto.scampini on 12/01/2016.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//

import UIKit

protocol ASMenuBubbleDelegate {
    func ASMenuBubbleSelectedMenuItemAtIndex (index : NSInteger)
}

class ASMenuBubble: UIView {
    
    let animationTime = 0.2
    let backgrowndAlpha = 0.5
    
    var delegate : ASMenuBubbleDelegate?
    
    var sheetView : UIView?
    var scrollView : UIScrollView?
    var bubbleDimension : CGFloat?
    var bubbleCloseDimension : CGFloat?
    var unitSize : CGFloat!
    var bubblesCount : NSInteger!
    var currentIcons : Array<UIImage>!
    
    //MARK: initialisations
    
    override init(frame: CGRect) {
        let mainWindow : UIWindow = UIApplication.sharedApplication().keyWindow!
        super.init(frame: mainWindow.bounds)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clearColor()
        //orientation notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func orientationChanged() {
        self.performSelector("updateOrientation", withObject: nil, afterDelay: 0.2)
    }
    
    func updateOrientation() {
        self.mathCalculations()
        self.openAnimated(false)
    }
    
    //MARK: public methods
    
    func showWithIcons(icons : Array<UIImage?>) {
        //check bubble dimension
        if (self.bubbleDimension == nil) {
            bubbleDimension = 100
        } else if  (bubbleDimension < 40) {
            self.bubbleDimension = 40
            NSLog("  !  ASMenuBubble - bubbleDimension too small")
        }
        
        //check icons
        currentIcons = Array<UIImage>()
        for icon in icons {
            if (icon == nil) {
                currentIcons.append(UIImage(named: "menuBubbleV")!)
            } else {
                currentIcons.append(icon!)
            }
        }
        
        self.createLayout()
        
        self.mathCalculations()
        
        //add the clese bubble in starting position (out of the screen)
        let initialCloseFrame = CGRect(x: (self.sheetView!.frame.size.width - self.bubbleCloseDimension!) / 2,
            y: self.sheetView!.frame.size.height,
            width: self.bubbleCloseDimension!,
            height: self.bubbleCloseDimension!)
        self.addBubbleWithFrame(initialCloseFrame, image: UIImage(named: "menuBubbleX")!, tag: -1)
        //add the bubbles in starting position (out of the screen)
        let initialFrame = CGRect(x: (self.sheetView!.frame.size.width - bubbleDimension!) / 2,
            y: self.scrollView!.contentSize.height,
            width: bubbleDimension!,
            height: bubbleDimension!)
        for index in 0...(self.currentIcons.count - 1) {
            self.addBubbleWithFrame(initialFrame, image: currentIcons[index], tag: index + 1)
        }
        
        self.openAnimated(true)
    }
    
    func createLayout() {
        //add self as a layer
        let mainWindow : UIWindow = UIApplication.sharedApplication().keyWindow!
        mainWindow.addSubview(self)
        //self layout
        self.translatesAutoresizingMaskIntoConstraints = false
        let selfTop = NSLayoutConstraint(item: self,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: mainWindow,
            attribute: .Top,
            multiplier: 1,
            constant: 0)
        let selfBottom = NSLayoutConstraint(item: self,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: mainWindow,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        let selfLeft = NSLayoutConstraint(item: self,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: mainWindow,
            attribute: .Left,
            multiplier: 1,
            constant: 0)
        let selfRight = NSLayoutConstraint(item: self,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: mainWindow,
            attribute: .Right,
            multiplier: 1,
            constant: 0)
        mainWindow.addConstraints([selfTop, selfBottom, selfLeft, selfRight])
        
        //create container view
        self.sheetView?.removeFromSuperview()
        self.sheetView = UIView.init(frame:self.bounds)
        self.sheetView?.backgroundColor = UIColor.clearColor()
        self.addSubview(self.sheetView!)
        //sheetWiew constraint
        self.sheetView!.translatesAutoresizingMaskIntoConstraints = false
        let sheetViewTop = NSLayoutConstraint(item: self.sheetView!,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Top,
            multiplier: 1,
            constant: 0)
        let sheetViewBottom = NSLayoutConstraint(item: self.sheetView!,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        let sheetViewRight = NSLayoutConstraint(item: self.sheetView!,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Right,
            multiplier: 1,
            constant: 0)
        let sheetViewLeft = NSLayoutConstraint(item: self.sheetView!,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Left,
            multiplier: 1,
            constant: 0)
        self.addConstraints([sheetViewTop, sheetViewBottom, sheetViewLeft, sheetViewRight])
        
        //create the scroll view
        self.scrollView = UIScrollView(frame:self.bounds)
        self.sheetView?.addSubview(self.scrollView!)
        self.scrollView?.translatesAutoresizingMaskIntoConstraints = false
        //sheetWiew constraint
        let scrollViewTop = NSLayoutConstraint(item: self.scrollView!,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.sheetView,
            attribute: .Top,
            multiplier: 1,
            constant: 0)
        let scrollViewBottom = NSLayoutConstraint(item: self.scrollView!,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self.sheetView,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        let scrollViewRight = NSLayoutConstraint(item: self.scrollView!,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self.sheetView,
            attribute: .Right,
            multiplier: 1,
            constant: 0)
        let scrollViewLeft = NSLayoutConstraint(item: self.scrollView!,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self.sheetView,
            attribute: .Left,
            multiplier: 1,
            constant: 0)
        self.sheetView!.addConstraints([scrollViewTop, scrollViewBottom, scrollViewLeft, scrollViewRight])
    }
    
    func mathCalculations() {
        //calculate number of bubble per row
        let unitsCount = NSInteger(self.frame.size.width / (self.bubbleDimension! / 2))
        bubblesCount = NSInteger(unitsCount / 2) - 1
        self.unitSize = (self.frame.size.width - (CGFloat(self.bubblesCount)  * bubbleDimension!)) / (CGFloat(self.bubblesCount) + 1)
        //calculate close bubble dimension
        self.bubbleCloseDimension = bubbleDimension! * 0.8
        //calculate scroll view content size
        let rowNumber = ceilNSInteger(CGFloat(self.currentIcons.count) /  CGFloat(self.bubblesCount))
        var scrollContentHeight = (CGFloat(rowNumber) * (self.bubbleDimension! + self.unitSize)) + self.bubbleCloseDimension! + 2 * self.unitSize
        if (scrollContentHeight < self.scrollView!.frame.size.height) {
            scrollContentHeight = self.scrollView!.frame.size.height
        }
        self.scrollView!.contentSize = CGSize(width: self.scrollView!.frame.size.width, height: scrollContentHeight)
        self.scrollView!.setContentOffset(CGPoint(x: 0, y: scrollContentHeight - self.scrollView!.frame.size.height), animated: false)
    }
    
    func openAnimated(animated : Bool) {
        let scrollContentHeight = self.scrollView!.contentSize.height
        //reposition first bubble (close button) at bottom center
        var rowOffset : CGFloat = self.sheetView!.frame.size.height - self.bubbleCloseDimension! - self.unitSize
        self.moveBubbleWithTag(-1, toFrame: CGRectMake((self.sheetView!.frame.size.width -  self.bubbleCloseDimension!) / 2,
            rowOffset,
            self.bubbleCloseDimension!,
            self.bubbleCloseDimension!),
        animated: animated)
        rowOffset = (scrollContentHeight - self.bubbleCloseDimension! - self.unitSize) - bubbleDimension! - self.unitSize
        //reposition the bubbles (in top of close button)
        var currentBubbleIndex = self.currentIcons.count
        while (currentBubbleIndex > 0 ) {
            if (currentBubbleIndex >= self.bubblesCount) {
                //full row
                for index in 0...(self.bubblesCount - 1) {
                    let emptySpaceOffset = self.unitSize * CGFloat(index + 1)
                    let xOffset = emptySpaceOffset + bubbleDimension! * CGFloat(index)
                    //add bubble
                    currentBubbleIndex = currentBubbleIndex - 1
                    self.moveBubbleWithTag(currentBubbleIndex + 1, toFrame: CGRectMake(xOffset, rowOffset, bubbleDimension!, bubbleDimension!), animated: animated)
                }
            }
            else {
                //calculate row x offset
                let fullBubbleSpace = (CGFloat(currentBubbleIndex) * bubbleDimension!)
                let fullEmptySpace = CGFloat(currentBubbleIndex + 1) * self.unitSize
                let startOffset = (self.frame.size.width - (fullBubbleSpace + fullEmptySpace) ) / 2
                //remining elements row
                for index in 0...(currentBubbleIndex - 1) {
                    let emptySpaceOffset = self.unitSize * CGFloat(index + 1)
                    let xOffset = emptySpaceOffset + bubbleDimension! * CGFloat(index) + startOffset
                    //add bubble
                    currentBubbleIndex = currentBubbleIndex - 1
                    self.moveBubbleWithTag(currentBubbleIndex + 1, toFrame: CGRectMake(xOffset, rowOffset, bubbleDimension!, bubbleDimension!), animated: animated)
                }
            }
            rowOffset = rowOffset - bubbleDimension! - self.unitSize
        }
        
        //background animation
        UIView.animateWithDuration(self.animationTime) { () -> Void in
            self.sheetView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:  CGFloat(self.backgrowndAlpha))
        }
    }
    
    func closeAnimated() {
        //add the clese bubble in starting position (out of the screen)
        let initialCloseFrame = CGRect(x: (self.sheetView!.frame.size.width - self.bubbleCloseDimension!) / 2,
            y: self.sheetView!.frame.size.height,
            width: self.bubbleCloseDimension!,
            height: self.bubbleCloseDimension!)
        self.moveBubbleWithTag(-1, toFrame: initialCloseFrame, animated: true)
        //add the bubbles in starting position (out of the screen)
        let initialFrame = CGRect(x: (self.sheetView!.frame.size.width - bubbleDimension!) / 2,
            y: self.scrollView!.contentSize.height,
            width: bubbleDimension!,
            height: bubbleDimension!)
        for index in 0...(self.currentIcons.count - 1) {
            self.moveBubbleWithTag(index + 1, toFrame: initialFrame, animated: true)
        }
        //background animation

        UIView.animateWithDuration(self.animationTime, animations: { () -> Void in
            self.sheetView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            }) { (flag) -> Void in
                self.removeFromSuperview()
        }
    }
    
    //MARK: private method
    
    private func addBubbleWithFrame(frame : CGRect, image : UIImage, tag : NSInteger) {
        let bubble = UIImageView.init(frame: frame)
        bubble.tag = tag
        bubble.contentMode = .ScaleAspectFit
        bubble.image = image
        //customize
        bubble.backgroundColor = UIColor.whiteColor()
        bubble.layer.cornerRadius = frame.size.height / 2
        bubble.clipsToBounds = true
        //add touch response
        bubble.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        bubble.addGestureRecognizer(tapGestureRecognizer)
        if (tag == -1) {
            //add bubble close
            self.sheetView!.addSubview(bubble)
            bubble.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        } else {
            //add
            self.scrollView!.addSubview(bubble)
        }
    }
    
    private func moveBubbleWithTag(tag : NSInteger, toFrame : CGRect, animated : Bool) {
        let currentBubble = self.sheetView!.viewWithTag(tag)! as UIView
        if (animated == true) {
            UIView.animateWithDuration(self.animationTime) { () -> Void in
                currentBubble.frame = toFrame
            }
        } else {
            currentBubble.frame = toFrame
        }
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        if (gestureRecognizer.view?.tag == -1) {
            self.closeAnimated()
        }
        else {
            self.delegate?.ASMenuBubbleSelectedMenuItemAtIndex(NSInteger(gestureRecognizer.view!.tag) - 1)
        }
    }
    
    //MARK: math private method
    
    private func ceilNSInteger(value: CGFloat) -> NSInteger {
        var int = NSInteger(value)
        if (value - CGFloat(int) > 0) {
            int = int + 1
        }
        return int
    }
}
