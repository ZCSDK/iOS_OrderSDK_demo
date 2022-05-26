//
//  SobotOrderKitInfo.h
//  SobotOrderSDK
//
//  Created by zhangxy on 2022/3/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SobotKitConfig : NSObject


/// 暂未使用
@property(nonatomic,strong) UIColor *viewBackgroundColor;

// 登录失败时，是否显示弹退出登录弹窗
@property(nonatomic,assign)BOOL isShowExitAlterView;

@end

NS_ASSUME_NONNULL_END
