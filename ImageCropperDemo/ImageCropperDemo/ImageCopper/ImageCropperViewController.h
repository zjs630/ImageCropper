//
//  ImageCropperViewController.h
//  eMeiPu
//
//  Created by 张京顺 on 14-3-12.
//  Copyright (c) 2014年 天天飞度. All rights reserved.
//


@protocol ImageCropperDelegate;

@interface ImageCropperViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *myImage;
@property (nonatomic, assign) id <ImageCropperDelegate> delegate;
@property (nonatomic, assign) BOOL isHiddenStyleSelect;//隐藏样式选择

@end


@protocol ImageCropperDelegate <NSObject>
- (void)imageCropper:(ImageCropperViewController *)cropper didFinishCroppingWithImage:(UIImage *)image;
- (void)imageCropperDidCancel:(ImageCropperViewController *)cropper;
@end
