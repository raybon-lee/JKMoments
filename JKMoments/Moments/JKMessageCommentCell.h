//
//  JKMessageCommentCell.h
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKMessageDelegate.h"

@interface JKMessageCommentCell : UITableViewCell

@property (nonatomic, assign) id <JKMessageDelegate> delegate;

+ (JKMessageCommentCell*)tableView:(UITableView *)tableView data:(id)data;

+ (CGFloat)cellHeightWithObj:(id)obj;

@end
