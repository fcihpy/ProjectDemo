//
//  FCBaseTableViewProtocol.h
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol FCBaseTableViewDelegate <NSObject>

@optional

/**
 *  点击或选中cell时的代理方法
 *
 *  @param indexPath
 */
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  删除cell时的代理方法
 *
 *  @param indexPath
 */
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  根据返回值判断该cell是否可以被操作(移动、删除、插入等)
 *
 *  @return YES:Can NO:Cant
 */
- (BOOL)isCellEditable;

/**
 *  返回Cell高度的代理方法
 *
 *  @param indexPath
 *
 *  @return
 */
- (CGFloat)cellHeightAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 *  配置UITableViewCell展现方式的block
 *
 *  @param cell UITableViewCell及其子类
 *  @param entity Cell对应的实体
 *  @param indexPath
 */
typedef void(^TableViewCellShowBlock)(id cell, id entity, NSIndexPath *indexPath);

/**
 *  配置不同section中的cell的行数(rows)
 *
 *  @param section section下标
 *
 *  @return TableView中section的数量
 */
typedef NSInteger(^TableViewNumberOfRowInSectionBlock)(NSInteger section);

/**
 *  配置不同section中的cell的行数(rows)
 *
 *  @param section section下标
 *
 *  @return TableView中section的数量
 */

@interface FCBaseTableViewProtocol : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) id<FCBaseTableViewDelegate> delegate;


/**
 *  协议构造器1：有多个section，每个section中cell行数不定时使用
 *
 *  @param aItems
 *  @param aCellIdentifier
 *  @param aSectionNumber                           section的数量
 *  @param aTableViewNumberOfRowInSectionBlock      配置每个section中cell的行数
 *  @param aTableViewCellShowBlock                  配置每个cell的展现方式
 *
 *  @return Protocal Object
 */
- (id)initWithItems:(NSArray *)aItems
    cellIdentifier:(NSString *)aCellIdentifier
  numberOfSections:(NSInteger)aSectionNumber
numberOfRowInSectionBlock:(TableViewNumberOfRowInSectionBlock)aNumberOfRowInSectionBlock
cellShowBlock:(TableViewCellShowBlock)aCellShowBlock;

/**
 *  协议构造器2：默认只有一个section时使用
 *
 *  @param aItems
 *  @param aCellIdentifier
 *  @param aCellConfigureBlock
 *
 *  @return Protocal Object
 */
-(id)initWithItems:(NSArray *)aItems
    cellIdentifier:(NSString *)aCellIdentifier
cellShowBlock:(TableViewCellShowBlock)aCellShowBlock;

@end
