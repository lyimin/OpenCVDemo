//
//  UIImage+OpenCV.h
//  openCVDemo
//
//  Created by 梁亦明 on 16/8/30.
//  Copyright © 2016年 xiaoming.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/imgcodecs/ios.h>

@interface UIImage (OpenCV)

/**
 *  均值模糊
 */
+ (UIImage *) blurWithImage: (UIImage *) image;

/**
 *  高斯模糊
 */
+ (UIImage *) GaussianBlurWithImage:(UIImage *) image;

/**
 *  双边平滑
 */
+ (UIImage *) bilateralFilterWithImage:(UIImage *) image;

/**
 *  实现自己的线性滤波
 */
+ (UIImage *) filterWithImgae:(UIImage *) image ind:(int) ind ;

/**
 *  Sobel 导数
 */
+ (UIImage *) sobelWithImage:(UIImage *) image;

/**
 *  Laplacian算子
 */
+ (UIImage *) laplacianWithImage:(UIImage *) image;

/**
 *   Remapping重映射
 */
+ (UIImage *) remappingWithImage: (UIImage *) image;

/**
 *  卡通
 */
+ (UIImage *) cartoonWithImage:(UIImage *) image;

//+ (UIImage *) erosionWithImage:(UIImage *) image;

@end
