//
//  JKMessageCell.h
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKMessage.h"
#import "JKMessageDelegate.h"

//图片最多9个
#define JKMessag_MaxImageNum  9
//评论最多3个
#define JKMessag_MaxComments  3


@interface JKMessageCell : UITableViewCell

@property (nonatomic, assign) id <JKMessageDelegate> delegate;


+ (JKMessageCell*)tableView:(UITableView *)tableView data:(id)data;

+ (CGFloat)cellHeightWithObj:(id)obj;

+ (CGFloat)commentViewWidth;

@end
