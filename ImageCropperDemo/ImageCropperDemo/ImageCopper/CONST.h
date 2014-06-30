//
//  CONST.h
//  ImageCropperDemo
//
//  Created by 张京顺 on 14-6-27.
//  Copyright (c) 2014年 天天飞度. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !defined (HEXCOLOR)
#   define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
#endif
