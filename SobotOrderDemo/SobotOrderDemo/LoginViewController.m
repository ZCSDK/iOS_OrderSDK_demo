//
//  LoginViewController.m
//  SobotOrderSDKDemo
//
//  Created by zhangxy on 2022/5/17.
//

#import "LoginViewController.h"
#import <SobotOrderSDK/SobotOrderApi.h>
#import <SobotCommon/SobotCacheEntity.h>
#import <SobotCommon/SobotCommon.h>

#import "AppDelegate.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    UITextField *fieldHost;
    UITextField *fieldUserName;
    UITextField *fieldPassword;
    UITextField *fieldToken;
}
@property(nonatomic,strong) UIScrollView *mainScroll;
@property(nonatomic,strong) UITextField *tf;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromModeColor(SobotColorBgMain);
//    self.view.backgroundColor = UIColor.whiteColor;
    
    _mainScroll = [[UIScrollView alloc] init];
    [_mainScroll setFrame:self.view.bounds];
    _mainScroll.autoresizesSubviews = YES;
    _mainScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_mainScroll];
    // Do any additional setup after loading the view.
    UILabel *lab = [self createLabel:0 title:@"使用工单组件前请先登录\n用户名/密码 或 用户名/token可输入任意一组" y:108];
    [lab sizeToFit];
    CGFloat y = CGRectGetMaxY(lab.frame);
    
    lab = [self createLabel:0 title:@"请输入域名,不填默认https://www.sobot.com" y:y+20];
    y = CGRectGetMaxY(lab.frame);
    fieldHost  = [self createTextField:1 holder:@"域名" y:y+5];
    y=CGRectGetMaxY(fieldHost.frame);
    
    lab = [self createLabel:0 title:@"请输入账户(邮箱)" y:y+20];
    y = CGRectGetMaxY(lab.frame);
    fieldUserName  = [self createTextField:2 holder:@"登录账户" y:y+5];
    y=CGRectGetMaxY(fieldUserName.frame);
    
    lab = [self createLabel:0 title:@"请输入密码(如果有token可以不填)" y:y+20];
    y = CGRectGetMaxY(lab.frame);
    fieldPassword  = [self createTextField:3 holder:@"密码" y:y+5];
    fieldPassword.secureTextEntry = YES;
    y=CGRectGetMaxY(fieldPassword.frame);
    
    
    lab = [self createLabel:0 title:@"请输入token(有密码时可不填)" y:y+20];
    y = CGRectGetMaxY(lab.frame);
    fieldToken  = [self createTextField:4 holder:@"token" y:y+5];
    y=CGRectGetMaxY(fieldToken.frame);
    
    [self createButton:5 title:@"登录" y:y+20];
    
    [_mainScroll setContentSize:CGSizeMake(self.view.frame.size.width, y+20+44)];
    
    fieldHost.text = [SobotUserDefaults objectForKey:@"Sobot_Host"];
    fieldUserName.text = [SobotUserDefaults objectForKey:@"Sobot_LoginAccout"];
    fieldPassword.text = [SobotUserDefaults objectForKey:@"Sobot_Password"];
    fieldToken.text = [SobotUserDefaults objectForKey:@"Sobot_Token"];
    [SobotUserDefaults setObject:fieldHost.text forKey:@"Sobot_Host"];
    
    // 注册键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)click:(UIButton *) btn{
    if(btn.tag == 5){
        SobotCacheEntity *config = [[SobotCacheEntity alloc] init];
        config.bundleName = @"SobotOrder";
        config.languageTableName = @"SobotLocal";
        config.languagePathInBundle = @"Localizable";
        config.colorTableName = @"SobotColor";
        config.absoluetelanguage = @"zh-Hans";
        SobotKitConfig *kitInfo = [[SobotKitConfig alloc]init];
        kitInfo.isShowExitAlterView = YES;
        [SobotOrderApi initWithHost:fieldHost.text config:config kitInfo:kitInfo result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {

        }];
        [SobotOrderApi setShowDebug:YES];
        
        if(fieldUserName.text.length == 0){
            [SobotProgressHUD showInfoWithStatus:@"请输入登录账户"];
            return;
        }
        
        if(fieldPassword.text.length == 0 && fieldToken.text.length == 0){
            [SobotProgressHUD showInfoWithStatus:@"密码和token至少提供一个"];
            return;
        }
        [SobotUserDefaults setObject:fieldHost.text forKey:@"Sobot_Host"];
        [SobotUserDefaults setObject:fieldUserName.text forKey:@"Sobot_LoginAccout"];
        [SobotUserDefaults setObject:fieldPassword.text forKey:@"Sobot_Password"];
        [SobotUserDefaults setObject:fieldToken.text forKey:@"Sobot_Token"];
        
        [SobotOrderApi loginUser:fieldUserName.text password:fieldPassword.text token:fieldToken.text result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
            if (code == 0 && sobotConvertToString(msg).length > 0) {
                [SobotProgressHUD showInfoWithStatus:sobotConvertToString(msg)];
            }
            [self loginResult:code];
        }];
    }
}


-(void)loginResult:(NSInteger) code{
    if(code == 1){
        [((AppDelegate *)[UIApplication sharedApplication].delegate) switchRootViewController];
    }
}

-(UIButton *) createButton:(int )tag title:(NSString *) title y:(CGFloat) y{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:0];
    btn.tag = tag;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(20, y, self.view.frame.size.width - 40, 44)];
    btn.autoresizesSubviews = YES;
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [btn setTitleColor:UIColor.blueColor forState:0];
    [btn setBackgroundColor:UIColor.lightGrayColor];
    [_mainScroll addSubview:btn];
    return btn;
}

-(UILabel *) createLabel:(int )tag title:(NSString *) title y:(CGFloat )y{
    UILabel *btn = [[UILabel alloc] init];
    [btn setText:title];
    [btn setTextAlignment:NSTextAlignmentLeft];
    btn.numberOfLines = 0;
    btn.tag = tag;
    [btn setFrame:CGRectMake(20, y, self.view.frame.size.width - 40, 44)];
    btn.autoresizesSubviews = YES;
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [btn setTextColor:UIColor.darkTextColor];
    
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
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [btn setTextColor:UIColor.darkTextColor];
    btn.returnKeyType = UIReturnKeyDone;
    btn.delegate = self;
    [_mainScroll addSubview:btn];
    return btn;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.tf = nil;
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tf = textField;
    return YES;
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
            [self.mainScroll setContentOffset:CGPointMake(0,(rect.size.height + rect.origin.y)- (scrH - keyboardHeight)) animated:YES];
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
