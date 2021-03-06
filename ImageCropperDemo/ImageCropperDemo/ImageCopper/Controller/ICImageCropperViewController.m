//
//  ICImageCropperViewController.m
//  ImageCropperDemo
//
//  Created by ZhangJingshun on 2017/1/19.
//  Copyright © 2017年 天天飞度. All rights reserved.
//

#import "ICImageCropperViewController.h"

#import "ImageCropperMaskView.h"
#import "ImageCropperFooterView.h"
#import "MBProgressHUD.h"

@interface ICImageCropperViewController ()<UIGestureRecognizerDelegate,CropperFooterViewDelegate>

@property (nonatomic,strong) UIView *borderView;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,weak) IBOutlet UIScrollView *myScrollView;
@property (nonatomic,strong) ImageCropperMaskView *maskView;
@property (nonatomic) int cropper_width;    //裁剪宽度
@property (nonatomic) int cropper_height;   //裁剪高度
@property (nonatomic,weak) IBOutlet ImageCropperFooterView *footerView;

@property (nonatomic,assign) BOOL currentScaleIsHeight; //当前缩放是否是按高度

@end

@implementation ICImageCropperViewController

- (void)setMyImage:(UIImage *)image{
    _myImage = image;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *imagefixed = [_myImage fixOrientation];//添加UIImage+fixOrientation.h引用
        while (_imgView == nil) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            _imgView.image = imagefixed;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (ImageCropperMaskView *)maskView {
    if (_maskView == nil) {
        _maskView = [[ImageCropperMaskView alloc] init];
        [_maskView setBackgroundColor:[UIColor clearColor]];
        [_maskView setUserInteractionEnabled:NO];
        [self.view addSubview:_maskView];
        [self.view bringSubviewToFront:_maskView];
    }
    return _maskView;
}

#pragma mark -

-(void)loadView{
    [super loadView];
    
    //设置滚动视图
    _myScrollView.backgroundColor = [UIColor blackColor];
    _myScrollView.delegate = self;
    _myScrollView.bounces = NO;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.maximumZoomScale = 2.0;
    _myScrollView.bouncesZoom = NO;
    
    _footerView.delegate = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgView.userInteractionEnabled = YES;
    [_myScrollView addSubview:_imgView];
    
    if (_isHiddenStyleSelect) {//如果仅仅是矩形裁剪，隐藏选择类型
        [_footerView hiddenSelectStyle];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _imgView.frame = CGRectMake(0, 0, _myImage.size.width, _myImage.size.height);
    
    [_myScrollView setContentSize:_imgView.bounds.size];
    
    [[self maskView] setFrame:_myScrollView.frame];
    
    _cropper_width = self.view.bounds.size.width;

    float bili = _myImage.size.width/_myImage.size.height;
    if (bili>2) {
        _cropper_height = self.view.bounds.size.width/2;
        [self heightScale];
    }else {
        [self widthScale];
    }
    
    if (_myImage.size.width<=_myImage.size.height) {//宽小于高，正方形裁剪
        [_footerView changeToSquare];
        [self squareStyle];
    }else{
        [_footerView changeToRectangle];
        [self rectangleStyle];
    }
    
    if (self.isHiddenStyleSelect == YES) {//此种情况下是横图
        [self rectangleStyle];
    }
    
    [_myScrollView setContentOffset:CGPointMake((_imgView.frame.size.width -_cropper_width)/2, (_imgView.frame.size.height-_myScrollView.frame.size.height)/2)];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark - 裁剪样式

- (void)heightScale{
    float scale = _cropper_height / _myImage.size.height;
    if (scale>1) {
        [_myScrollView setMaximumZoomScale:scale+scale];
    }
    [_myScrollView setMinimumZoomScale:scale];
    [_myScrollView setZoomScale:scale];
    _currentScaleIsHeight = YES;
}

- (void)widthScale{
    float scale = _myScrollView.frame.size.width / _myImage.size.width;
    if (scale>1) {
        [_myScrollView setMaximumZoomScale:scale+scale];
    }
    [_myScrollView setMinimumZoomScale:scale];
    [_myScrollView setZoomScale:scale];
    _currentScaleIsHeight = NO;
}

- (void)rectangleStyle{
    _cropper_height = self.view.bounds.size.width/2;
    if (_currentScaleIsHeight) {
        float scale = [_myScrollView frame].size.width / _myImage.size.width;
        if (scale>1) {
            [_myScrollView setMaximumZoomScale:scale+scale];
        }
        [_myScrollView setMinimumZoomScale:scale];
        _currentScaleIsHeight = NO;
    }
    
    if (_imgView.frame.size.width<_cropper_width) {
        [self widthScale];
    }
    int h = _myScrollView.frame.size.height;
    CGRect borderRect = CGRectMake(0, (h-_cropper_height)/2, _cropper_width, _cropper_height);
    NSUInteger y3 = borderRect.origin.y+_cropper_height;
    
    UIEdgeInsets _imageInset = UIEdgeInsetsMake(borderRect.origin.y, 0, h-y3, 0);
    [_myScrollView setContentInset:_imageInset];
    
    [self maskView].cropRect = borderRect;
}

- (void)squareStyle{
    _cropper_height = self.view.bounds.size.width;
    
    if (_currentScaleIsHeight == NO && _myImage.size.width > _myImage.size.height) {
        float scale = _cropper_height / _myImage.size.height;
        if (scale>1) {
            [_myScrollView setMaximumZoomScale:scale+scale];
        }
        [_myScrollView setMinimumZoomScale:scale];
        _currentScaleIsHeight = YES;
    }
    
    if (_imgView.frame.size.height<_cropper_height) {
        [self heightScale];
    }
    if (_imgView.frame.size.width<_cropper_width) {
        [self widthScale];
    }
    
    int h = _myScrollView.frame.size.height;
    CGRect borderRect = CGRectMake(0, (h-_cropper_height)/2, _cropper_width, _cropper_height);
    NSUInteger y3 = borderRect.origin.y+_cropper_height;
    
    UIEdgeInsets _imageInset = UIEdgeInsetsMake(borderRect.origin.y, 0, h-y3, 0);
    [_myScrollView setContentInset:_imageInset];
    
    [self maskView].cropRect = borderRect;
}

#pragma mark -

/**
 取消裁剪
 */
- (void)cancelCropping {
    [_delegate imageCropperDidCancel:self];
}

/**
 结束裁剪
 */
- (void)finishCropping {
    float zoomScale = 1.0 / [_myScrollView zoomScale];
    
    CGPoint contentOffset = [_myScrollView contentOffset];
    CGPoint imgViewOffset = self.imgView.frame.origin;
    CGRect rect;
    rect.origin.x = (contentOffset.x-imgViewOffset.x) * zoomScale;
    rect.origin.y = (contentOffset.y-imgViewOffset.y+(_myScrollView.bounds.size.height-_cropper_height)/2) * zoomScale;
    rect.size.width = _cropper_width * zoomScale;
    rect.size.height = _cropper_height * zoomScale;
    
    CGImageRef cr = CGImageCreateWithImageInRect([[_imgView image] CGImage], rect);
    
    UIImage *cropped = [UIImage imageWithCGImage:cr];
    
    CGImageRelease(cr);
    if (cropped) {
        [_delegate imageCropper:self didFinishCroppingWithImage:cropped];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"裁剪失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imgView;
}


#pragma mark - CropperFooterViewDelegate

- (void)backBtnPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneBtnPressed{
    [self finishCropping];
}

- (void)stylePressed:(BOOL)isSquare{
    if (isSquare) {//正方形
        [self squareStyle];
    }else{
        [self rectangleStyle];
    }
}

- (void)dealloc{
    NSLog(@"ImageCropperViewController dealloc!");
}

@end
