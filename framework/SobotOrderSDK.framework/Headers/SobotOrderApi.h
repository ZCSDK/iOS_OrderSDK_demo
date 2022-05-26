//
//  SobotOrderApi.h
//  SobotOrderSDK
//
//  Created by zhangxy on 2022/3/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SobotOrderSDK/SobotOrderClient.h>
#import <SobotOrderSDK/SobotKitConfig.h>

// code == 1成功
typedef void(^SobotResultBlock)(NSInteger code,id _Nullable obj,NSString *_Nullable msg);

NS_ASSUME_NONNULL_BEGIN

@interface SobotOrderApi : NSObject


/// 跳转到调试页面
/// @param vc 启动VC
//+(void)openTestVC:(UIViewController *)vc;

/// 获取工单SDK 版本号
+(NSString *)getOrderSDKVersion;


/// 更改kitConfig配置
/// @param kitConfig  congfig配置
+(void)configKitInfo:(SobotKitConfig *) kitConfig;

/// 初始化配置
/// @param host 域名
/// @param config  SobotCacheEntity 配置类
/// @param kitInfo SobotKitConfig 配置类
/// @param resultBlock 初始化回调 (NSInteger code,id _Nullable obj,NSString *_Nullable msg)；
+(void)initWithHost:(NSString *)host config:(SobotCacheEntity *)config  kitInfo:(SobotKitConfig *)kitInfo result:(SobotResultBlock) resultBlock;

/// 启动SDK 进入工单SDK首页
/// @param account  账号
/// @param loginPwd 密码
/// @param vc 启动VC
/// @param resultBlock 回调结果
+(void)startWithAcount:(NSString *)account password:(NSString *)loginPwd viewController:(UIViewController *)vc result:(SobotResultBlock) resultBlock;

/// 启动SDK 使用token
/// @param token token
/// @param account 账号
/// @param vc 密码
/// @param resultBlock 回调结果
+(void)startWithToken:(NSString *)token loginUser:(NSString *) account viewController:(UIViewController *)vc  result:(SobotResultBlock) resultBlock;

/// 打开工单详情页面
/// @param vc 启动VC
/// @param ticketId 工单ID
/// @param resultBlock 回调结果
+(void)startOrderDetail:(UIViewController *) vc orderId:(NSString *) ticketId  result:(SobotResultBlock) resultBlock;

/// // 直接进入创建工单页面 创建工单，提交后退出
/// @param vc  启动VC
/// @param params 入参  @{@"uname':@"传创建工单的客服昵称",@"userId":@"传创建工单的客服ID"}
/// @param resultBlock 回调结果
+(void)startCreateOrder:(UIViewController *)vc params:(NSDictionary * _Nullable)params result:(SobotResultBlock) resultBlock;

/// 退出SDK
/// @param resultBlock 回调结果
+(void)outSobotUser:(SobotResultBlock) resultBlock;

/// 登录
/// @param account 账号
/// @param loginPwd 密码
/// @param resultBlock 回调结果
+(void)loginUser:(NSString *)account password:(NSString * )loginPwd result:(SobotResultBlock) resultBlock;

/// 登录（使用token）
/// @param account 账号
/// @param loginPwd 密码
/// @param token token
/// @param resultBlock 回调结果
+(void)loginUser:(NSString *)account password:(NSString * )loginPwd  token:(NSString *) token  result:(SobotResultBlock) resultBlock;

/// 设置是否 Debug模式，默认为NO，不显示日志
/// @param isShowDebug  YES or NO
+(void)setShowDebug:(BOOL) isShowDebug;

@end

NS_ASSUME_NONNULL_END
