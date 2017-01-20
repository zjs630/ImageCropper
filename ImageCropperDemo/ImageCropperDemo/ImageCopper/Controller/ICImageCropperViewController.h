//
//  ICImageCropperViewController.h
//  ImageCropperDemo
//
//  Created by ZhangJingshun on 2017/1/19.
//  Copyright © 2017年 天天飞度. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageCropperDelegate;

@interface ICImageCropperViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *myImage;
@property (nonatomic, assign) id<ImageCropperDelegate> delegate;
@property (nonatomic, assign) BOOL isHiddenStyleSelect;//隐藏样式选择，默认用长方形剪切。

@end



@protocol ImageCropperDelegate <NSObject>
- (void)imageCropper:(UIViewController *)cropper didFinishCroppingWithImage:(UIImage *)image;
- (void)imageCropperDidCancel:(UIViewController *)cropper;
@end
