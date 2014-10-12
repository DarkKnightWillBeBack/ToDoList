//
//  ToDoItem.h
//  start
//
//  Created by 谢润丰 on 14-9-24.
//  Copyright (c) 2014年 StarkIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject <NSCoding>

@property NSString *itemname;
@property BOOL completed;

@end
