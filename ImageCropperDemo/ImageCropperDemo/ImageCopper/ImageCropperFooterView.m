//
//  ImageCropperFooterView.m
//  eMeiPu
//
//  Created by 张京顺 on 14-4-21.
//  Copyright (c) 2014年 天天飞度. All rights reserved.
//

#if !defined (HEXCOLOR)
#   define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
#endif

#import "ImageCropperFooterView.h"

@interface ImageCropperFooterView ()


@property (nonatomic,strong) UIButton *rectangleBtn;
@property (nonatomic,strong) UIButton *squareBtn;

@end


@implementation ImageCropperFooterView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = HEXCOLOR(0x2e2e2e99);

        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(10, 0, FOOTVIEW_HEIGHT, FOOTVIEW_HEIGHT);
        [backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"press_cha"] forState:UIControlStateHighlighted];
        [self addSubview:backBtn];
        
        _rectangleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rectangleBtn.frame = CGRectMake(110, 0, FOOTVIEW_HEIGHT, FOOTVIEW_HEIGHT);
        [_rectangleBtn addTarget:self action:@selector(stylePressed:) forControlEvents:UIControlEventTouchUpInside];
        [_rectangleBtn setImage:[UIImage imageNamed:@"changkuang"] forState:UIControlStateNormal];
        [_rectangleBtn setImage:[UIImage imageNamed:@"press_changkuang"] forState:UIControlStateHighlighted];
        _rectangleBtn.tag = 1;
        [self addSubview:_rectangleBtn];
        
        _squareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _squareBtn.frame = CGRectMake(180, 0, FOOTVIEW_HEIGHT, FOOTVIEW_HEIGHT);
        [_squareBtn addTarget:self action:@selector(stylePressed:) forControlEvents:UIControlEventTouchUpInside];
        [_squareBtn setImage:[UIImage imageNamed:@"fangkuang"] forState:UIControlStateNormal];
        [_squareBtn setImage:[UIImage imageNamed:@"press_fangkuang"] forState:UIControlStateHighlighted];
        _squareBtn.tag = 2;
        [self addSubview:_squareBtn];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(250, 0, FOOTVIEW_HEIGHT, FOOTVIEW_HEIGHT);
        [doneBtn addTarget:self action:@selector(doneBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [doneBtn setImage:[UIImage imageNamed:@"dui"] forState:UIControlStateNormal];
        [doneBtn setImage:[UIImage imageNamed:@"press_dui"] forState:UIControlStateHighlighted];
        [self addSubview:doneBtn];
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = HEXCOLOR(0x2e2e2ecc);
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, FOOTVIEW_HEIGHT-8, FOOTVIEW_HEIGHT);
    [backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"press_cha"] forState:UIControlStateHighlighted];
    [self addSubview:backBtn];
    
    _rectangleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rectangleBtn.frame = CGRectMake(73+9, 0, FOOTVIEW_HEIGHT, FOOTVIEW_HEIGHT);
    [_rectangleBtn addTarget:self action:@selector(stylePressed:) forControlEvents:UIControlEventTouchUpInside];
    _rectangleBtn.tag = 1;
    [self addSubview:_rectangleBtn];
    
    _squareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _squareBtn.frame = CGRectMake(73+9+73+9, 0, FOOTVIEW_HEIGHT, FOOTVIEW_HEIGHT);
    [_squareBtn addTarget:self action:@selector(stylePressed:) forControlEvents:UIControlEventTouchUpInside];
    _squareBtn.tag = 2;
    [self addSubview:_squareBtn];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(73+9+73+9+73+9, 0, FOOTVIEW_HEIGHT, FOOTVIEW_HEIGHT);
    [doneBtn addTarget:self action:@selector(doneBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setImage:[UIImage imageNamed:@"dui"] forState:UIControlStateNormal];
    [doneBtn setImage:[UIImage imageNamed:@"press_dui"] forState:UIControlStateHighlighted];
    [self addSubview:doneBtn];

}

- (void)backBtnPressed
{
    [_delegate backBtnPressed];
}

- (void)doneBtnPressed
{
    [_delegate doneBtnPressed];
}

- (void)hiddenSelectStyle
{
    _rectangleBtn.hidden = YES;
    _squareBtn.hidden = YES;
}

#pragma mark - 样式

//变成长方形
- (void)changeToRectangle
{
    [_rectangleBtn setImage:[UIImage imageNamed:@"press_changkuang"] forState:UIControlStateNormal];
    [_rectangleBtn setImage:[UIImage imageNamed:@"changkuang"] forState:UIControlStateHighlighted];
    [_squareBtn setImage:[UIImage imageNamed:@"fangkuang"] forState:UIControlStateNormal];
    [_squareBtn setImage:[UIImage imageNamed:@"press_fangkuang"] forState:UIControlStateHighlighted];
}

//变成正方形
- (void)changeToSquare
{
    [_rectangleBtn setImage:[UIImage imageNamed:@"changkuang"] forState:UIControlStateNormal];
    [_rectangleBtn setImage:[UIImage imageNamed:@"press_changkuang"] forState:UIControlStateHighlighted];
    [_squareBtn setImage:[UIImage imageNamed:@"press_fangkuang"] forState:UIControlStateNormal];
    [_squareBtn setImage:[UIImage imageNamed:@"fangkuang"] forState:UIControlStateHighlighted];
}

- (void)stylePressed:(UIButton *)sender
{
    int tag = sender.tag;
    if (tag == 1) {//长方形
        [_delegate stylePressed:NO];
        [self changeToRectangle];
    }
    else{
        [_delegate stylePressed:YES];
        [self changeToSquare];

    }
    
}

@end
