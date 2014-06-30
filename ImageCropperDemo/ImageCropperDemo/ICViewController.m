//
//  ICViewController.m
//  ImageCropperDemo
//
//  Created by 张京顺 on 14-6-27.
//  Copyright (c) 2014年 天天飞度. All rights reserved.
//

#import "ICViewController.h"
#import "ImageCropperViewController.h"

@interface ICViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,ImageCropperDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopImageHeightConstraint;

@end

@implementation ICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addImageBtnPressed:(UIButton *)sender {
    UIActionSheet *startActionSheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        startActionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册中选择", nil];
    }else{
        startActionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册中选择", nil];
        
    }
    startActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [startActionSheet showInView:self.view];

}

#pragma mark - 修改头像

-(void)showCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *_imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_imagePickerController animated:YES completion:^{
            ;
        }];
    }
    else{
        NSLog(@"拍照功能不可用");
    }
}

-(void)showPhotoLibrary
{
    UIImagePickerController *_imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:^{
        ;
    }];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (buttonIndex == 1) {
            [self showPhotoLibrary];
        }
        else if (buttonIndex == 0) {
            [self showCamera];
        }
    }else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        if (buttonIndex==0) {
            [self showPhotoLibrary];
        }
        
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ImageCropperViewController *cropper = [mainStoryboard instantiateViewControllerWithIdentifier:@"ImageCropperStoryboardID"];
    cropper.myImage = image;
    //cropper.isHiddenStyleSelect = YES;//是否仅用长方形裁剪
    [cropper setDelegate:self];
    [picker.navigationBar setHidden:YES];
    
    [picker pushViewController:cropper animated:YES];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

#pragma mark - ImageCropperDelegate
- (void)imageCropper:(ImageCropperViewController *)cropper didFinishCroppingWithImage:(UIImage *)image
{
    
    self.topImageView.image = image;
    CGSize size = image.size;
    if (size.width>size.height) {
        self.shopImageHeightConstraint.constant = 160;
    }
    else{
        self.shopImageHeightConstraint.constant = 320;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imageCropperDidCancel:(ImageCropperViewController *)cropper
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
