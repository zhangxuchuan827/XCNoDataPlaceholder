//
//  UITableView+reload.m
//  StandardMVVM
//
//  Created by 张绪川 on 2018/2/2.
//  Copyright © 2018年 张绪川. All rights reserved.
//

#import "UITableView+NoDataPlaceholder.h"
#import <objc/runtime.h>


const char * imageDelegateKey = "imageDelegateKey";
const char * refreshBtnKey = "refreshBtnKey";


@implementation UITableView (NoDataPlaceholder)

-(void)xc_reloadData{
    [self reloadData];
    
    //若两个都没有实现，则不继续执行
    if ( !([self.backgroundImageDelegate respondsToSelector:@selector(tableViewErrorBackgroundImage)] ||
        [self.backgroundImageDelegate respondsToSelector:@selector(tableViewBackgroundImageSize)] )) {
        return;
    }
    
    [self clearBackgroundView];

    
    //判断-有判断工具并且网络不正常
    if ( self.visibleCells.count <= 0 && xcBackgroundImageNetStateBlock && !xcBackgroundImageNetStateBlock() ) {
        
        [self loadNormalBackgroundView];
        return;
    }
    
    
    
    if (self.visibleCells.count <= 0) {
        [self loadNormalBackgroundView];
    }
    
}



#pragma mark -

- (void)loadNormalBackgroundView{
    
    if (![self.backgroundImageDelegate respondsToSelector:@selector(tableViewNoDataBackgroundImage)]  ) {
        return;
    }
    if (![self.backgroundImageDelegate tableViewNoDataBackgroundImage] ) {
        return;
    }
    
    CGSize size = [self tableViewBackgroundImageDefaultSize];
    
    if ([self.backgroundImageDelegate respondsToSelector:@selector(tableViewBackgroundImageSize)]) {
        size  = [self.backgroundImageDelegate tableViewBackgroundImageSize];
    }
    
    UIImageView * normalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,size.width , size.height)];
    normalView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    normalView.image = [[self.backgroundImageDelegate tableViewErrorBackgroundImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.backgroundView addSubview:normalView];
    [self addRefureshButton];
}

- (void)loadErrorBackgroundView{
    
    if (![self.backgroundImageDelegate respondsToSelector:@selector(tableViewErrorBackgroundImage)]  ) {
        return;
    }
    if (![self.backgroundImageDelegate tableViewErrorBackgroundImage] ) {
        return;
    }
    
    CGSize size = [self tableViewBackgroundImageDefaultSize];
    
    if ([self.backgroundImageDelegate respondsToSelector:@selector(tableViewBackgroundImageSize)]) {
        size  = [self.backgroundImageDelegate tableViewBackgroundImageSize];
    }
    
    UIImageView * normalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 ,size.width , size.height)];
    normalView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    normalView.image = [[self.backgroundImageDelegate tableViewErrorBackgroundImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.backgroundView addSubview:normalView];
    [self addRefureshButton];
}

- (void)addRefureshButton{
    
    if (!self.refreshButton) {
        return;
    }
    
    UIView * placeholderImgView = self.backgroundView.subviews.firstObject;
    
    CGFloat y = self.refreshButton.bounds.size.height/2 + CGRectGetMaxY(placeholderImgView.frame) + 20;
    
    self.refreshButton.center = CGPointMake(placeholderImgView.center.x, y );
    
    [self.backgroundView addSubview:self.refreshButton];
    
}

- (void)clearBackgroundView{
    
    
    [self.backgroundView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    }
}


#pragma mark -




- (CGSize)tableViewBackgroundImageDefaultSize{
    
    return CGSizeMake(200, 200);
}

#pragma mark -

-(id<UITableViewBackgroundImageDelegate>)backgroundImageDelegate{
    return objc_getAssociatedObject(self, imageDelegateKey);
}
-(void)setBackgroundImageDelegate:(id<UITableViewBackgroundImageDelegate>)backgroundImageDelegate{
    objc_setAssociatedObject(self, imageDelegateKey, backgroundImageDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)refreshButton{
    return objc_getAssociatedObject(self, refreshBtnKey);
}
-(void)setRefreshButton:(UIButton *)refreshButton{
    objc_setAssociatedObject(self, refreshBtnKey, refreshButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end
