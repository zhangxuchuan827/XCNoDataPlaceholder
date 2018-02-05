//
//  UITableView+reload.h
//  StandardMVVM
//
//  Created by 张绪川 on 2018/2/2.
//  Copyright © 2018年 张绪川. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 网络状态检测 正常Return YES ,网络不可达 Return NO
 */
static BOOL (^xcBackgroundImageNetStateBlock)(void) ;



@protocol UITableViewBackgroundImageDelegate<NSObject>

@optional
/**
 无数据占位图
 */
- (UIImage *)tableViewNoDataBackgroundImage;
/**
 网络错误的占位图，需要实现网络检测xcBackgroundImageNetStateBlock  ↑
 */
- (UIImage *)tableViewErrorBackgroundImage;
/**
 占位图尺寸。默认200*200
 */
- (CGSize)tableViewBackgroundImageSize;

@end


@interface UITableView (NoDataPlaceholder)

@property (nonatomic, weak) id<UITableViewBackgroundImageDelegate> backgroundImageDelegate;

@property (nonatomic, weak) UIButton * refreshButton;

///刷新
-(void)xc_reloadData;


@end
