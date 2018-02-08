//
//  UICollectionView+NoDataPlaceHolder.h
//  StandardMVVM
//
//  Created by 张绪川 on 2018/2/5.
//  Copyright © 2018年 张绪川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCNoDataPlaceholderProtocol.h"

@interface UICollectionView (NoDataPlaceHolder)

@property (weak) id<ZXCNoDataPlaceholderProtocol> placeholderImageDelegate;

/**
 刷新占位图
 */
- (void)refreshPlaceholderView;



@end
