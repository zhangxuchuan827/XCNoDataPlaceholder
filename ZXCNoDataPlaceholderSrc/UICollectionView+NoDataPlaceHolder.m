//
//  UICollectionView+NoDataPlaceHolder.m
//  StandardMVVM
//
//  Created by 张绪川 on 2018/2/5.
//  Copyright © 2018年 张绪川. All rights reserved.
//

#import "UICollectionView+NoDataPlaceHolder.h"
#import "ZXCNoDataPlaceholder.h"
#import <objc/runtime.h>

const char * imageDelegateKey_cl = "imageDelegateKey_cl";
const char * refreshBtnKey_cl = "refreshBtnKey_cl";


@implementation UICollectionView (NoDataPlaceHolder)


-(void)zxc_reloadData{
    [self reloadData];
    
    //若两个都没有实现，则不继续执行
    if ( !([self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewNoDataPlaceholderImage)] ||
           [self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewErrorPlaceholderImage)] )) {
        return;
    }
    
    [self clearBackgroundView];
    
    
    //判断-有判断工具并且网络不正常
    if ( self.visibleCells.count <= 0 && zxcPlaceholderImageNetStateBlock && !zxcPlaceholderImageNetStateBlock() ) {
        
        [self loadNormalBackgroundView];
        return;
    }
    
    
    
    if (self.visibleCells.count <= 0) {
        [self loadNormalBackgroundView];
    }
    
}



#pragma mark -

- (void)loadNormalBackgroundView{
    
    if (![self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewNoDataPlaceholderImage)]  ) {
        return;
    }
    if (![self.placeholderImageDelegate CollectionViewNoDataPlaceholderImage] ) {
        return;
    }
    
    CGSize size = [self defaultPlaceholderSize];
    
    if ([self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewPlaceholderImageSize)]) {
        size  = [self.placeholderImageDelegate CollectionViewPlaceholderImageSize];
    }
    
    UIImageView * normalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,size.width , size.height)];
    normalView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    normalView.image = [[self.placeholderImageDelegate CollectionViewNoDataPlaceholderImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.backgroundView addSubview:normalView];
    [self addRefureshButton];
}

- (void)loadErrorBackgroundView{
    
    if (![self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewErrorPlaceholderImage)]  ) {
        return;
    }
    if (![self.placeholderImageDelegate CollectionViewErrorPlaceholderImage] ) {
        return;
    }
    
    CGSize size = [self defaultPlaceholderSize];
    
    if ([self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewPlaceholderImageSize)]) {
        size  = [self.placeholderImageDelegate CollectionViewPlaceholderImageSize];
    }
    
    UIImageView * normalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 ,size.width , size.height)];
    normalView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    normalView.image = [[self.placeholderImageDelegate CollectionViewErrorPlaceholderImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.backgroundView addSubview:normalView];
    [self addRefureshButton];
}

- (void)addRefureshButton{
    
    if (!( [self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewPlaceholderRefreshButton)] &&
          [self.placeholderImageDelegate CollectionViewPlaceholderRefreshButton] ) ) {
        return;
    }
    
    UIView * placeholderImgView = self.backgroundView.subviews.firstObject;
    
    UIButton * refreshButton = [self.placeholderImageDelegate CollectionViewPlaceholderRefreshButton];
    
    CGFloat y = refreshButton.bounds.size.height/2 + CGRectGetMaxY(placeholderImgView.frame) + 20;
    
    refreshButton.center = CGPointMake(placeholderImgView.center.x, y );
    
    [self.backgroundView addSubview:refreshButton];
    
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




- (CGSize)defaultPlaceholderSize{
    
    return CGSizeMake(200, 200);
}

#pragma mark -

-(id<UITableViewPlaceholderImageDelegate>)placeholderImageDelegate{
    return objc_getAssociatedObject(self, imageDelegateKey_cl);
}
-(void)setPlaceholderImageDelegate:(id<UITableViewPlaceholderImageDelegate>)placeholderImageDelegate{
    objc_setAssociatedObject(self, imageDelegateKey_cl, placeholderImageDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)refreshButton{
    return objc_getAssociatedObject(self, refreshBtnKey_cl);
}
-(void)setRefreshButton:(UIButton *)refreshButton{
    objc_setAssociatedObject(self, refreshBtnKey_cl, refreshButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end
