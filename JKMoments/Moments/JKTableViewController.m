//
//  JKTableViewController.m
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import "JKTableViewController.h"
#import "JKMessageCell.h"
#import "JKMessageDelegate.h"

@interface JKTableViewController ()
<JKMessageDelegate>

@property (nonatomic, strong) NSMutableArray<JKMessage*>    *dataSource;



@end

@implementation JKTableViewController

- (NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadFakeData];
}

#pragma mark JKMessageDelegate
- (void)userHeadClickWithMessage:(JKMessage*)message
{
    DLog(@"userHeadClickWithMessage 点击了头像");
}

- (void)userNameClickWithMessage:(JKMessage*)message
{
    DLog(@"userNameClickWithMessage %@",message.userName);

}

- (void)collectClickWithMessage:(JKMessage*)message
{
    DLog(@"collectClickWithMessage 收藏了一下");

}

- (void)praiseClickWithMessage:(JKMessage*)message
{
    DLog(@"praiseClickWithMessage 赞了一下");

}

- (void)commentClickWithMessageComment:(JKMessageComment*)comment message:(JKMessage*)message
{
    DLog(@"commentClickWithMessageComment %@",comment.content);

}

- (void)commentUserHeadClickWithMessageComment:(JKMessageComment*)comment message:(JKMessage*)message
{
    DLog(@"commentUserHeadClickWithMessageComment  %@",comment.userName);

}

- (void)loadMoreCommentWithMessage:(JKMessage*)comment
{
    DLog(@"loadMoreCommentWithMessage 加载更多评论");

}

- (void)commentButtonClickWithMessage:(JKMessage*)message
{
    DLog(@"commentButtonClickWithMessage  你点击了评论按钮");
    

}

#pragma mark loadFakeData
- (void)loadFakeData
{
    JKMessage *message = [[JKMessage alloc]init];
    message.message_id = 1111;
    message.userName = @"乔克叔叔";
    message.uid = 100000;
    message.avatar = @"http://www.orimuse.com/f_images/avatars/76605548-9dd4-4294-bd3f-549eef7a6808.png";
    message.createTime = @"09:15";
    message.praise = YES;
    message.collect = YES;
    message.praiseNum = 100;
    message.commentNum = 100;
    message.content = @"阅读博客\n经过一段时间的坚持阅读，发现对自己的提升还是不少的。比如有好用的工具，有好的开源项目...这些都是可以提升自己的。这里有著名开发者唐巧整理的一些还不错的博客地";
    message.imageURLs = @[
                          @"http://f.hiphotos.baidu.com/image/h%3D360/sign=f6007fc08301a18befeb1449ae2d0761/8644ebf81a4c510fa42d1bf66459252dd52aa575.jpg",
                          @"http://f.hiphotos.baidu.com/image/h%3D360/sign=f6007fc08301a18befeb1449ae2d0761/8644ebf81a4c510fa42d1bf66459252dd52aa575.jpg",
                          @"http://f.hiphotos.baidu.com/image/h%3D360/sign=f6007fc08301a18befeb1449ae2d0761/8644ebf81a4c510fa42d1bf66459252dd52aa575.jpg",
                          @"http://f.hiphotos.baidu.com/image/h%3D360/sign=f6007fc08301a18befeb1449ae2d0761/8644ebf81a4c510fa42d1bf66459252dd52aa575.jpg",
                          @"http://www.orimuse.com/f_images/products_thumbnail/d5f0f66b-f289-4cbc-b410-31cc70d2fca6.png",
                          @"http://www.orimuse.com/f_images/products_thumbnail/87583fd5-4578-4826-8abe-d97ee8372b66.png",
                          @"http://www.orimuse.com/f_images/products_thumbnail/04cf7d0c-74d8-4edb-9ffd-d5b66361abdb.png",
                          @"http://www.orimuse.com/f_images/products_thumbnail/7e513823-9dba-433e-a895-d80dee0607b3.png",
//                          @"http://www.orimuse.com/f_images/products_thumbnail/b4426351-368b-46dc-8d99-027a9d9f68d1.png",
//                          @"http://www.orimuse.com/f_images/products_thumbnail/909a1cc0-c3d6-4dd7-97a1-dceb2aa72f43.png",
//                          @"http://www.orimuse.com/f_images/products_thumbnail/d5f0f66b-f289-4cbc-b410-31cc70d2fca6.png",
//                          @"http://www.orimuse.com/f_images/products_thumbnail/87583fd5-4578-4826-8abe-d97ee8372b66.png",
                          ];
    
    JKMessageComment *comment1 = [[JKMessageComment alloc]init];
    comment1.message_id = 1111;
    comment1.reply_id = 123123;
    comment1.uid = 234;
    comment1.userName = @"乔克叔叔";
    comment1.avatar = @"http://www.orimuse.com/f_images/avatars/76605548-9dd4-4294-bd3f-549eef7a6808.png";
    comment1.content = @"自己回复自己一下，哈哈哈啊哈哈😄";
    comment1.replyTime = @"09:15";
    comment1.textContainer = [JKMessageComment getTextContainer:comment1];

    JKMessageComment *comment2 = [[JKMessageComment alloc]init];
    comment2.message_id = 1111;
    comment2.reply_id = 2131231;
    comment2.uid = 345643;
    comment2.userName = @"Jack";
    comment2.avatar = @"http://www.orimuse.com/f_images/avatars/76605548-9dd4-4294-bd3f-549eef7a6808.png";
    comment2.content = @"这是一个很长的评论，这是一个很长的评论，这是一个很长的评论，这是一个很长的评论，这是一个很长的评论，这是一个很长的评论，这是一个很长的评论，这是一个很长的评论，这是一个很长的评论😄";
    comment2.replyTime = @"09:15";
    comment2.textContainer = [JKMessageComment getTextContainer:comment2];

    JKMessageComment *comment3 = [[JKMessageComment alloc]init];
    comment3.message_id = 1111;
    comment3.reply_id = 12312312;
    comment3.uid = 12312343;
    comment3.userName = @"Tom";
    comment3.avatar = @"http://www.orimuse.com/f_images/avatars/76605548-9dd4-4294-bd3f-549eef7a6808.png";
    comment3.content = @"楼主威武~~😄";
    comment3.replyTime = @"09:15";
    comment3.textContainer = [JKMessageComment getTextContainer:comment3];

    message.comments = @[comment1,comment2,comment3,comment2,comment3,comment3,comment1];
//    message.comments = @[comment1];

    [self.dataSource addObjectsFromArray:@[message,message,message,message]];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JKMessage *item = self.dataSource[indexPath.row];
    CGFloat height = [JKMessageCell cellHeightWithObj:item];
    return height;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JKMessageCell *cell = [JKMessageCell tableView:tableView data:self.dataSource[indexPath.row]];
    cell.delegate = self;
    return cell;
}

@end
