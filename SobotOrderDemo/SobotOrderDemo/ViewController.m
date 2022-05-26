//
//  ViewController.m
//  SobotOrderSDKDemo
//
//  Created by zhangxy on 2022/3/18.
//

#import "ViewController.h"
#import <SobotOrderSDK/SobotOrderApi.h>
#import <SobotCommon/SobotCommon.h>
#import "AppDelegate.h"
#import <SobotCommon/SobotBaseController.h>

@interface ViewController ()<UITextFieldDelegate>{
    UITextField *fieldOrderId;
    UITextField *fieldUserName;
    UITextField *fieldUserId;
}

@property(nonatomic,strong) UIScrollView *mainScroll;
@property(nonatomic,strong) UITextField *tf;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.tabBarController.tabBar.hidden = NO;
//    [self.tabBarController setNeedsFocusUpdate];
//    for(UITabBarItem *item in self.tabBarController.tabBar.items){
//        item.title = @"设置";
//    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarLeft:@[] right:@[]];
    [self setNavTitle:@"设置"];
    
    _mainScroll = [[UIScrollView alloc] init];
    [_mainScroll setFrame:self.view.bounds];
    _mainScroll.autoresizesSubviews = YES;
    _mainScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_mainScroll];
    
    // Do any additional setup after loading the view.
    [SobotOrderApi getOrderSDKVersion];
//    [self createButton:0 title:@"启动layout测试页面"];
    UIButton *btn = [self createButton:1 title:@"启动工单页面" y:108];
    CGFloat y = CGRectGetMaxY(btn.frame);
//    btn = [self createButton:2 title:@"调用登录接口" y:y+20];
//    y = CGRectGetMaxY(btn.frame);
    fieldOrderId = [self createTextField:11 holder:@"请输入工单id" y:y+30];
    btn = [self createButton:3 title:@"打开指定工单" y:CGRectGetMaxY(fieldOrderId.frame)+10];
    y = CGRectGetMaxY(btn.frame);
    fieldUserId = [self createTextField:11 holder:@"请输入UserId" y:y+30];
    fieldUserName = [self createTextField:11 holder:@"请输入用户昵称" y:CGRectGetMaxY(fieldUserId.frame)+10];
    btn = [self createButton:4 title:@"创建工单" y:CGRectGetMaxY(fieldUserName.frame)+10];
    y = CGRectGetMaxY(btn.frame);
    btn = [self createButton:5 title:@"退出登录" y:y+20];
    
    [_mainScroll setContentSize:CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(btn.frame))];
    
    // 注册键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)click:(UIButton *) btn{
    if(btn.tag == 0){
//        [SobotOrderApi openTestVC:self];
    }
    NSString *loginAccount = [SobotUserDefaults objectForKey:@"Sobot_LoginAccout"];
    NSString *password = [SobotUserDefaults objectForKey:@"Sobot_Password"];
//    NSString *token = [SobotUserDefaults objectForKey:@"Sobot_Token"];
    if(btn.tag == 1){
        [SobotOrderApi startWithAcount:loginAccount password:password viewController:self result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
            if(code == 1){
                ((UIViewController *)obj).hidesBottomBarWhenPushed = YES;
            }
        }];
        
    }
    if(btn.tag == 2){
        [SobotOrderApi loginUser:loginAccount password:password result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {

        }];
    }
    if(btn.tag == 3){
        if(fieldOrderId.text.length == 0){
            [SobotProgressHUD showInfoWithStatus:@"工单id不能为空"];
            return;
        }
        [SobotOrderApi startOrderDetail:self orderId:fieldOrderId.text result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
            
        }];
    }
    if (btn.tag == 4) {
        NSDictionary *params = nil;
        if(fieldUserName.text.length > 0 && fieldUserId.text.length > 0){
            params = @{@"uname":sobotConvertToString(fieldUserName.text),@"userId":sobotConvertToString(fieldUserId.text)};
        }
        if(fieldOrderId.text == 0){
            return;
        }
        [SobotOrderApi startCreateOrder:self params:params result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
            
        }];
    }
    if (btn.tag == 5) {
        [SobotOrderApi outSobotUser:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
            if(code == 1){
                [((AppDelegate *)[UIApplication sharedApplication].delegate) switchRootViewController];
            }
        }];
    }
}

-(UIButton *) createButton:(int )tag title:(NSString *) title y:(CGFloat ) y{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:0];
    btn.tag = tag;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(20, y, self.view.frame.size.width - 40, 44)];
    btn.autoresizesSubviews = YES;
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [btn setTitleColor:UIColor.blueColor forState:0];
    [btn setBackgroundColor:UIColorFromModeColor(SobotColorBgLine)];
    [_mainScroll addSubview:btn];
    return btn;
}

-(UITextField *) createTextField:(int )tag holder:(NSString *) holder y:(CGFloat ) y{
    UITextField *btn = [[UITextField alloc] init];
    [btn setPlaceholder:holder];
    [btn setTextAlignment:NSTextAlignmentLeft];
    [btn setBorderStyle:UITextBorderStyleLine];
    btn.tag = tag;
    [btn setFrame:CGRectMake(20, y, self.view.frame.size.width - 40, 44)];
    btn.autoresizesSubviews = YES;
    btn.returnKeyType = UIReturnKeyDone;
    btn.delegate = self;
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [btn setTextColor:UIColor.darkTextColor];
    
    [_mainScroll addSubview:btn];
    return btn;
}
#pragma mark - textfield 代理事件
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.tf = nil;
    return YES;
}

-(void)textFieldDidChangeBegin:(UITextField *) textField{
    self.tf = textField;
}


- (void)keyboardWillShow:(NSNotification *)notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView setAnimationDelegate:self];
    {
     //设置偏移量
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        CGRect rect=[self.tf convertRect: self.tf.bounds toView:window];
        CGFloat scrH = window.bounds.size.height;
        if ((scrH - keyboardHeight)< (rect.size.height + rect.origin.y)) {
            [self.mainScroll setContentOffset:CGPointMake(0, ((rect.size.height + rect.origin.y) - (scrH - keyboardHeight))) animated:YES];
        }
    }
    [UIView commitAnimations];
}

//键盘隐藏
- (void)keyboardWillHide:(NSNotification *)notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView commitAnimations];
    [UIView animateWithDuration:0.25 animations:^{
        [self.mainScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
}
@end

