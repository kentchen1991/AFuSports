//
//  NSString+Helper.h
//  AFuSports
//
//  Created by chenshaohai on 15/12/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)
/*
 加密实现MD5和SHA1
 */
+(NSString *) md5:(NSString *)str;
+(NSString*) sha1:(NSString *)str;
+ (NSString*) sha256:(NSString *)str;
@end
