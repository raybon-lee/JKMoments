//
//  JKMessage.m
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "JKMessage.h"
#import "TYLinkTextStorage.h"
#import "JKMessageCell.h"

@implementation JKMessage




@end


@implementation JKMessageComment

+ (TYTextContainer*)getTextContainer:(JKMessageComment*)item
{
    NSString *content = [NSString stringWithFormat:@"%@:%@",item.userName,item.content];
    
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
    textContainer.linesSpacing = 1.2;
    textContainer.characterSpacing = 0.8;
    textContainer.text = content;
    
    TYLinkTextStorage *linkTextStorage = [[TYLinkTextStorage alloc]init];
    linkTextStorage.range = [content rangeOfString:[NSString stringWithFormat:@"%@:",item.userName]];
    linkTextStorage.font = [UIFont systemFontOfSize:12];
    linkTextStorage.textColor = [UIColor blueColor];
    linkTextStorage.linkData = item.userName;
    linkTextStorage.underLineStyle = kCTUnderlineStyleNone;
    linkTextStorage.modifier = kCTUnderlinePatternSolid;
    
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.font = [UIFont systemFontOfSize:12];
    textStorage.textColor = RGB_COLOR(99, 99, 99);
    textStorage.range = [content rangeOfString:item.content];
    textStorage.underLineStyle = kCTUnderlineStyleNone;
    textStorage.modifier = kCTUnderlinePatternSolid;
    
    
    [textContainer addTextStorage:linkTextStorage];
    [textContainer addTextStorage:textStorage];
    textContainer = [textContainer createTextContainerWithTextWidth:[JKMessageCell commentViewWidth] - 10];
    
    return textContainer;
}


@end
