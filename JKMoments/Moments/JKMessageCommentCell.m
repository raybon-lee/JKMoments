//
//  JKMessageCommentCell.m
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "JKMessageCommentCell.h"
#import "JKMessageCell.h"
#import "JKMessage.h"
#import "TYAttributedLabel.h"
#import "TYLinkTextStorage.h"

@interface JKMessageCommentCell ()
<TYAttributedLabelDelegate>

@property (nonatomic, strong) JKMessageComment   *item;
@property (nonatomic, strong) TYAttributedLabel  *tyaLabel;

@end

@implementation JKMessageCommentCell


+ (CGFloat)cellHeightWithObj:(id)obj
{
    JKMessageComment *item = (JKMessageComment*)obj;
    return item.textContainer.textHeight + 2;
}

+ (JKMessageCommentCell*)tableView:(UITableView *)tableView data:(id)data
{
    static NSString *cell_id = @"JKMessageCommentCell";
    JKMessageCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[JKMessageCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];

        [cell setupSubviews];
    }
    cell.item = data;
    return cell;
}

- (void)setItem:(JKMessageComment *)item
{
    
    NSAssert(item.textContainer, @"JKMessageComment中的textContainer属性不能为空");
    
    _item = item;
    
    self.tyaLabel.textContainer = item.textContainer;
}

- (void)setupSubviews
{
    self.tyaLabel = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0,0, [JKMessageCell commentViewWidth], 0)];
    _tyaLabel.backgroundColor = [UIColor clearColor];
    _tyaLabel.delegate = self;
    _tyaLabel.highlightedLinkColor = [UIColor redColor];
    [self.contentView addSubview:_tyaLabel];
}

#pragma mark - TYAttributedLabelDelegate

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point
{

    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        
        if ([self.delegate respondsToSelector:@selector(commentUserHeadClickWithMessageComment:message:)]) {
            [self.delegate commentUserHeadClickWithMessageComment:self.item message:nil];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.tyaLabel setFrameWithOrign:CGPointMake(5, 5) Width:[JKMessageCell commentViewWidth] - 10];
}

@end
