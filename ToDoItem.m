//
//  ToDoItem.m
//  start
//
//  Created by 谢润丰 on 14-9-24.
//  Copyright (c) 2014年 StarkIndustry. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_itemname forKey:@"itemname"];
    [coder encodeBool:_completed forKey:@"completed"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        _itemname = [aDecoder decodeObjectForKey:@"itemname"];
        _completed = [aDecoder decodeBoolForKey:@"completed"];
    }
    return self;
}

@end
