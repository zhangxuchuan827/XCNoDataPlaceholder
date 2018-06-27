//
//  UICollectionView+NoDataPlaceHolder.h
//  StandardMVVM
//
//  Created by 张绪川 on 2018/2/5.
//  Copyright © 2018年 张绪川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCNoDataPlaceholderProtocol.h"

@interface UICollectionView (NoDataPlaceHolder)

@property (weak) id<XCNoDataPlaceholderProtocol> placeholderImageDelegate;

/**
 刷新占位图
 */
- (void)refreshPlaceholderView;



@end
