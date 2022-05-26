//
//  SobotBaseController.h
//  SobotOnline
//
//  Created by zhangxy on 2020/8/5.
//  Copyright © 2020 sobot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SobotUITools.h"
#import "SobotCommonDefine.h"
#import "SobotFontColor.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SobotButtonClick) {
    SobotButtonClickBack = 0,
    SobotButtonClickBackChat,
    SobotButtonClickClose,
    SobotButtonClickMenu,
    SobotButtonClickRight,
    SobotButtonClickItem1,
    SobotButtonClickItem2,
    SobotButtonClickItem3,
    SobotButtonClickTransfer,
    SobotButtonClickFavoriter,
    SobotButtonClickBlock,
    SobotButtonClickEdit, // 新建工单
    SobotButtonClickSearch,// 搜索工单
    SobotButtonClickCommit,// 提交
    SobotButtonClickMore,// 点击更多
    SobotButtonClickStart,// 标记
    SobotButtonClickSort,// 排序
    SobotButtonClickDelImg,//删除图片
    SobotButtonClickReply,// 回复工单
    SobotButtonClickActivate,//激活工单
};

@interface SobotBaseController : UIViewController

/**
 *  顶部的View
 */
@property(nonatomic,strong) UIView      * topView;

/**
 *  关闭按钮（返回）
 */
@property(nonatomic,strong) UIButton    * backButton;

/**
  更多按钮，SobotButtonClickRight
 */
@property(nonatomic,strong) UIButton    * moreButton;

/**
 *  标题
 */
@property(nonatomic,strong) UILabel    * titleLabel;

@property(nonatomic,strong) NSString *backTitle;

/**
 *
 *  导航条底部线条
 *
 **/
@property (nonatomic,strong) UIView * bottomLine;


@property (nonatomic,assign) CGFloat contentY;
@property (nonatomic,assign) CGFloat contentHeight;
@property (nonatomic,assign) BOOL isAppear;


-(void)goBack;

-(void)buttonClick:(UIButton *) sender;

// 打开新页面
-(void)autoOpenNewVC:(UIViewController *)controller;
-(void)openWithPresent:(UIViewController *)controller;
-(void)openNav:(UIViewController *)controller;
-(void)openWithPresent:(UIViewController *)controller sound:(NSString *__nullable)soundName animated:(BOOL) anmated;
-(void)openNav:(UIViewController *)controller sound:(NSString *__nullable)soundName;



// key=@(tag) value = @{title,img,imgsel}
@property(nonatomic,strong)NSDictionary *navItemsSource;
// 创建导航头
-(void)createVCTitleView;
-(void)createCustomTitleView;
-(void)setNavigationBarLeft:(NSArray *__nullable)leftTags right:(NSArray *__nullable)rightTags;
-(void)setNavTitle:(NSString *) title;
-(void)setTopBackgroudColor:(UIColor *) color;
-(void)createTitleViewWithLeft:(NSArray *__nullable)leftTags right:(NSArray *__nullable)rightTags;

// 获取nav上的button
-(UIButton *)getNavButtonWithTag:(NSInteger )tag;

// 获取页面内容的起始坐标
-(CGFloat )getVCContentY;



-(void)createPlaceHolderView:(UIView *) superView title:(NSString *) title desc:(NSString *__nullable )message image:(UIImage *__nullable )  tipImage block:(void(^__nullable)(UIButton *_Nonnull btn,NSInteger tag))  refreshClick;
- (void)removePlaceholderView;

@end

NS_ASSUME_NONNULL_END
