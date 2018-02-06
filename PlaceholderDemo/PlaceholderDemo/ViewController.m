//
//  ViewController.m
//  PlaceholderDemo
//
//  Created by 张绪川 on 2018/2/5.
//  Copyright © 2018年 zhangxuchuan. All rights reserved.
//

#import "ViewController.h"
#import "ZXCNoDataPlaceholder.h"

#import "CollectionVC.h"

@interface ViewController ()<UITableViewDataSource,ZXCNoDataPlaceholderProtocol>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"TableView";
    
    _dataSource = [NSMutableArray new];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.placeholderImageDelegate = self;
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
    UIBarButtonItem * go  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(go)];
    
    UIBarButtonItem * add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    UIBarButtonItem * clear = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clear)];
    UIBarButtonItem * refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItems = @[go,add,clear,refresh];
}

#pragma mark - name

- (void)add{
    
    NSInteger i = 0;
    
    while (i++ < 5) {
        [self.dataSource addObject:@(i)];
    }
    
    //[self refresh];
    
}
- (void)clear{
    
    [self.dataSource removeAllObjects];
    
    [self refresh];
}
- (void)refresh{
    
    [self.tableView reloadData];
}

- (void)go{
    
    zxcPlaceholderNetState = YES;
    
    [self.navigationController pushViewController:[CollectionVC new] animated:YES];
}

#pragma mark - name

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"-%ld-",indexPath.row];
    return cell;
}

#pragma mark - name

- (UIImage *)PlaceholderNoDataImage{
    return [UIImage imageNamed:@"noData"];
}
- (UIImage *)PlaceholderNetErrorImage{
    return [UIImage imageNamed:@"netErr"];
}

-(UIButton *)PlaceholderRefreshButton{
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

- (UIOffset)PlaceholderOffset{
    return UIOffsetMake(0, -150);
}

-(void)dealloc{
    
    NSLog(@"销毁了ViewController");
}



@end
