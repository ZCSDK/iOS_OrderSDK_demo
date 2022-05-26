//
//  SobotImagePickerTools.h
//  SobotOnline
//
//  Created by zhangxy on 2020/8/11.
//  Copyright © 2020 sobot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SoobtImagePickerFileType) {
    SoobtImagePickerFileTypeImage = 0,
    SoobtImagePickerFileTypeVideo = 1
};

typedef NS_ENUM(NSInteger,SoobtImagePickerType) {
    SoobtImagePickerPicture = 0, // 相册
    SoobtImagePickerCamera  = 1  // 相机
};


/**
 *  DidFinishPickingMediaBlock
 */
typedef void(^DidFinishPickingMediaBlock)(NSString  * _Nullable filePath , SoobtImagePickerFileType type, NSDictionary * _Nullable duration);


NS_ASSUME_NONNULL_BEGIN

@interface SobotImagePickerTools : NSObject

+(SobotImagePickerTools *) shareImagePickerTools;


/**
 *  根据类型获取图片
 *  @param type  2，来源照相机，1来源相册
 *  @param by_controller  启动页面的vc
 *  @param finshBlock    处理结果
 *
 */
-(void)getPhotoByType:(SoobtImagePickerType) type onlyPhoto:(BOOL) onlyPicture  byUIImagePickerController:(UIViewController *)by_controller block:(nonnull DidFinishPickingMediaBlock)finshBlock;

@end

NS_ASSUME_NONNULL_END
