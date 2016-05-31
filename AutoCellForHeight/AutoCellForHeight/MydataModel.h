//
//  MydataModel.h
//  AutoCellForHeight
//
//  Created by archy on 16/5/30.
//  Copyright © 2016年 archy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MydataModel : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *imageName;

@end
