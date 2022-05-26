//
//  SobotCache.h
//  SobotOnline
//
//  Created by zhangxy on 2020/8/5.
//  Copyright © 2020 sobot. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SobotCommon/SobotCacheEntity.h>

NS_ASSUME_NONNULL_BEGIN


@interface SobotCache : NSObject

@property(strong,nonatomic) SobotCacheEntity *sobotCacheEntity;

/**
 *  单例
 *
 *  @return ZZLibNetworkTools创建的对象
 */
+(SobotCache *) shareSobotCache;


+(NSBundle *)getSourceBundle:(NSBundle *__nullable) placeholderBundle;
+ (void)setSobotSourceBundle:(NSBundle *__nullable) bundle withName:(NSString * __nullable) bundleName;


+(BOOL)useImagesxcassets;
+(NSString *)getSourceFilePath;


///
/// 常用存储类
///
+ (NSString*)dataTOjsonString:(id)object;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
// 对象转换为字典
+ (NSDictionary*)getObjectData:(id)obj;


/**
 存储本地数据到NSUserDefault中

 @param value 值
 @param key 键
 */
+(void)addObject:(id) value forKey:(NSString *) key;
+(void)removeObjectByKey:(NSString *) key;

/**
 把dict封装成本地数组存储

 @param arr 字典数组
 @param key 键
 */
+(void)addObjectToArray:(NSDictionary *) arr for:(NSString *) key;



/**
 获取普通存储的值

 @param key 键
 @return 值
 */
+(id)getLocalParamter:(NSString *) key;


/**
 获取数据后转换为JSON
 @param key 键
 @return json字符串
 */
+(NSString *)getLocalJSONData:(NSString *) key;


/**
 获取存储的字典

 @param key 键
 @return 字典类型
 */
+(NSDictionary *)getLocalDictionary:(NSString *)key;



/**
 获取存储的arr

 @param key 键
 @return 数组类型
 */
+(NSArray *)getLocalArray:(NSString *)key;



@end

NS_ASSUME_NONNULL_END
