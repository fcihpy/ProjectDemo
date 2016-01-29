//
//  FCBaseTableViewProtocol.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/11/17.
//  Copyright © 2015年 fcihpy. All rights reserved.
//

#import "FCBaseTableViewProtocol.h"

@interface FCBaseTableViewProtocol ()

@property (nonatomic,copy)NSString                            *cellIdentiter;
@property (nonatomic,strong)NSArray                           *items;
@property (nonatomic,assign)NSInteger                         sectionNumber;
@property (nonatomic,copy)TableViewCellShowBlock              cellShowBlock;
@property (nonatomic,copy)TableViewNumberOfRowInSectionBlock  numberOfRowBlock;

@end


@implementation FCBaseTableViewProtocol

- (id)initWithItems:(NSArray *)aItems
     cellIdentifier:(NSString *)aCellIdentifier
   numberOfSections:(NSInteger)aSectionNumber
numberOfRowInSectionBlock:(TableViewNumberOfRowInSectionBlock)aNumberOfRowInSectionBlock
      cellShowBlock:(TableViewCellShowBlock)aCellShowBlock{
    
    if (self = [super init]) {
        
        self.items = aItems;
        self.cellIdentiter = aCellIdentifier;
        self.sectionNumber = aSectionNumber;
        self.numberOfRowBlock = [aNumberOfRowInSectionBlock copy];
        self.cellShowBlock = [aCellShowBlock copy];
    }
    return self;
}

- (id)initWithItems:(NSArray *)aItems
     cellIdentifier:(NSString *)aCellIdentifier
      cellShowBlock:(TableViewCellShowBlock)aCellShowBlock{
    
    return [self initWithItems:aItems
                cellIdentifier:aCellIdentifier
              numberOfSections:1
     numberOfRowInSectionBlock:nil
                 cellShowBlock:aCellShowBlock];
}


#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.numberOfRowBlock) {
        return self.numberOfRowBlock(section);
    }
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentiter];
    id item = self.items[(NSInteger)indexPath.row];
    self.cellShowBlock(cell,item,indexPath);
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectRowAtIndexPath:)]) {
        [self.delegate selectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteRowAtIndexPath:)]) {
            [self.delegate deleteRowAtIndexPath:indexPath];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(isCellEditable)]) {
        return [self.delegate isCellEditable];
    }
    return NO;
}


@end
