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
- (UIImage *)PlaceholderNoDataImage;
/**
 网络错误的占位图，需要实现网络检测zxcPlaceholderImageNetStateBlock
 */
- (UIImage *)PlaceholderNetErrorImage;
/**
 占位图尺寸。默认200*200
 */
- (CGSize)PlaceholderImageSize;
/**
 刷新按钮
 */
- (UIButton *)PlaceholderRefreshButton;
/**
 图片位置调整
 */
- (UIOffset)PlaceholderOffset;


@end

@interface UICollectionView (NoDataPlaceHolder)

@property (weak) id<UICollectionViewPlaceholderImageDelegate> placeholderImageDelegate;

/**
 刷新占位图
 */
- (void)refreshPlaceholderView;



@end
