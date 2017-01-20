//
//  ICViewController.m
//  ImageCropperDemo
//
//  Created by 张京顺 on 14-6-27.
//  Copyright (c) 2014年 天天飞度. All rights reserved.
//

#import "ICViewController.h"
#import "ICImageCropperViewController.h"

@interface ICViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,ImageCropperDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopImageHeightConstraint;

@end

@implementation ICViewController


- (IBAction)addImageBtnPressed:(UIButton *)sender {
    UIActionSheet *startActionSheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        startActionSheet=[[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    }else{
        startActionSheet=[[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", nil];
        
    }
    startActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [startActionSheet showInView:self.view];

}

#pragma mark - 修改头像

-(void)showCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        NSLog(@"拍照功能不可用");
    }
}

-(void)showPhotoLibrary
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (buttonIndex == 1) {
            [self showPhotoLibrary];
        }else if (buttonIndex == 0) {
            [self showCamera];
        }
    }else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        if (buttonIndex==0) {
            [self showPhotoLibrary];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    ICImageCropperViewController *cropper = [[ICImageCropperViewController alloc] initWithNibName:@"ICImageCropperViewController" bundle:nil];
    cropper.myImage = image;
    //cropper.isHiddenStyleSelect = YES; //是否取消样式裁剪选择框
    [cropper setDelegate:self];
    [picker.navigationBar setHidden:YES];
    
    [picker pushViewController:cropper animated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - ImageCropperDelegate
- (void)imageCropper:(UIViewController *)cropper didFinishCroppingWithImage:(UIImage *)image{
    
    self.topImageView.image = image;
    CGSize size = image.size;
    if (size.width>size.height) {
        self.shopImageHeightConstraint.constant = 160;
    }else{
        self.shopImageHeightConstraint.constant = 320;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropperDidCancel:(UIViewController *)cropper{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
