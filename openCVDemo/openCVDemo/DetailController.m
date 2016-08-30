//
//  DetailController.m
//  openCVDemo
//
//  Created by 梁亦明 on 16/8/28.
//  Copyright © 2016年 xiaoming.com. All rights reserved.
//

#import "DetailController.h"
#import "UIImage+OpenCV.h"

@interface DetailController ()
@property (nonatomic,strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIImageView *normalView;
@property (weak, nonatomic) IBOutlet UISlider *slideView;
@property (weak, nonatomic) IBOutlet UIImageView *resultView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic,assign) int lastValue;
@end

@implementation DetailController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    __block UIImage *resalutImage;
    [self.activityView startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        switch (_row) {
                // 均值模糊
            case 0:
                resalutImage = [UIImage blurWithImage:_normalView.image];
                break;
                
                // 高斯模糊
            case 1:
                resalutImage = [UIImage GaussianBlurWithImage:_normalView.image];
                break;
            
                // 双边平滑
            case 2 :
                resalutImage = [UIImage bilateralFilterWithImage: _normalView.image];
                break;
                
                // 实现自己的线性滤波
            case 3:
                resalutImage = [UIImage filterWithImgae:_normalView.image ind:_lastValue];
                break;
                
                // Sobel 导数
            case 4:
                resalutImage = [UIImage sobelWithImage:_normalView.image];
                break;
                
                // Laplacian算子
            case 5:
                resalutImage = [UIImage laplacianWithImage:_normalView.image];
                break;
                
            case 6:
                // Remapping重映射
                resalutImage = [UIImage remappingWithImage:_normalView.image];
                break;
                
                // 卡通
            case 7:
                resalutImage = [UIImage cartoonWithImage:_normalView.image];
                break;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.resultView.image = resalutImage;
            [self.activityView stopAnimating];
            [self.activityView removeFromSuperview];
            
            if (_row == 3) {
                self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(valueDidChange) userInfo:nil repeats:YES];
            }
        });
    });
    
    
    
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    int value = (int)sender.value;
    if (self.lastValue == value) return;
    self.lastValue = value;
    self.resultView.image = [UIImage filterWithImgae:_normalView.image ind:sender.value];
}

- (void) valueDidChange {
    self.resultView.image = [UIImage filterWithImgae:_normalView.image ind:_lastValue];
    _lastValue++;
    NSLog(@"");
}


- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}
@end
