//
//  ImageCropperMaskView.m
//  eMeiPu
//
//  Created by 张京顺 on 14-4-8.
//  Copyright (c) 2014年 天天飞度. All rights reserved.
//

#import "ImageCropperMaskView.h"
#import "ImageCropperFooterView.h"

#pragma KISnipImageMaskView
#define kMaskViewBorderWidth 2.0f

@implementation ImageCropperMaskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCropRect:(CGRect)rect
{
    _cropRect = rect;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0.1, 0.1, 0.1, 0.6);
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-FOOTVIEW_HEIGHT);
    CGContextFillRect(ctx, fillRect);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth);
    
    CGContextClearRect(ctx, CGRectMake(_cropRect.origin.x+1, _cropRect.origin.y, _cropRect.size.width-2, _cropRect.size.height));
}


@end
