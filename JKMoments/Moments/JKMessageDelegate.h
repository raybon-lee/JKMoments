//
//  JKMessageDelegate.h
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JKMessage;
@class JKMessageComment;

@protocol JKMessageDelegate <NSObject>

@optional

/*!
 *  @author Bingjie, 15-09-21 22:09:45
 *
 *  点击头像
 *
 *  @param message 信息
 */
- (void)userHeadClickWithMessage:(JKMessage*)message;

/*!
 *  @author Bingjie, 15-09-21 22:09:00
 *
 *  点击作者名字
 *
 *  @param message message
 */
- (void)userNameClickWithMessage:(JKMessage*)message;

/*!
 *  @author Bingjie, 15-09-21 22:09:00
 *
 *  点击收藏
 *
 *  @param message message
 */
- (void)collectClickWithMessage:(JKMessage*)message;

/*!
 *  @author Bingjie, 15-09-21 22:09:00
 *
 *  点击赞
 *
 *  @param message message
 */
- (void)praiseClickWithMessage:(JKMessage*)message;

/*!
 *  @author Bingjie, 15-09-21 22:09:00
 *
 *  点击评论按钮
 *
 *  @param message message
 */
- (void)commentButtonClickWithMessage:(JKMessage*)message;

/*!
 *  @author Bingjie, 15-09-21 22:09:00
 *
 *  点击评论信息
 *
 *  @param message message
 */
- (void)commentClickWithMessageComment:(JKMessageComment*)comment message:(JKMessage*)message;

/*!
 *  @author Bingjie, 15-09-21 22:09:00
 *
 *  点击评论作者
 *
 *  @param message message
 */
- (void)commentUserHeadClickWithMessageComment:(JKMessageComment*)comment message:(JKMessage*)message;

/*!
 *  @author Bingjie, 15-09-21 22:09:00
 *
 *  查看更多评论
 *
 *  @param message message
 */
- (void)loadMoreCommentWithMessage:(JKMessage*)comment;


@end
