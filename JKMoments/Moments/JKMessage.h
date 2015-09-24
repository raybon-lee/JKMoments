//
//  JKMessage.h
//  Orimuse
//
//  Created by bingjie-macbookpro on 15/9/21.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYTextContainer.h"

@class JKMessageComment;

@interface JKMessage : NSObject

@property (nonatomic, assign) NSInteger   message_id;


@property (nonatomic, copy) NSString   *userName;
@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, copy) NSString   *avatar;
@property (nonatomic, copy) NSString   *createTime;

@property (nonatomic, assign,getter=isPraise) BOOL       praise;
@property (nonatomic, assign,getter=isCollect) BOOL      collect;

@property (nonatomic, assign) NSInteger       praiseNum;
@property (nonatomic, assign) NSInteger       commentNum;


@property (nonatomic, copy) NSString   *content;

@property (nonatomic, copy) NSArray<NSString*>    *imageURLs;

@property (nonatomic, copy) NSArray<JKMessageComment*>    *comments;


@end


@interface JKMessageComment : NSObject

/*!
 *  @author Bingjie, 15-09-21 16:09:29
 *
 *  该评论的id
 */
@property (nonatomic, assign) NSInteger   reply_id;

/*!
 *  @author Bingjie, 15-09-21 16:09:44
 *
 *  改评论对应信息的id (可能用不到)
 */
@property (nonatomic, assign) NSInteger   message_id;

/*!
 *  @author Bingjie, 15-09-21 16:09:09
 *
 *  回复人名字
 */
@property (nonatomic, copy) NSString   *userName;

/*!
 *  @author Bingjie, 15-09-21 16:09:21
 *
 *  回复人di
 */
@property (nonatomic, assign) NSInteger  uid;

/*!
 *  @author Bingjie, 15-09-21 16:09:21
 *
 *  回复人头像
 */
@property (nonatomic, copy) NSString   *avatar;

/*!
 *  @author Bingjie, 15-09-21 16:09:45
 *
 *  回复时间
 */
@property (nonatomic, copy) NSString   *replyTime;

/*!
 *  @author Bingjie, 15-09-21 16:09:53
 *
 *  回复内容
 */
@property (nonatomic, copy) NSString   *content;


/*!
 *  @author Bingjie, 15-09-21 20:09:06
 *
 *  TYTextContainer, 通过 + (TYTextContainer*)getTextContainer:(JKMessageComment*)item 获得该属性，用于计算高度
 */
@property (nonatomic, strong) TYTextContainer   *textContainer;


/*!
 *  @author Bingjie, 15-09-21 20:09:23
 *
 *  数据解析完成之后通过该方法获得 TYTextContainer 
 *
 *  @param item JKMessageComment
 *
 *  @return TYTextContainer
 */
+ (TYTextContainer*)getTextContainer:(JKMessageComment*)item;

@end