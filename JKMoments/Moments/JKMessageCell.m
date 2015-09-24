//
//  JKMessageCell.m
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "JKMessageCell.h"
#import "JKMessageCommentCell.h"
#import "JKMessageMoreCommentCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

static CGFloat JKMessage_Head_Height = 50.0f;
static CGFloat JKMessage_xMargin = 10.0f;
static CGFloat JKMessage_yMargin = 10.0f;
static CGFloat JKMessage_offset = 10.0f;

#define JKMessage_MediaView_Height  ((SCREEN_WIDTH - 2*JKMessage_xMargin) / 3)
#define JKMessage_MediaView_Width  ((SCREEN_WIDTH - 2*JKMessage_xMargin) / 3)

#define JKMessage_CommentView_Width   (SCREEN_WIDTH - 4*JKMessage_xMargin)

#define JKMessage_ContentFont [UIFont systemFontOfSize:13]

@interface JKMessageCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UITableViewDelegate,
UITableViewDataSource,
JKMessageDelegate
>

@property (strong, nonatomic) JKMessage     *item;

@property (strong, nonatomic) UIImageView *headView;
@property (strong, nonatomic) UILabel     *nameLabel;

@property (strong, nonatomic) UILabel     *timeLabel;

@property (strong, nonatomic) UIButton     *collectButton;

@property (strong, nonatomic) UILabel     *contentLabel;

@property (strong, nonatomic) UICollectionView *mediaView;

@property (strong, nonatomic) UIButton     *praiseNumButton;
@property (strong, nonatomic) UIButton    *commentNumView;

@property (strong, nonatomic) UITableView *commentView;


@end

@implementation JKMessageCell

#pragma mark - 计算高度
+ (CGFloat)cellHeightWithObj:(id)obj
{
    JKMessage *item = (JKMessage*)obj;
    
    CGFloat height = 0;
    
    CGSize contentSize = [item.content getSizeWithFont:JKMessage_ContentFont constrainedToSize:CGSizeMake(SCREEN_WIDTH - 2*JKMessage_xMargin, 999)];
    
    height = height + JKMessage_yMargin + JKMessage_Head_Height + JKMessage_offset + contentSize.height + JKMessage_offset;

    NSInteger row = [self.class mediaViewRowsByMessage:item];
    height = height + JKMessage_MediaView_Height*row + JKMessage_offset + 25;
    
    CGFloat commentHeight = [self.class commentViewHeightByMessage:item];
    
    height = height + JKMessage_offset + commentHeight;
    
    height = height + JKMessage_yMargin;
    
    return ceilf(height);
}

+ (CGFloat)commentViewHeightByMessage:(JKMessage*)item
{
    __block CGFloat commentHeight = 0;
    [item.comments enumerateObjectsUsingBlock:^(JKMessageComment * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= JKMessag_MaxComments) {
            *stop = YES;
            commentHeight = commentHeight + JKMessag_MoreCommentHeight;
            return ;
        }
        commentHeight = commentHeight + [JKMessageCommentCell cellHeightWithObj:obj];
    }];
    return commentHeight;
}

+ (CGFloat)commentViewWidth
{
    return JKMessage_CommentView_Width;
}

+ (NSInteger)mediaViewRowsByMessage:(JKMessage*)item
{
    if (item.imageURLs.count == 0) {
        return 0;
    }
    if (item.imageURLs.count <= 3) {
        return 1;
    }
    if (item.imageURLs.count <= 6) {
        return 2;
    }
    if (item.imageURLs.count <= 9) {
        return 3;
    }
    return 0;
}

