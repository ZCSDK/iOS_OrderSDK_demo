//
//  SobotOrderHomeController.h
//  SobotOrderSDK
//
//  Created by zhangxy on 2022/3/22.
//

#import <SobotCommon/SobotCommon.h>

NS_ASSUME_NONNULL_BEGIN

@interface SobotOrderHomeController : SobotBaseController

// 登录参数
@property(nonatomic,copy) NSString * email;
@property(nonatomic,copy) NSString * password;
@property(nonatomic,copy) NSString * token;
@property(nonatomic,strong)UIViewController *userVC;// 用户传入的VC
@property(nonatomic,assign)BOOL isFirstPage;// 是否为首页， 首页不在显示返回按钮
@property(nonatomic,assign)BOOL isAddInTab;// 首页是否嵌入到uitabbarviewcorll
@property(nonatomic,assign)CGFloat tabHeight;// tabbar的高度（系统的或者自定义的）
@end

NS_ASSUME_NONNULL_END
