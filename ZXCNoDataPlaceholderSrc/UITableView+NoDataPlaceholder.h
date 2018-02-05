//
//  UITableView+reload.h
//  StandardMVVM
//
//  Created by 张绪川 on 2018/2/2.
//  Copyright © 2018年 张绪川. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UITableViewPlaceholderImageDelegate<NSObject>

@optional
/**
 无数据占位图
 */
- (UIImage *)tableViewNoDataPlaceholderImage;
/**
 网络错误的占位图，需要实现网络检测zxcBackgroundImageNetStateBlock  
 */
- (UIImage *)tableViewErrorPlaceholderImage;
/**
 占位图尺寸。默认200*200
 */
- (CGSize)tableViewPlaceholderImageSize;
/**
 刷新按钮
 */
- (UIButton *)tableViewPlaceholderRefreshButton;

@end


@interface UITableView (NoDataPlaceholder)

@property (nonatomic, weak) id<UITableViewPlaceholderImageDelegate> placeholderImageDelegate;


///刷新
-(void)zxc_reloadData;


@end
