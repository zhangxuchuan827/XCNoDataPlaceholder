//
//  CollectionVC.m
//  PlaceholderDemo
//
//  Created by 张绪川 on 2018/2/5.
//  Copyright © 2018年 zhangxuchuan. All rights reserved.
//

#import "CollectionVC.h"
#import "ZXCNoDataPlaceholder.h"

#import "ViewController.h"

@interface CollectionVC()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewPlaceholderImageDelegate>

@property (nonatomic , strong)UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation CollectionVC


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"CollectionView";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataSource = [NSMutableArray new];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.placeholderImageDelegate = self;
    [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:_collectionView];
    
    UIBarButtonItem * go = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(go)];
    
    UIBarButtonItem * add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    UIBarButtonItem * clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clear)];
    UIBarButtonItem * refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItems = @[go,add,clear,refresh];
}

- (void)add{
    
    NSInteger i = 0;
    
    while (i++ < 5) {
        [self.dataSource addObject:@(i)];
    }
    
    
}
- (void)clear{
    
    [self.dataSource removeAllObjects];
    
    [self refresh];
}
- (void)refresh{
    
    [self.collectionView reloadData];
}

- (void)go{
    
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}


#pragma mark -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *  cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    label.text = [NSString stringWithFormat:@"-%ld-",indexPath.row];
    [cell.contentView addSubview:label];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50, 50);
}

#pragma mark - mark
-(UIImage *)CollectionViewNoDataPlaceholderImage{
    return [UIImage imageNamed:@"noData"];
}

-(UIButton *)CollectionViewPlaceholderRefreshButton{
    UIButton * refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    refreshButton.layer.masksToBounds = YES;
    refreshButton.layer.cornerRadius = 4;
    refreshButton.layer.borderWidth = 1;
    refreshButton.layer.borderColor = [UIColor grayColor].CGColor;
    [refreshButton setTitle:@"点击刷新" forState:UIControlStateNormal];
    [refreshButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    return refreshButton;
}


-(void)dealloc{
    
    NSLog(@"销毁了CollectionVC");
}


@end
