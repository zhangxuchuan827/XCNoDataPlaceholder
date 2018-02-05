//
//  ZXCNoDataPlaceholder.h
//  PlaceholderDemo
//
//  Created by 张绪川 on 2018/2/5.
//  Copyright © 2018年 zhangxuchuan. All rights reserved.
//

#ifndef ZXCNoDataPlaceholder_h
#define ZXCNoDataPlaceholder_h

#import <Foundation/Foundation.h>

/**
 网络状态检测 正常Return YßES ,网络不可达 Return NO
 */
static BOOL (^zxcBackgroundImageNetStateBlock)(void) ;


#import "UICollectionView+NoDataPlaceHolder.h"
#import "UITableView+NoDataPlaceholder.h"


#endif /* ZXCNoDataPlaceholder_h */
