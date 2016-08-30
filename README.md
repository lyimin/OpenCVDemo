# OpenCVDemo
Use OpenCV on iOS
最近在学习OpenCV的imgproc模块(图片处理)。顺便写了几个Demo。用法很简单

## OpenCV的安装


- 使用```CocoaPods```的话```pod 'OpenCV'```就可以了
- 到官网下载![Frameworks](http://opencv.org/),把frameworks直接拖到项目中就可以了

## Demo案例

- 均值模糊
  
```[UIImage blurWithImage:_normalView.image]```


<img src="https://github.com/lyimin/OpenCVDemo/blob/master/openCVDemo/openCVDemo/resouce/1.PNG" width="30%" height="30%" />


- 高斯模糊
  
```[UIImage GaussianBlurWithImage:_normalView.image]```


<img src="https://github.com/lyimin/OpenCVDemo/blob/master/openCVDemo/openCVDemo/resouce/2.PNG" width="30%" height="30%" />


- 双边平滑(美颜效果)
  
```[UIImage bilateralFilterWithImage:_normalView.image]```


<img src="https://github.com/lyimin/OpenCVDemo/blob/master/openCVDemo/openCVDemo/resouce/3.PNG" width="30%" height="30%" />


- 实现自己的线性滤波
  
```[UIImage filterWithImgae:_normalView.image]```


<img src="https://github.com/lyimin/OpenCVDemo/blob/master/openCVDemo/openCVDemo/resouce/4.PNG" width="30%" height="30%" />


- Sobel 导数
  
```[UIImage sobelWithImage:_normalView.image]```


<img src="https://github.com/lyimin/OpenCVDemo/blob/master/openCVDemo/openCVDemo/resouce/5.PNG" width="30%" height="30%" />


- Laplacian算子
  
```[UIImage laplacianWithImage:_normalView.image]```


<img src="https://github.com/lyimin/OpenCVDemo/blob/master/openCVDemo/openCVDemo/resouce/6.PNG" width="30%" height="30%" />


- Remapping重映射
  
```[UIImage remappingWithImage:_normalView.image]```


<img src="https://github.com/lyimin/OpenCVDemo/blob/master/openCVDemo/openCVDemo/resouce/7.PNG" width="30%" height="30%" />


- 卡通
  
```[UIImage cartoonWithImage:_normalView.image]```


<img src="https://github.com/lyimin/OpenCVDemo/blob/master/openCVDemo/openCVDemo/resouce/8.PNG" width="30%" height="30%" />


