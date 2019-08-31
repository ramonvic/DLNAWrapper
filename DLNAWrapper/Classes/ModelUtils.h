//
//  ModelUtils.h
//  DLNAWrapper
//
//  Created by Key.Yao on 16/9/23.
//  Copyright © 2016年 Key. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelUtils : NSObject

/**
 * Time (seconds) to String, format (xx:xx:xx)
 */
+ (NSString *)timeStringFromInteger:(NSInteger)seconds;

/**
 * Time (String) to second, format (xx:xx:xx)
 */
+ (NSInteger)timeIntegerFromString:(NSString *)string;

@end
