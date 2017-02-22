//
//  CourierCollectionViewController.m
//  CaoCaoKD
//
//  Created by goofygao on 16/2/26.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "CourierCollectionViewController.h"
#import "GFCollectionViewFlowLayout.h"
#import "CouierCollectionViewCell.h"

@interface CourierCollectionViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UITextField *searchNewCouierTextField;

@property (nonatomic,strong) UICollectionView *couierCollectionView;

@end

@implementation CourierCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (UICollectionView *)couierCollectionView {
    if (!_couierCollectionView) {
        GFCollectionViewFlowLayout *cellLayout = [[GFCollectionViewFlowLayout alloc]init];
        _couierCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchNewCouierTextField.frame) + 30, SCRE_WIDTH, SCRE_HEIGHT * 2/3) collectionViewLayout:cellLayout];
        
        _couierCollectionView.backgroundColor = [UIColor clearColor];
        _couierCollectionView.bounces = YES;
        _couierCollectionView.bouncesZoom = YES;
        _couierCollectionView.alwaysBounceHorizontal = YES;
        _couierCollectionView.pagingEnabled = YES;
        _couierCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _couierCollectionView.showsHorizontalScrollIndicator = NO;
        _couierCollectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
        _couierCollectionView.delegate = self;
        _couierCollectionView.dataSource = self;
        [_couierCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _couierCollectionView.showsVerticalScrollIndicator = NO;
    }
    return _couierCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark initView 初始化视图
- (void)initView {
    self.title = @"快递员收藏夹";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"couier_collection_bg"]];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CouierCollectionViewCell class]) bundle:nil];
    [self.couierCollectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];

    
    //搜索按钮
    self.searchNewCouierTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 84, SCRE_WIDTH - 60, 35)];
    _searchNewCouierTextField.background = [UIImage imageNamed:@"couier_search_bg"];
    _searchNewCouierTextField.layer.cornerRadius = 15.0;
    _searchNewCouierTextField.layer.masksToBounds = YES;
    _searchNewCouierTextField.placeholder = @"搜索快递员";
    _searchNewCouierTextField.font = [UIFont systemFontOfSize:14];
    [[UITextField appearance] setTintColor:[UIColor orangeColor]];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 35)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 20, 20)];
    searchImageView.image = [UIImage imageNamed:@"couier_search_search_icon"];
    [leftView addSubview:searchImageView];
    _searchNewCouierTextField.leftView = leftView;
    _searchNewCouierTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_searchNewCouierTextField];
    
    [self.view addSubview:self.couierCollectionView];
}

#pragma mark <UICollectionViewDataSource,UICollectionViewDelegate>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CouierCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}



- (UIEdgeInsets)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    CGSize firstSize = CGSizeMake(SCRE_WIDTH * 3/5, SCRE_HEIGHT/2);
    CGSize lastSize = CGSizeMake(SCRE_WIDTH * 3/5, SCRE_HEIGHT/2);
    return UIEdgeInsetsMake(0, (collectionView.bounds.size.width - firstSize.width) / 2,
                            0, (collectionView.bounds.size.width - lastSize.width) / 2);
    
    
}



@end