#pragma mark - init
+ (JKMessageCell*)tableView:(UITableView *)tableView data:(id)data
{
    static NSString *cell_id = @"JKMessageCell";
    JKMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[JKMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.item = data;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}


#pragma mark - set
- (void)setItem:(JKMessage *)item
{
    _item = item;
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:item.avatar]];
    self.nameLabel.text = item.userName;
    self.timeLabel.text = item.createTime;
    self.contentLabel.text = item.content;
    self.collectButton.selected = item.isCollect;

    [self.praiseNumButton setTitle:[NSString stringWithFormat:@"赞:%@",@(item.praiseNum)] forState:UIControlStateNormal];
    [self.commentNumView setTitle:[NSString stringWithFormat:@" %@",@(item.commentNum)] forState:UIControlStateNormal];
    
    [self.mediaView reloadData];
    [self.commentView reloadData];
    
    [self layoutSubviews];
}

#pragma mark - event
- (void)userHeadClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(userHeadClickWithMessage:)]) {
        [self.delegate userHeadClickWithMessage:self.item];
    }
}

- (void)userNameClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(userNameClickWithMessage:)]) {
        [self.delegate userNameClickWithMessage:self.item];
    }
}

- (void)collectClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(collectClickWithMessage:)]) {
        [self.delegate collectClickWithMessage:self.item];
    }
}

- (void)praiseClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(praiseClickWithMessage:)]) {
        [self.delegate praiseClickWithMessage:self.item];
    }
}

- (void)commentClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(commentButtonClickWithMessage:)]) {
        [self.delegate commentButtonClickWithMessage:self.item];
    }
}


#pragma mark - subviews
- (void)setupSubviews
{
    self.headView = [[UIImageView alloc]init];
    _headView.contentMode = UIViewContentModeScaleAspectFit;
    _headView.layer.cornerRadius = 8;
    _headView.layer.borderColor = [UIColor clearColor].CGColor;
    _headView.layer.borderWidth = 1;
    [_headView.layer setMasksToBounds:YES];
    [_headView addTapGesturesTarget:self selector:@selector(userHeadClick:)];

    [self.contentView addSubview:_headView];
    
    self.nameLabel = [[UILabel alloc]init];
    _nameLabel.textColor = RGB_COLOR(144, 144, 210);
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel addTapGesturesTarget:self selector:@selector(userNameClick:)];
    
    self.timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = RGB_COLOR(144, 144, 144);
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_timeLabel];
    
    self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectButton setImage:[UIImage imageNamed:@"orimuse_uncollect"] forState:UIControlStateNormal];
    [_collectButton setImage:[UIImage imageNamed:@"orimuse_collect"] forState:UIControlStateSelected];
    [_collectButton addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_collectButton];
    
    self.contentLabel = [[UILabel alloc]init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = RGB_COLOR(88, 88, 88);
    _contentLabel.font = JKMessage_ContentFont;
    [self.contentView addSubview:_contentLabel];
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.mediaView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.mediaView.scrollEnabled = NO;
    [self.mediaView setBackgroundView:nil];
    [self.mediaView setBackgroundColor:[UIColor clearColor]];
    [self.mediaView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.mediaView.dataSource = self;
    self.mediaView.delegate = self;
    [self.contentView addSubview:self.mediaView];
    
    
    self.praiseNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_praiseNumButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _praiseNumButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_praiseNumButton addTarget:self action:@selector(praiseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_praiseNumButton];
    
    self.commentNumView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentNumView setImage:[UIImage imageNamed:@"orimuse_uncollect"] forState:UIControlStateNormal];
    _commentNumView.titleLabel.font = [UIFont systemFontOfSize:13];
    [_commentNumView setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_commentNumView addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_commentNumView];
    
    self.commentView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _commentView.delegate = self;
    _commentView.dataSource = self;
    _commentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentView.scrollEnabled = NO;
    [self.contentView addSubview:_commentView];
    _commentView.backgroundColor = RGB_COLOR(230, 230, 230);
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headView.frame = CGRectMake(JKMessage_xMargin, JKMessage_yMargin, JKMessage_Head_Height, JKMessage_Head_Height);
    self.nameLabel.frame = CGRectMake(self.headView.right + JKMessage_offset, JKMessage_yMargin, 200, 20);
    self.timeLabel.frame = CGRectMake(self.headView.right + JKMessage_offset, self.headView.bottom - 20, 200, 20);

    self.collectButton.frame = CGRectMake(SCREEN_WIDTH - 25 - JKMessage_xMargin, JKMessage_yMargin + 10, 25, 25);
    
    
    CGSize contentSize = [self.item.content getSizeWithFont:JKMessage_ContentFont constrainedToSize:CGSizeMake(SCREEN_WIDTH - 2*JKMessage_xMargin, 999)];
    self.contentLabel.frame = CGRectMake(JKMessage_xMargin, self.headView.bottom + JKMessage_offset, contentSize.width, contentSize.height);
    
    NSInteger row = [self.class mediaViewRowsByMessage:self.item];
    self.mediaView.frame = CGRectMake(JKMessage_xMargin, self.contentLabel.bottom + JKMessage_offset, SCREEN_WIDTH - 2*JKMessage_xMargin, JKMessage_MediaView_Height * row);
    
    self.praiseNumButton.frame = CGRectMake(JKMessage_xMargin, self.mediaView.bottom + JKMessage_offset , 100, 25);
    self.commentNumView.frame = CGRectMake(self.praiseNumButton.right, self.mediaView.bottom + JKMessage_offset, 100, 25);

    CGFloat commentHeight = [self.class commentViewHeightByMessage:self.item];
    
    CGFloat x = (SCREEN_WIDTH - [self.class commentViewWidth])/2;
    
    self.commentView.frame = CGRectMake(x, self.commentNumView.bottom, [self.class commentViewWidth], commentHeight);
}


