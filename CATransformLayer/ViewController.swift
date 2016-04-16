//
//  ViewController.swift
//  CATransformLayer
//
//  Created by 薛焱 on 16/3/11.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var redColor = UIColor.redColor()
    var orangeColor = UIColor.orangeColor()
    var yellowColor = UIColor.yellowColor()
    var greenColor = UIColor.grayColor()
    var purpleColor = UIColor.purpleColor()
    var blueColor = UIColor.blueColor()
    var transformLayer = CATransformLayer()
    var rotationTransform = CATransform3DIdentity
    let sideLength: CGFloat = 150.0
    var startPoint: CGPoint!
    var pix: CGFloat = 0
    var piy: CGFloat = 0
    @IBOutlet weak var someView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTransformLayer()
        transformLayer.frame = someView.bounds
        someView.layer.addSublayer(transformLayer)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpTransformLayer() {
        var layer = sideLayerWithColor(redColor)
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(orangeColor)
        var transform = CATransform3DMakeTranslation(sideLength / 2, 0.0, sideLength / -2)
        transform = CATransform3DRotate(transform, degreesToRadians(90.0), 0.0, 1.0, 0.0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(yellowColor)
        layer.transform = CATransform3DMakeTranslation(0.0, 0.0, -sideLength)
        transformLayer.addSublayer(layer)
        
        layer  = sideLayerWithColor(greenColor)
        transform = CATransform3DMakeTranslation(sideLength / -2, 0.0, sideLength / -2)
        transform = CATransform3DRotate(transform, degreesToRadians(90.0), 0.0, 1.0, 0.0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(blueColor)
        transform = CATransform3DTranslate(transform, 0.0, sideLength / -2, sideLength / 2)
        transform = CATransform3DRotate(transform, degreesToRadians(90.0), 1.0, 0.0, 0.0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(purpleColor)
        transform = CATransform3DMakeTranslation(0.0, sideLength / 2.0, sideLength / -2.0)
        transform = CATransform3DRotate(transform, degreesToRadians(90.0), 1.0, 0.0, 0.0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        transformLayer.anchorPointZ = sideLength / -2.0
        applyRoationForXOffset(10.0, yOffset: 0.0)
    }
    
    func applyRoationForXOffset(xOffset: Double, yOffset: Double){
        
        let totalOffset = sqrt(xOffset * xOffset + yOffset * yOffset)
        let totalRotation = CGFloat(totalOffset * M_PI / 180.0)
        
        let xRotationalFactor = CGFloat(xOffset) / totalRotation
        let yRotationalFactor = CGFloat(yOffset) / totalRotation
        let currentTransform = CATransform3DTranslate(transformLayer.sublayerTransform, 0.0, 0.0, 0.0)
        
        let rotationTransform = CATransform3DRotate(transformLayer.sublayerTransform, totalRotation, xRotationalFactor * currentTransform.m12 - yRotationalFactor * currentTransform.m11,  xRotationalFactor * currentTransform.m22 - yRotationalFactor * currentTransform.m21, xRotationalFactor * currentTransform.m32 - yRotationalFactor * currentTransform.m31)
        print(currentTransform.m12, currentTransform.m11)
        transformLayer.sublayerTransform = rotationTransform
    }
    
    func sideLayerWithColor(color: UIColor) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(origin: CGPointZero, size: CGSize(width: sideLength, height: sideLength))
        layer.backgroundColor = color.CGColor
        return layer
    }
    
    func degreesToRadians(degrees: Double) -> CGFloat {
        return CGFloat(degrees * M_PI / 180.0)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        startPoint = touch.locationInView(someView)
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        let currentPoint = touch.locationInView(someView)
        let deltaX = currentPoint.x - startPoint.x
        let deltaY = currentPoint.y - startPoint.y
        applyRoationForXOffset(Double(deltaX), yOffset: Double(deltaY))
        startPoint = touch.locationInView(someView)

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

