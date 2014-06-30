//
//  ImageCropperFooterView.h
//  eMeiPu
//
//  Created by 张京顺 on 14-4-21.
//  Copyright (c) 2014年 天天飞度. All rights reserved.
//

#import <UIKit/UIKit.h>

//高度
#define FOOTVIEW_HEIGHT 73


@protocol CropperFooterViewDelegate <NSObject>

- (void)backBtnPressed;
- (void)doneBtnPressed;
- (void)stylePressed:(BOOL)isSquare;

@end

@interface ImageCropperFooterView : UIView

@property (nonatomic,assign) id<CropperFooterViewDelegate> delegate;

- (void)hiddenSelectStyle;
- (void)changeToRectangle;
- (void)changeToSquare;

@end
