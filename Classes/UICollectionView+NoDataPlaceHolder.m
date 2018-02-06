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


@implementation UICollectionView (NoDataPlaceHolder)


+ (void)load{
    Method old = class_getInstanceMethod(self, @selector(reloadData));
    Method current = class_getInstanceMethod(self, @selector(zxc_reloadData));
    method_exchangeImplementations(old, current);
}


- (void)zxc_reloadData{
    [self zxc_reloadData];
    
    //若两个都没有实现，则不继续执行
    if ( !([self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewNoDataPlaceholderImage)] ||
           [self.placeholderImageDelegate respondsToSelector:@selector(CollectionViewErrorPlaceholderImage)] )) {
        return;
    }
    
    [self clearBackgroundView];
    
    //判断-有判断工具并且网络不正常
    if ( ![self hasSomeCells] && zxcPlaceholderImageNetStateBlock && !zxcPlaceholderImageNetStateBlock() ) {
        
        [self loadNormalBackgroundView];
        return;
    }
    
    if (![self hasSomeCells]) {
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

- (BOOL)hasSomeCells{
    if ([self.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        
        if ([self.dataSource respondsToSelector:@selector(numberOfItemsInSection:)]) {
            
            NSInteger sections = [self.dataSource numberOfSectionsInCollectionView:self];
            
            if(sections > 1){
                
                for (int i = 0; i < sections; i++) {
                    if ([self.dataSource collectionView:self numberOfItemsInSection:i] > 0) {
                        return YES;
                    }
                }
                
            }
        }
        
        if ([self.dataSource collectionView:self numberOfItemsInSection:0] > 0) {
            return YES;
        }
    }
    
    return NO;
}


- (CGSize)defaultPlaceholderSize{
    
    return CGSizeMake(200, 200);
}

#pragma mark -

-(id<UITableViewPlaceholderImageDelegate>)placeholderImageDelegate{
    return objc_getAssociatedObject(self, imageDelegateKey_cl);
}
-(void)setPlaceholderImageDelegate:(id<UITableViewPlaceholderImageDelegate>)placeholderImageDelegate{
    objc_setAssociatedObject(self, imageDelegateKey_cl, placeholderImageDelegate, OBJC_ASSOCIATION_ASSIGN);
}





@end
