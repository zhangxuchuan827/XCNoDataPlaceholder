# ZXCNoDataPlaceholder
一个简单医用的UITableView和UICollectionView的空数据占位图，可区分实现网络错误状态和空数据状态

![数据图片](./img.png)

## 使用说明

1.引用头文件ZXCNoDataPlaceholder.h

2.遵循协议，实现对应的代理方法


## TableViewProtocol

```
/**
 无数据占位图
 */
- (UIImage *)tableViewNoDataPlaceholderImage;
/**
 网络错误的占位图，需要实现网络检测zxcBackgroundImageNetStateBlock  
 */
- (UIImage *)tableViewErrorPlaceholderImage;
/**
 占位图尺寸。默认200*200
 */
- (CGSize)tableViewPlaceholderImageSize;
/**
 刷新按钮
 */
- (UIButton *)tableViewPlaceholderRefreshButton;

```
注意：若要实现网络错误状态下显示相应占位图需给zxcBackgroundImageNetStateBlock赋值 return YES表示网络正常


## TableViewDemo

```
<UITableViewPlaceholderImageDelegate>

//-----

_tableView.placeholderImageDelegate = self;

//------

- (UIImage *)tableViewNoDataPlaceholderImage{
    return [UIImage imageNamed:@"noData"];
}

- (UIImage *)tableViewErrorPlaceholderImage{
	return [UIImage imageNamed:@"netErr"];
}

-(UIButton *)tableViewPlaceholderRefreshButton{
    UIButton * refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    return refreshButton;
}


```

## 更改说明
在 +load 将 reloadData 和 zxc_reloadData 做了方法交换， 若有特定需求可做相应修改。

## 具体代码见Demo （CollectionView使用方式相同）