#pragma mark Table M comments
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = self.item.comments.count>JKMessag_MaxComments?(JKMessag_MaxComments+1):self.item.comments.count;
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= JKMessag_MaxComments) {
        JKMessageMoreCommentCell *cell = [JKMessageMoreCommentCell tableView:tableView];
        return cell;
    }
    JKMessageComment *item = self.item.comments[indexPath.row];
    JKMessageCommentCell *cell = [JKMessageCommentCell tableView:tableView data:item];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= JKMessag_MaxComments) {
        return JKMessag_MoreCommentHeight;
    }
    JKMessageComment *item = self.item.comments[indexPath.row];
    CGFloat height = [JKMessageCommentCell cellHeightWithObj:item];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row >= JKMessag_MaxComments) {
        if ([self.delegate respondsToSelector:@selector(loadMoreCommentWithMessage:)]) {
            [self.delegate loadMoreCommentWithMessage:self.item];
        }
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(commentClickWithMessageComment:message:)]) {
        [self.delegate commentClickWithMessageComment:self.item.comments[indexPath.row] message:self.item];
    }
}

- (void)commentUserHeadClickWithMessageComment:(JKMessageComment*)comment message:(JKMessage*)message;
{
    if ([self.delegate respondsToSelector:@selector(commentUserHeadClickWithMessageComment:message:)]) {
        [self.delegate commentUserHeadClickWithMessageComment:comment message:self.item];
    }
}

#pragma mark Collection M

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.item.imageURLs.count>JKMessag_MaxImageNum?JKMessag_MaxImageNum:self.item.imageURLs.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    NSString *imageURL = self.item.imageURLs[indexPath.row];
    
    UIImageView *imageview = (UIImageView*)[cell.contentView viewWithTag:0x1111];
    
    if (!imageview) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, cell.contentView.bounds.size.width - 4, cell.contentView.bounds.size.height - 4)];
        imageview.tag = 0x1111;
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageview];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    [imageview sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(JKMessage_MediaView_Width, JKMessage_MediaView_Height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageURL = self.item.imageURLs[indexPath.row];

    
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString:imageURL];
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = @[photo];
    [browser show];
}

@end
