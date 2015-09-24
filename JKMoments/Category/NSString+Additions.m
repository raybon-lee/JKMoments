//
//  NSString+Additions.m
//  ssss
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)


- (CGSize)getSizeWithFont:(UIFont *)fontSize constrainedToSize:(CGSize)sizeFormat
{
    NSDictionary *dict = @{NSFontAttributeName:fontSize, NSParagraphStyleAttributeName:[NSParagraphStyle defaultParagraphStyle]};
    
    CGSize size = CGSizeZero;
    
    if (__DEVICE_OS_VERSION_7_0) {
        size = [self boundingRectWithSize:sizeFormat
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:dict
                                  context:nil].size;
        if (CGSizeEqualToSize(sizeFormat,CGSizeZero)||CGSizeEqualToSize(sizeFormat,CGSizeMake(0, 0))) {
            size = [self sizeWithAttributes:dict];
        }
    }else{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        size = [self sizeWithFont:fontSize
                constrainedToSize:sizeFormat];
        if (CGSizeEqualToSize(sizeFormat,CGSizeZero)||CGSizeEqualToSize(sizeFormat,CGSizeMake(0, 0))) {
            size = [self sizeWithFont:fontSize];
        }
#endif
    }
    return size;
}



@end
