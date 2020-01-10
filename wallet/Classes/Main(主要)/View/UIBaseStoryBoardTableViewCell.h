//
//  UIBaseStoryBoardTableViewCell.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBaseStoryBoardTableViewCell : UITableViewCell
/**
 这个方法是给使用StoryBoard获取ViewController里面的cell使用
 
 @param tableView ViewController 里面的cell
 @param identifier StoryBoard ->ViewController->UITableViewCell的标记（identifier）
 @return 返回 cell
 */

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
