//
//  ImageCropperFooterView.m
//  eMeiPu
//
//  Created by 张京顺 on 14-4-21.
//  Copyright (c) 2014年 天天飞度. All rights reserved.
//

#if !defined (HEXCOLOR)
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
#endif

#import "ImageCropperFooterView.h"

@interface ImageCropperFooterView ()

@property (nonatomic,weak) IBOutlet UIButton *backBtn;
@property (nonatomic,weak) IBOutlet UIButton *rectangleBtn;
@property (nonatomic,weak) IBOutlet UIButton *squareBtn;
@property (nonatomic,weak) IBOutlet UIButton *doneBtn;

@end


@implementation ImageCropperFooterView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = HEXCOLOR(0x2e2e2ecc);
}

/**
 点击❌按钮
 */
- (IBAction)backBtnPressed{
    [_delegate backBtnPressed];
}

/**
 点击✔️按钮
 */
- (IBAction)doneBtnPressed{
    [_delegate doneBtnPressed];
}

/**
 取消样式选择，隐藏矩形和正方形裁剪框，
 */
- (void)hiddenSelectStyle{
    _rectangleBtn.hidden = YES;
    _squareBtn.hidden = YES;
}

#pragma mark - 样式

/**
 变成长方形，切换按钮选中状态
 */
- (void)changeToRectangle{
    [_rectangleBtn setImage:[UIImage imageNamed:@"changkuang_press"] forState:UIControlStateNormal];
    [_rectangleBtn setImage:[UIImage imageNamed:@"changkuang"] forState:UIControlStateHighlighted];
    [_squareBtn setImage:[UIImage imageNamed:@"fangkuang"] forState:UIControlStateNormal];
    [_squareBtn setImage:[UIImage imageNamed:@"fangkuang_press"] forState:UIControlStateHighlighted];
}

/**
 变成正方形，切换按钮选中状态
 */
- (void)changeToSquare{
    [_rectangleBtn setImage:[UIImage imageNamed:@"changkuang"] forState:UIControlStateNormal];
    [_rectangleBtn setImage:[UIImage imageNamed:@"changkuang_press"] forState:UIControlStateHighlighted];
    [_squareBtn setImage:[UIImage imageNamed:@"fangkuang_press"] forState:UIControlStateNormal];
    [_squareBtn setImage:[UIImage imageNamed:@"fangkuang"] forState:UIControlStateHighlighted];
}

/**
 点击长方形或者正方形，然后切换样式
 */
- (IBAction)stylePressed:(UIButton *)sender{
    NSInteger tag = sender.tag;
    if (tag == 1) {//长方形
        [_delegate stylePressed:NO];
        [self changeToRectangle];
    }else{
        [_delegate stylePressed:YES];
        [self changeToSquare];
    }
}

@end
