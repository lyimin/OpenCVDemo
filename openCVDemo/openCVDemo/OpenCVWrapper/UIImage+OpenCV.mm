//
//  UIImage+OpenCV.m
//  openCVDemo
//
//  Created by 梁亦明 on 16/8/30.
//  Copyright © 2016年 xiaoming.com. All rights reserved.
//

#import "UIImage+OpenCV.h"

@implementation UIImage (OpenCV)


/**
 *  均值模糊
 */
+ (UIImage *) blurWithImage: (UIImage *) image {
    int MAX_KERNEL_LENGTH = 31;
    
    cv::Mat target;
    UIImageToMat(image, target);
    
    cv::Mat result;
    // 均值模糊
    for ( int i = 1; i < MAX_KERNEL_LENGTH; i = i + 2 ) {
        blur(target, result, cv::Size( i, i ), cv::Point(-1,-1));
    }
    return MatToUIImage(result);
}

/**
 *  高斯模糊
 */
+ (UIImage *) GaussianBlurWithImage: (UIImage *) image {
    int MAX_KERNEL_LENGTH = 31;
    
    cv::Mat target;
    UIImageToMat(image, target);
    
    cv::Mat result;
    
    // 高斯模糊
    for ( int i = 1; i < MAX_KERNEL_LENGTH; i = i + 2 ) {
        GaussianBlur(target, result, cv::Size(i, i), 0);
    }
    
    return MatToUIImage(result);
}


/**
 *  双边平滑
 */
+ (UIImage *) bilateralFilterWithImage:(UIImage *) image {
    int MAX_KERNEL_LENGTH = 31;
    
    cv::Mat target;
    UIImageToMat(image, target);
    cv::cvtColor(target, target, CV_RGBA2RGB, 3);
    cv::Mat result;
    // 双边平滑
    for ( int i = 1; i < MAX_KERNEL_LENGTH; i = i + 2 ) {
        bilateralFilter(target, result, i, i*2, i/2 );
    }
    return MatToUIImage(result);
}

/**
 *  实现自己的线性滤波
 */
+ (UIImage *) filterWithImgae:(UIImage *) image ind:(int) ind {
    cv::Mat target;
    UIImageToMat(image, target);
    
    cv::Mat result;
   
    // 初始化滤波器参数
    cv::Point anchor = cv::Point(-1, -1);
    double delta = 0;
    double ddepth = -1;
    
    // 更新归一化块滤波器的核大小
    
    // 这里执行3，5，7，9，11，13，15，17，19，21....等这20种核的滤波
    int kernel_size = 3 + 2*( ind%20 );
    cv::Mat kernel = cv::Mat::ones( kernel_size, kernel_size, CV_32F )/ (float)(kernel_size*kernel_size);
    // 使用滤波器
    filter2D(target, result, ddepth , kernel, anchor, delta, cv::BORDER_DEFAULT );
    
    return MatToUIImage(result);
}

/**
 *  Sobel导数
 */
+ (UIImage *) sobelWithImage:(UIImage *) image {
    int scale = 1;
    int delta = 0;
    
    cv::Mat target;
    UIImageToMat(image, target);
    
    cv::Mat result;
    
    cv::Mat src_gray;
    
    // 对原图像使用 GaussianBlur 降噪
    GaussianBlur( target, target, cv::Size(3,3), 0, 0, cv::BORDER_DEFAULT );
    // 转换为灰度图
    cvtColor( target, src_gray, CV_RGB2GRAY );
    // 创建 grad_x 和 grad_y 矩阵
    cv::Mat grad_x, grad_y;
    cv::Mat abs_grad_x, abs_grad_y;
    
    // 求 X方向梯度
    Sobel( src_gray, grad_x, CV_16S, 1, 0, 3, scale, delta, cv::BORDER_DEFAULT );
    convertScaleAbs( grad_x, abs_grad_x );
    
    // 求Y方向梯度
    Sobel( src_gray, grad_y, CV_16S, 0, 1, 3, scale, delta, cv::BORDER_DEFAULT );
    convertScaleAbs( grad_y, abs_grad_y );
    
    // 合并梯度(近似)
    addWeighted( abs_grad_x, 0.5, abs_grad_y, 0.5, 0, result );
    
    return MatToUIImage(result);
}

/**
 *  Laplacian算子
 */
+ (UIImage *) laplacianWithImage:(UIImage *) image {
    int kernel_size = 3;
    int scale = 1;
    int delta = 0;
    
    cv::Mat target;
    UIImageToMat(image, target);
    
    cv::Mat result;
    
    cv::Mat src_gray;
    // 使用高斯滤波消除噪声
    GaussianBlur( target, target, cv::Size(3,3), 0, 0, cv::BORDER_DEFAULT );
    // 转换为灰度图
    cvtColor( target, src_gray, CV_RGB2GRAY );
    // 使用Laplace函数
    cv::Mat abs_dst;
    Laplacian( src_gray, result, CV_16S, kernel_size, scale, delta, cv::BORDER_DEFAULT );
    convertScaleAbs( result, abs_dst );
    
    return MatToUIImage(abs_dst);
}

