//
//  SobotExtenalHeader.h
//  SobotUI
//
//  Created by zhangxy on 2022/3/18.
//


//#import "SobotUtils.h"
//#import "SobotLocaliable.h"

#ifndef SobotExtenalHeader_h
#define SobotExtenalHeader_h

// 多语言支持
#define SobotLocalString(key) (key) //[[SobotLocaliable shareSobotLocaliable] sobotGetLocalString:key]

// 以下方法均删除
#define sobotGetSystemDoubleVersion() 9.0
#define sobotIsRTLLayout() NO
#define sobotConvertToString(v) (v)
#define sobotGetDocumentsFilePath(v) (v)
#define sobotCheckPathAndCreate(v) (v)
#define sobotCheckFileIsExsis(v) NO
#define sobotGetLanguagePrefix() @"en"
#define sobotMd5(v) (v)

#endif /* SobotExtenalHeader_h */
