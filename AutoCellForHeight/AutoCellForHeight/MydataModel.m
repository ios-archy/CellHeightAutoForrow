//
//  MydataModel.m
//  AutoCellForHeight
//
//  Created by archy on 16/5/30.
//  Copyright © 2016年 archy. All rights reserved.
//

#import "MydataModel.h"

@implementation MydataModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
        _identifier = [self uniqueIdentifier];
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _username = dictionary[@"username"];
        _time = dictionary[@"time"];
        _imageName = dictionary[@"imageName"];
    }
    return self;
}

- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
