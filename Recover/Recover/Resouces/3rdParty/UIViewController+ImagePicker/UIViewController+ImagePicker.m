//
//  UIViewController+ImagePicker.m
//
//  Created by dd.
//  Copyright (c) 2014年. All rights reserved.
//

#define ActionSheetTag              250

#import "UIViewController+ImagePicker.h"
#import <objc/runtime.h>

@interface UIViewController()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy) ImagePickerBlock imageBlock;

@end

static const void *ImagePickerBlockKey = &ImagePickerBlockKey;

@implementation UIViewController (ImagePicker)

#pragma mark - 存取block

-(void)setImageBlock:(ImagePickerBlock)imageBlock
{
    objc_setAssociatedObject(self, ImagePickerBlockKey, imageBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ImagePickerBlock)imageBlock
{
    return objc_getAssociatedObject(self, ImagePickerBlockKey);
}

#pragma mark -

/**
 *  使用相机或相册获取图片
 *
 *  @param block 参数为获取的图片/图片名称/图片路径
 */
- (void) imageByCameraAndPhotosAlbumWithActionSheetUsingBlock:(ImagePickerBlock)imageBlock
{
    self.imageBlock = imageBlock;
    
    UIActionSheet *as = nil;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        as = [[UIActionSheet alloc] initWithTitle:@"选择"
                                         delegate:self
                                cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                                otherButtonTitles:@"相机",@"从相册选择", nil];
    }
    else {
        
        as = [[UIActionSheet alloc] initWithTitle:@"选择"
                                         delegate:self
                                cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                                otherButtonTitles:@"从相册选择", nil];
    }
    
    as.tag = ActionSheetTag;
    
    [as showInView:self.view];
}

#pragma mark - Action Sheet Delegate

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == ActionSheetTag)
    {
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex)
            {
                case 2:
                    // 取消
                    return;
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    break;
            }
        }
        else
        {
            if (buttonIndex == 0)
            {
                //相册
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            else
            {
                //取消
                return;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        imagePickerController.navigationBar.translucent = NO;
        
        [imagePickerController.navigationBar setBackgroundImage:[CommonIO imageWithColor:Color_System_Tint_Color size:CGSizeMake(mScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - Image Picker Delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSString *imageName = [self imageNameWithCurrentTime];
    
    NSString *imagePath = [self saveImage:image withName:imageName andPath:@"images"];
    
    if (self.imageBlock)
    {
        self.imageBlock(image,imageName,imagePath);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - 保存图片至沙盒

/**
 *  保存图片
 *
 *  @param currentImage 图片数据
 *  @param imageName    图片名称
 *  @param folderName   图片路径 默认在documents目录下
 *
 *  @return 图片完整路径
 */
- (NSString *) saveImage:(UIImage *)currentImage withName:(NSString *)imageName andPath:(NSString *)folderName
{
    NSData *imageData = UIImagePNGRepresentation(currentImage);
    
    // 获取沙盒目录
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    if (folderName)
    {
        documentsPath = [documentsPath stringByAppendingPathComponent:folderName];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:documentsPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }
    
    NSString *imagePath = [documentsPath stringByAppendingPathComponent:imageName];
    
    [imageData writeToFile:imagePath atomically:NO];
    
    return imagePath;
}

/**
 *  根据当前时间生成图片名称
 *
 *  @return 图片名
 */
- (NSString *) imageNameWithCurrentTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss-SS"];

    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSString *randomString = [NSString stringWithFormat:@"%d",arc4random()%1000000];
    
    return [NSString stringWithFormat:@"image-%@-%@.png",dateString,randomString];
}

@end