/**
 *   Remapping重映射
 */
+ (UIImage *) remappingWithImage: (UIImage *) image {
    
    cv::Mat target;
    UIImageToMat(image, target);
    
    cv::Mat result;
    
    // 创建目标图像和两个映射矩阵
    cv::Mat map_x, map_y;
    map_x.create(target.size(), CV_32FC1);
    map_y.create(target.size(), CV_32FC1);
    
    // 通过修改这个值来变换矩阵
    int ind = 1;
    
    for (int j = 0; j < target.rows; j++) {
        for (int i = 0; i < target.cols; i++) {
            switch (ind) {
                case 0:
                    if ( i > target.cols*0.25 && i < target.cols*0.75 && j > target.rows*0.25 && j < target.rows*0.75 ) {
                        map_x.at<float>(j,i) = 2*( i - target.cols*0.25 ) + 0.5 ;
                        map_y.at<float>(j,i) = 2*( j - target.rows*0.25 ) + 0.5 ;
                    } else {
                        map_x.at<float>(j,i) = 0 ;
                        map_y.at<float>(j,i) = 0 ;
                    }
                    break;
                case 1:
                    map_x.at<float>(j,i) = i ;
                    map_y.at<float>(j,i) = target.rows - j ;
                    break;
                case 2:
                    map_x.at<float>(j,i) = target.cols - i ;
                    map_y.at<float>(j,i) = j ;
                    break;
                default:
//                case 3:
                    map_x.at<float>(j,i) = target.cols - i ;
                    map_y.at<float>(j,i) = target.rows - j ;
                    break;
            }
        }
    }
    remap( target, result, map_x, map_y, CV_INTER_LINEAR, cv::BORDER_CONSTANT, cv::Scalar(0,0, 0) );
    return MatToUIImage(result);
}

+ (UIImage *) erosionWithImage:(UIImage *) image {
    int erosion_elem = 0;
    int erosion_size = 0;
    int const max_elem = 2;
    int const max_kernel_size = 21;
    
    cv::Mat target;
    UIImageToMat(image, target);
    
    cv::Mat result;
    
    /// 创建腐蚀 Trackbar
    cvCreateTrackbar("trackBar1", "erosion", &erosion_elem, max_elem);
    cvCreateTrackbar("trackBar1", "erosion", &erosion_size, max_kernel_size);
    
    int erosion_type;
    if( erosion_elem == 0 ){ erosion_type = cv::MORPH_RECT; }
    else if( erosion_elem == 1 ){ erosion_type = cv::MORPH_CROSS; }
    else if( erosion_elem == 2) { erosion_type = cv::MORPH_ELLIPSE; }
    
    cv::Mat element = getStructuringElement( erosion_type,
                                            cv::Size( 2*erosion_size + 1, 2*erosion_size+1 ),
                                            cv::Point( erosion_size, erosion_size ) );
    
    /// 腐蚀操作
    erode( target, result, element );
    return MatToUIImage(result);
}

/**
 *  卡通效果
 */
+ (UIImage *) cartoonWithImage:(UIImage *) image {
    
    cv::Mat Frame;
    
    UIImageToMat(image, Frame);
    cv::cvtColor(Frame, Frame, CV_RGBA2RGB, 3);
    
    cv::Mat grayImage;
    cv::cvtColor(Frame, grayImage, CV_BGR2GRAY);
    
    // 设置中值滤波器参数
    cv::medianBlur(grayImage, grayImage, 5);
    
    // Laplacian边缘检测
    cv::Mat edge; // 用于存放边缘检测输出结果
    cv::Laplacian(grayImage, edge, CV_8U, 5);
    
    // 对边缘检测结果进行二值化
    cv::Mat Binaryzation; // 用于存放二值化输出结果
    cv::threshold(edge, Binaryzation, 80, 255, cv::THRESH_BINARY_INV);
    
    
    
    cv::Size size = Frame.size();
    cv::Size reduceSize;
    reduceSize.width = size.width /2;
    reduceSize.height = size.height /2;
    cv::Mat reduceImage = cv::Mat(reduceSize, CV_8UC3);
    
    cv::resize(Frame, reduceImage, reduceSize);
    
    // 双边滤波器实现过程
    cv::Mat tmp = cv::Mat(reduceSize, CV_8UC3);
    int repetitions =5;
    for (int i=0 ; i < repetitions; i++)
    {
        int kernelSize =9;
        double sigmaColor =9;
        double sigmaSpace =7;
        cv::bilateralFilter(reduceImage, tmp, kernelSize, sigmaColor, sigmaSpace);
        cv::bilateralFilter(tmp, reduceImage, kernelSize, sigmaColor, sigmaSpace);
    }
    
    // 由于图像是缩小后的图像，需要恢复
    cv::Mat magnifyImage;
    cv::resize(reduceImage, magnifyImage, size);
    
    cv::Mat dst;
    dst.setTo(0);
    magnifyImage.copyTo(dst, Binaryzation);
    
    return MatToUIImage(dst);
}
@end
