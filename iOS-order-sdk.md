# iOS集成文档
相关限制及注意事项  
1、iOS SDK新版支持 iOS9 以上版本，同时支持 iPhone、iPad，支持竖屏和横屏。

2、目前发布xcode版本为XCode 12.3.1,建议使用新版开发

3、iOS目前仅仅支持超链接标签，其他html标签和属性均不识别

4、iOS需要相机、相册权限，否则部分功能无法使用

![图片](https://img.sobot.com/mobile/sdk/images/sdk-order-home-01.png)

智齿客服为企业提供了一整套完善的智能客服解决方案。智齿工单SDK 为其提供所有工单支持，仅需提供使用的账户，就能完成一系列的工单操作。

智齿客服SDK具有以下特性    

* 提供登录-使用-退出完整流程。  
* 分2种登录模块，外部登录同步token和常规用户名、密码登录。  
* 支持工单的查询、操作、新建等基础功能；  


## 1 文档介绍

## 1.1 集成流程示意图
![图片](https://img.sobot.com/mobile/sdk/images/sdk-order-001.png)
## 1.2.文件说明
**SDK包含（SobotOrder.framework、SobotCommon.framework和SobotOrder.bundle）、SobotDemo、和Doc相关说明文档。**

| 文件名   | 说明   |备注|
|:----|:----|:----|
| SobotOrder.framework   | 智齿工单SDK代码库   |  必选  |
| SobotCommon.framework   | 智齿代码基础依赖库   | 必选   |
| SobotOrder.bundle   | SDK资源库，包含图片文件、多语言文件、颜色   | 必选   |
| SobotOrderApi.h   | 该文件提供接入功能  |    |
| SobotKitConfig.h   | 基础UI配置参数类   |    |
| SobotCacheEntity.h   | 基础功能参数类(颜色、语言、显示模式等)   |    |
| SobotOrderHomeController   | 工单入口界面   |    |
| SobotOrderClient.h   | 基础功能   |    |

## 2 集成方式
## 2.1 手动集成

下载链接：[iOS_OrderSDK_1.0.0](https://img.sobot.com/mobile/sdk/iOS_OrderSDK_1.0.0.zip)

解压[iOS_SDK]，添加必要文件SobotOrder.framework、SobotCommon.framework和SobotOrder.bundle到你的工程里。


## 2.2 CocoPods集成
在podfile中加入：

```js  
// 使用最新版本
pod 'SobotOrderSDK'

```

如果搜索不到最新版本，请运行以下命令更新CocoPods仓库   

```js  
pod repo update --verbose
如果无法更新到最新版本，可以删除索引文件，重新尝试
rm ~/Library/Caches/CocoaPods/search_index.json

```

清除pod缓存：

```js
删除代码中的pod 文件夹，
pod cache clean SobotOrderSDK
再重新 pod install
```

## 3 功能说明
### 3.1 域名设置
域名说明：

      * 默认SaaS平台域名为:https://api.sobot.com

      * 如果您是腾讯云服务，请设置为：https://www.soboten.com

      * 如果您是本地化部署，请使用自己的部署的服务域名

示例代码：

```C

	SobotCacheEntity *config = [[SobotCacheEntity alloc] init];
	// 指定bundle名称
    config.bundleName = @"SobotOrder"; 
    // 指定国际化文件在bundle中的路径
    config.languageTableName = @"SobotLocal";     
    // 指定国际化文件名称
    config.languagePathInBundle = @"Localizable"; 
    // 指定颜色在bundle中的文件名称
    config.colorTableName = @"SobotColor";
    // 指定语言
    config.absoluetelanguage = @"zh-Hans";
    [SobotOrderApi initWithHost:@"" config:config kitInfo:kitInfo result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {

    }];


```


### 3.2 初始化 
初始化参数和调用方式：初始化信息SobotCacheEntity设置功能相关属性；初始化方法为本地执行，不会有异步请求，设置后立即生效。

主要调用代码如下：

【注意：启动智齿工单SDK之前，必须调用初始化接口initWithHost，否则将无法启动SDK】

接口：

```js


/// 初始化配置
/// @param host 域名
/// @param config  SobotCacheEntity 配置类
/// @param kitInfo SobotKitConfig 配置类
/// @param resultBlock 初始化回调 (NSInteger code,id _Nullable obj,NSString *_Nullable msg)；
+(void)initWithHost:(NSString *)host config:(SobotCacheEntity *)config  kitInfo:(SobotKitConfig *)kitInfo result:(SobotResultBlock) resultBlock;


```
参数：  

| 参数名   | 类型   | 描述   |
|:----|:----|:----|
| config   | 对象   | 软件基础配置，指定后才可正常运行   |
| host   | NSString   | 默认为阿里云域名，如果是其它域名需要自己指定   |
| kitInfo   | 对象   | UI相关配置   |
| resultBlock   | 回调   | 初始化状态回调，code=1成功   |

示例代码：

```js

SobotCacheEntity *config = [[SobotCacheEntity alloc] init];
	// 指定bundle名称
    config.bundleName = @"SobotOrder"; 
    // 指定国际化文件在bundle中的路径
    config.languageTableName = @"SobotLocal";     
    // 指定国际化文件名称
    config.languagePathInBundle = @"Localizable"; 
    // 指定颜色在bundle中的文件名称
    config.colorTableName = @"SobotColor";
    // 指定语言
    config.absoluetelanguage = @"zh-Hans";
    [SobotOrderApi initWithHost:@"" config:config kitInfo:kitInfo result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {

    }];

```
### 3.3 权限设置
 需要加入的权限

```js
<key>NSCameraUsageDescription</key>
  <string>发送图片需要访问相机</string>
<key>NSPhotoLibraryUsageDescription</key>
  <string>发送图片需要访问相册</string>
```
### 3.4 启动智齿页面
#### 3.4.1 启动工单首页

方式1：直接使用我们提供的方法，自动完成登录并跳转页面。
接口：

```js


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
    
    
```
参数

| 参数名   | 类型   | 描述   |
|:----|:----|:----|
| account   | NSString   | 客服账户 |  
| loginPwd   | NSString   | 客服账户密码 |  
| token   | NSString   | 已登录的token |  
| vc   | UIViewController   | 执行跳转的vc|
| resultBlock   | void (^)(NSInteger code,id _Nullable obj,NSString *_Nullable msg)   | 执行结果，code=1为成功   |

示例代码：

```js

[SobotOrderApi startWithAcount:loginAccount password:password viewController:self result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
}];

```


方式2：直接创建SobotOrderHomeController，自己完成登录并跳转页面。需要先完成登录，然后再执行跳转。
接口：

```js  


/// 登录
/// @param account 账号
/// @param loginPwd 密码
/// @param resultBlock 回调结果
+(void)loginUser:(NSString *)account password:(NSString * )loginPwd result:(SobotResultBlock) resultBlock;


/// 登录（使用token)
/// @param account 账号
/// @param loginPwd 密码 非必填，如果提供当token为空时会使用账户、密码执行登录
/// @param token token
/// @param resultBlock 回调结果
+(void)loginUser:(NSString *)account password:(NSString * )loginPwd  token:(NSString *) token  result:(SobotResultBlock) resultBlock;

```  
参数

| 参数名   | 类型   | 描述   |
|:----|:----|:----|
| account   | NSString   | 客服账户 |  
| loginPwd   | NSString   | 客服账户密码,非必填，仅token为空时使用 |  
| token   | NSString   | 已登录的token |  
| vc   | UIViewController   | 执行跳转的vc|
| resultBlock   | void (^)(NSInteger code,id _Nullable obj,NSString *_Nullable msg)   | 执行结果，code=1为成功   |


事例：

```js   


[SobotOrderApi loginUser:fieldUserName.text password:fieldPassword.text token:fieldToken.text result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
    if(code == 1){
		// 直接创建VC，自行决定使用
		SobotOrderHomeController *orderHomeVC = [[SobotOrderHomeController alloc]init];
    }
}];

```


#### 3.4.2 启动工单详情
【注：执行次操作之前，需要保证已完成登录】

接口

```js 

/// 打开工单详情页面
/// @param vc 启动VC
/// @param ticketId 工单ID
/// @param resultBlock 回调结果
+(void)startOrderDetail:(UIViewController *) vc orderId:(NSString *) ticketId  result:(SobotResultBlock) resultBlock;

```
参数

| 参数名   | 类型   | 描述   |
|:----|:----|:----|
| ticketId   | NSString   | 工单ID |
| vc   | UIViewController   | 执行跳转的vc  |
| resultBlock   | void (^)(NSInteger code,id _Nullable obj,NSString *_Nullable msg)   | 执行结果，code=1为成功，成功了会自动跳转   |


示例代码：

```js

[SobotOrderApi startOrderDetail:self orderId:fieldOrderId.text result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
}];
        
```
#### 3.4.3 启动创建工单页面
【注：执行次操作之前，需要保证已完成登录】

接口

```js 

/// // 直接进入创建工单页面 创建工单，提交后退出
/// @param vc  启动VC
/// @param params 入参  @{@"uname':@"传创建工单的客服昵称",@"userId":@"传创建工单的客服ID"}
/// @param resultBlock 回调结果
+(void)startCreateOrder:(UIViewController *)vc params:(NSDictionary * _Nullable)params result:(SobotResultBlock) resultBlock;


```
参数

| 参数名   | 类型   | 描述   |
|:----|:----|:----|
| params   | NSDictionary   | 客户信息，非必填，指定了创建工单页面不用再选择对应客户 |
| vc   | UIViewController   | 执行跳转的vc  |
| resultBlock   | void (^)(NSInteger code,id _Nullable obj,NSString *_Nullable msg)   | 执行结果，code=1为成功，成功了会自动跳转   |



```js

 NSDictionary *params = nil;
        if(fieldUserName.text.length > 0 && fieldUserId.text.length > 0){
            params = @{@"uname":sobotConvertToString(fieldUserName.text),@"userId":sobotConvertToString(fieldUserId.text)};
        }
        if(fieldOrderId.text == 0){
            return;
        }
        [SobotOrderApi startCreateOrder:self params:params result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {
            
        }];
    
```


### 3.5 登录
```js

/// 登录
/// @param account 账号
/// @param loginPwd 密码
/// @param resultBlock 回调结果
+(void)loginUser:(NSString *)account password:(NSString * )loginPwd result:(SobotResultBlock) resultBlock;

/// 登录（使用token）
/// @param account 账号
/// @param loginPwd 密码，非必填，没有token时会尝试使用密码登录
/// @param token token
/// @param resultBlock 回调结果
+(void)loginUser:(NSString *)account password:(NSString * )loginPwd  token:(NSString *) token  result:(SobotResultBlock) resultBlock;

```

### 3.6 退出登录
```js

     
/// 退出SDK
/// @param resultBlock 回调结果
+(void)outSobotUser:(SobotResultBlock) resultBlock;

```

### 3.7 设置调试模式
```js


/// 设置是否 Debug模式，默认为NO，不显示日志
/// @param isShowDebug  YES or NO
+(void)setShowDebug:(BOOL) isShowDebug;

```


## 4 配置类属性说明
### 4.1 SobotKitConfig类说明
配置立即生效，使用SobotOrderApi.h中的如下函数配置,初始化和直接配置后配置覆盖前一个设置值;

| 属性名称   | 数据类型   | 说明   | 备注   |
|:----|:----|:----|:----|
| isShowExitAlterView   | BOOL   | 登录失败时，是否显示弹退出登录弹窗   | 默认为NO 未开启   |

设置方法：  

```    
/// 更改kitConfig配置
/// @param kitConfig  congfig配置
+(void)configKitInfo:(SobotKitConfig *) kitConfig;

/// 初始化配置
/// @param host 域名
/// @param config  SobotCacheEntity 配置类
/// @param kitInfo SobotKitConfig 配置类
/// @param resultBlock 初始化回调 (NSInteger code,id _Nullable obj,NSString *_Nullable msg)；
+(void)initWithHost:(NSString *)host config:(SobotCacheEntity *)config  kitInfo:(SobotKitConfig *)kitInfo result:(SobotResultBlock) resultBlock;

```  




### 4.2 SobotCacheEntity类说明
初始化时必须配置此属性，配置一次即可，无需重复配置。  

| 属性名称 | 数据类型 | 说明 | 备注 |
|:----|:----|:----|:----|
| themeMode   | NSInteger   | 显示模式   |0、跟随系统，1，暗黑，2高亮|
| bundleName   | NSString   | 资源名称，默认SobotOrder   | 默认SobotOrder   |
| languagePathInBundle   | NSString   | bundle中的国际化文件路径   | 固定值Localizable   |
| languageTableName   | NSString   | bundle中国际化文件名称    |  固定值SobotLocal   |
| colorTableName   | NSString   | bundle中颜色文件名称   | 固定值：SobotColor   |
| absoluetelanguage   | NSString   | 指定语言  |默认跟随系统    |

## 5 智齿SDK资源库源码和功能体验Demo
      智齿SDK功能体验Demo[下载地址](https://github.com/ZCSDK/iOS_OrderSDK_demo.git)

## 6 常见问题
       常见问题解答：
      1.账号怎么获取
      2.初始化失败怎么解决
请[点击链接](https://www.sobot.com/chat/pc/v2/index.html?sysnum=a76f3cef7d1043c69dd592c3e43f8242#0) 进入智能机器人输入您的问题

      
## 7 更新说明

   [《智齿iOS_OrderSDK 版本更新说明》](https://github.com/ZCSDK/iOS_OrderSDK_demo/releases/tag/1.0.0)


## 8 智齿科技SDK收集使用个人信息说明
  [《智齿科技SDK收集使用个人信息说明》](https:/test.sobot.com/docs/clause/sdk-clause.html)