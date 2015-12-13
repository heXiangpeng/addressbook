//
//  layer.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/5.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class layerla: CAShapeLayer {
    let ovalpath = UIBezierPath()
    
    
    var viewAnima:[UIBezierPath] = []
    
    var pointA:CGPoint!
    var pointB:CGPoint!
    var pointC:CGPoint!
    var pointD:CGPoint!
    var offset:CGFloat!
    
     let sizeview = [50,55,60,70,55,50]
    
    
    override init() {
        super.init()
        fillColor = UIColor.purpleColor().CGColor
      
        let width = CGFloat(50)
        
        let height = CGFloat(50)
        
        pointA = CGPointMake(width/2 , 0)
        pointB = CGPointMake(width , height/2)
        pointC = CGPointMake(width/2 , height)
        pointD = CGPointMake(0 , height/2)

        
    }
    
    
    func getview() ->[UIBezierPath]{
        for(var i = 0;i<6;i++){
            
            let x = CGFloat(sizeview[i])
            let poin = CGPointMake(x, 25)
            viewAnima.append(getView1(poin))
        }
        
        return viewAnima
    }
    
    
    func getView1(x:CGPoint) -> UIBezierPath{
        self.pointB = x
        offset = pointB.x / 3.6
        
        let c1 = CGPointMake(pointA.x + offset , pointA.y);
        let c2 = CGPointMake(pointB.x, pointB.y - offset );
        
        let c3 = CGPointMake(pointB.x, pointB.y+offset );
        let c4 = CGPointMake(pointC.x + offset , pointC.y);
        
        let c5 = CGPointMake(pointC.x - offset , pointC.y);
        let c6 = CGPointMake(pointD.x, pointD.y + offset);
        
        let c7 = CGPointMake(pointD.x, pointD.y - offset);
        let c8 = CGPointMake(pointA.x - offset , pointA.y);
        
        
        
        ovalpath.moveToPoint(pointA)
        
        ovalpath.addCurveToPoint(pointB, controlPoint1: c1, controlPoint2: c2)
        ovalpath.addCurveToPoint(pointC, controlPoint1: c3, controlPoint2: c4)
        ovalpath.addCurveToPoint(pointD, controlPoint1: c5, controlPoint2: c6)
        ovalpath.addCurveToPoint(pointA, controlPoint1: c7, controlPoint2: c8)
        
        ovalpath.closePath()
        
        
        return ovalpath

    }
    
    func dra(){
        print("计算")
        offset = pointB.x / 3.6
        
        let c1 = CGPointMake(pointA.x + offset , pointA.y);
        let c2 = CGPointMake(pointB.x, pointB.y - offset );
        
        let c3 = CGPointMake(pointB.x, pointB.y+offset );
        let c4 = CGPointMake(pointC.x + offset , pointC.y);
        
        let c5 = CGPointMake(pointC.x - offset , pointC.y);
        let c6 = CGPointMake(pointD.x, pointD.y + offset);
        
        let c7 = CGPointMake(pointD.x, pointD.y - offset);
        let c8 = CGPointMake(pointA.x - offset , pointA.y);
        
        
        
        ovalpath.moveToPoint(pointA)
        
        ovalpath.addCurveToPoint(pointB, controlPoint1: c1, controlPoint2: c2)
        ovalpath.addCurveToPoint(pointC, controlPoint1: c3, controlPoint2: c4)
        ovalpath.addCurveToPoint(pointD, controlPoint1: c5, controlPoint2: c6)
        ovalpath.addCurveToPoint(pointA, controlPoint1: c7, controlPoint2: c8)
        
        ovalpath.closePath()
        
        
        path = ovalpath.CGPath
    }
    
 

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        var pointA = CGPointMake(20 , 0)
        var pointB = CGPointMake(30 , 10)
        var pointC = CGPointMake(20 , 20)
        var pointD = CGPointMake(10 , 10)
        
        
        var c1 = CGPointMake(pointA.x , pointA.y);
        var c2 = CGPointMake(pointB.x, pointB.y );
        
        var c3 = CGPointMake(pointB.x, pointB.y );
        var c4 = CGPointMake(pointC.x , pointC.y);
        
        var c5 = CGPointMake(pointC.x , pointC.y);
        var c6 = CGPointMake(pointD.x, pointD.y );
        
        var c7 = CGPointMake(pointD.x, pointD.y );
        var c8 = CGPointMake(pointA.x , pointA.y);
        
        
        var ovalpath = UIBezierPath()
        ovalpath.moveToPoint(pointA)
        
        ovalpath.addCurveToPoint(pointB, controlPoint1: c1, controlPoint2: c2)
        ovalpath.addCurveToPoint(pointC, controlPoint1: c3, controlPoint2: c4)
        ovalpath.addCurveToPoint(pointD, controlPoint1: c5, controlPoint2: c6)
        ovalpath.addCurveToPoint(pointA, controlPoint1: c7, controlPoint2: c8)
        
        ovalpath.closePath()

        CGContextAddPath(ctx, ovalpath.CGPath)
//        var coli:UnsafePointer = UIColor.purpleColor().CGColor
//        UnsafePointer<CGFloat> cg = UIColor.purpleColor().CGColor
        CGContextSetFillColor(ctx,[1,1,1,1])
        CGContextFillPath(ctx);
    }
    
    
    
    

}
