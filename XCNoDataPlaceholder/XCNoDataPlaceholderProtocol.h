//
//  XCNoDataPlaceholderProtocol.h
//  PlaceholderDemo
//
//  Created by 张绪川 on 2018/2/6.
//  Copyright © 2018年 zhangxuchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

extern BOOL xcPlaceholderNetState ;

@protocol XCNoDataPlaceholderProtocol <NSObject>


@optional
/**
 无数据占位图
 */
- (UIImage *)PlaceholderNoDataImage;
/**
 网络错误的占位图，需要实现网络检测
 */
- (UIImage *)PlaceholderNetErrorImage;
/**
 占位图尺寸。默认200*200
 */
- (CGSize)PlaceholderImageSize;
/**
 图片位置调整
 */
- (UIOffset)PlaceholderOffset;
/**
 刷新按钮
 */
- (UIButton *)PlaceholderRefreshButton;


@end
