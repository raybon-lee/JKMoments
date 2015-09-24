//
//  JKMessageMoreCommentCell.m
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "JKMessageMoreCommentCell.h"
#import "JKMessageCell.h"

@interface JKMessageMoreCommentCell ()

@property (strong, nonatomic) UILabel *contentLabel;
//@property (strong, nonatomic) UIImageView *commentIconView;

@end

@implementation JKMessageMoreCommentCell

+ (JKMessageMoreCommentCell*)tableView:(UITableView *)tableView
{
    static NSString *cell_id = @"JKMessageMoreCommentCell";
    JKMessageMoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[JKMessageMoreCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        
        [cell setupSubviews];
    }
    return cell;
}

- (void)setupSubviews
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [JKMessageCell commentViewWidth], 20)];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = RGB_COLOR(120, 120, 120);
        _contentLabel.text = @"查看更多评论";
        [self.contentView addSubview:_contentLabel];
    }
}

@end
