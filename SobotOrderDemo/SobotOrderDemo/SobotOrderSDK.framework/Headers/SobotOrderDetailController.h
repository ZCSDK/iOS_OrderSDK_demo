//
//  SobotOrderDetailController.h
//  SobotOrderSDK
//
//  Created by lizh on 2022/3/31.
//

#import <SobotCommon/SobotCommon.h>
#import "SobotOrderInfoEntity.h"
typedef void(^LoadDataBlock)();
NS_ASSUME_NONNULL_BEGIN

@interface SobotOrderDetailController : SobotBaseController
// 1，新增，2搜索 3列表 4.点击推送都详情页 5.来只用户收索页面 6设置页面工单通知页面  7.24小时工单
@property (nonatomic, assign) int fromPage;
@property (nonatomic ,strong) NSMutableArray *listArray;
@property (nonatomic ,assign) NSInteger indexRow;
@property (nonatomic, assign) BOOL isClear;
@property (nonatomic, strong) SobotOrderDetailEntity *model;
@property (nonatomic,copy) NSString * ticketId; // 当前从设置页面跳转到 工单详情页面时使用 无工单model
@property (nonatomic,copy) LoadDataBlock loadDatablock;
@end

NS_ASSUME_NONNULL_END
