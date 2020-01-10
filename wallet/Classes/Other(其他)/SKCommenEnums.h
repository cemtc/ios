//
//  SKCommenEnums.h
//  Business
//
//  Created by talking　 on 2018/8/13.
//  Copyright © 2018年 talking　. All rights reserved.
//

#ifndef SKCommenEnums_h
#define SKCommenEnums_h

#import <Foundation/Foundation.h>

//url请求返回的数据 是NSDictionary(result) 还是数组(results) 默认NSDictionary(result)
typedef NS_ENUM(NSUInteger, SKResultResponType){
    SKResultResponTypeDictionary,
    SKResultResponTypeArray
};

//请求方式
typedef NS_ENUM(NSUInteger, SKRequestMethodType) {
    //    // GET请求
    SKRequestMethodTypeGET,
    //
    //    // POST请求
    SKRequestMethodTypePOST,
    //
    //    // PUT请求
    SKRequestMethodTypePUT,
    //
    //    // DELETE请求
    SKRequestMethodTypeDELETE,
    //
    //    // PATCH请求
    SKRequestMethodTypePATCH,
    //
    //    // HEAD请求
    SKRequestMethodTypeHEAD
};


//选座状态
typedef NS_ENUM(NSUInteger, KyoCinameSeatStateType){
    //不是按摩椅
    KyoCinameSeatStateTypeEmpty,
    
    //是按摩椅 离线状态
    KyoCinameSeatStateTypeOffline,
    //是按摩椅 在线状态
    KyoCinameSeatStateTypeOnline,
    
    //极差
    KyoCinameSeatStateTypeVeryPoor,
    //较差
    KyoCinameSeatStateTypePoor,
    //中等
    KyoCinameSeatStateTypeMedium,
    //良好
    KyoCinameSeatStateTypeGeneral,
    //优秀
    KyoCinameSeatStateTypeGood,
    
    //选中状态
    KyoCinameSeatStateTypeSelect,

    //显示全部
    KyoCinameSeatStateTypeAll  //这个没啥用,只是用来传参数判断是他 并没有赋值!!!!!也可以用其他的判断没啥用
};
//收益热点 日周月
typedef NS_ENUM(NSUInteger, SKDateButtonType){
    SKDateButtonTypeWeek,//默认周
    SKDateButtonTypeDay,//日
    SKDateButtonTypeMonth//月
};


#endif /* SKCommenEnums_h */
