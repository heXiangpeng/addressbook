//
//  tools.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/15.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit


func colorToImage(color:UIColor,size:CGSize) -> UIImage{
    let rect = CGRectMake(0, 0, size.width, size.height)
    UIGraphicsBeginImageContext(rect.size)
    
    
    let context = UIGraphicsGetCurrentContext()
    
    
    
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    let oldImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //        // 2.开启上下文
    //        let imageW = oldImage.size.width + 2 * 5
    //        let imageH = oldImage.size.height + 2 * 5
    //        let imageSize = CGSizeMake(imageW, imageH);
    //        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0);
    //
    //        // 3.取得当前的上下文
    //       let ctx = UIGraphicsGetCurrentContext();
    //
    //        // 4.画边框(大圆)
    ////        [borderColor set];
    //        let bigRadius = imageW * 0.5; // 大圆半径
    //       let centerX = bigRadius; // 圆心
    //        let centerY = bigRadius;
    //        CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, CGFloat(M_PI * 2.0), 0);
    //        CGContextFillPath(ctx); // 画圆
    //
    //        // 5.小圆
    //        let smallRadius = bigRadius
    //        CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, CGFloat(M_PI * 2.0), 0);
    //        // 裁剪(后面画的东西才会受裁剪的影响)
    //        CGContextClip(ctx);
    //
    //       oldImage.drawInRect(CGRectMake(0, 0, oldImage.size.width, oldImage.size.height))
    //        // 6.画图
    ////        [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    //
    //        // 7.取图
    //        let newImage = UIGraphicsGetImageFromCurrentImageContext();
    //
    //        // 8.结束上下文
    //        UIGraphicsEndImageContext();
    //
    
    
    
    
    
    return oldImage
}

