//
//  UICollectionView+NoDataPlaceHolder.h
//  StandardMVVM
//
//  Created by 张绪川 on 2018/2/5.
//  Copyright © 2018年 张绪川. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionViewPlaceholderImageDelegate<NSObject>

@optional
/**
 无数据占位图
 */
- (UIImage *)CollectionViewNoDataPlaceholderImage;
/**
 网络错误的占位图，需要实现网络检测zxcBackgroundImageNetStateBlock
 */
- (UIImage *)CollectionViewErrorPlaceholderImage;
/**
 占位图尺寸。默认200*200
 */
- (CGSize)CollectionViewPlaceholderImageSize;
/**
 刷新按钮
 */
- (UIButton *)CollectionViewPlaceholderRefreshButton;


@end

@interface UICollectionView (NoDataPlaceHolder)

@property (nonatomic, weak) id<UICollectionViewPlaceholderImageDelegate> placeholderImageDelegate;

///刷新
-(void)zxc_reloadData;


@end
