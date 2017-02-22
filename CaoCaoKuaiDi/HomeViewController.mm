//
//  HomeViewController.m
//  66RentCar
//
//  Created by dyage on 15/12/22.
//  Copyright (c) 2015年 sole. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "YCXMenu.h"
#import "LeftHomeController.h"
#import "ScanBarCodeViewController.h"
#import "RecentOrdersViewController.h"
#import "CourierCollectionViewController.h"
#import "SearchExpressViewController.h"
#import "LoginHomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Extend.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "CustomAnnotationView.h"
#import "AddNewAddressViewController.h"
#import "REFrostedViewController.h"
#import "SystemWorksheetProcessViewController.h"


@interface HomeViewController () <UINavigationBarDelegate,UIActionSheetDelegate,CLLocationManagerDelegate,AMapSearchDelegate,MAMapViewDelegate>

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,strong) UIWindow *leftWindow;

@property (nonatomic,strong) UIView *leftView;

@property (nonatomic,strong) UIView *chooseExpressMaskView;

@property (nonatomic,strong) UIButton *choooseExpressTypeButton;

@property (nonatomic,strong) NSMutableArray *expressInfoArray;
/**
 *  更多快递选项button
 */
@property (nonatomic,strong) UIButton *expressMoreButton;

/**
 *  返回第一页快递选项button
 */
@property (nonatomic,strong) UIButton *expressLessButton;

@property (nonatomic,strong) MAMapView *mapView;

@property (nonatomic,strong) AMapSearchAPI *aMapSearch;

@property (nonatomic,strong) CLLocation *currentLocation;

@property (nonatomic,strong) CustomAnnotationView *annotationView;


@end


@implementation HomeViewController

#pragma mark getter/setter

-(NSMutableArray *)items {
    if(!_items) {
        _items = [NSMutableArray array];
        _items = [@[
                    [YCXMenuItem menuItem:@" 扫一扫"
                                    image:[UIImage imageNamed:@"home_iconfont-saoyisao"]
                                      tag:100
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@" 最近订单"
                                    image:[UIImage imageNamed:@"home_iconfont-dingdan"]
                                      tag:101
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@" 收藏快递员"
                                    image:[UIImage imageNamed:@"home_iconfont-shoucang"]
                                      tag:102
                                 userInfo:@{@"title":@"Menu"}]
                    
                    ] mutableCopy];
    }
    return _items;
}

/**
 *  地图设置
 *
 *  @return 返回基础地图类
 */

/**
 *  快递名字数组
 *
 *  @return 返回数组内容
 */
-(NSMutableArray *)expressInfoArray {
    if (!_expressInfoArray) {
        _expressInfoArray = [NSMutableArray array];
        _expressInfoArray = [@[
                               @"顺丰",
                               @"韵达",
                               @"申通",
                               @"EMS",
                               @"中通",
                               @"德邦",
                               
                               ] mutableCopy];
    }
    return _expressInfoArray;
}

-(UIView *)chooseExpressMaskView {
    if (!_chooseExpressMaskView) {
        _chooseExpressMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, SCRE_HEIGHT - 90, SCRE_WIDTH * 2, 40)];
        _chooseExpressMaskView.backgroundColor = [UIColor whiteColor];
    }
    return _chooseExpressMaskView;
}

-(CustomAnnotationView *)annotationView {
    if (!_annotationView) {
        _annotationView = [[CustomAnnotationView alloc]init];
    }
    return _annotationView;
}

-(MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(1, 64, SCRE_WIDTH - 1, SCRE_HEIGHT - 64)];
        _mapView.delegate = self;
        _mapView.mapType = MAMapTypeStandard;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
        
    }
    return _mapView;
}

#pragma mark -系统加载项
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBar];
    [self.view addSubview:self.mapView];
    
    [self.view addSubview:self.chooseExpressMaskView];
    [self initBottomView];
    [self initChoooseExpressTypeButton];
    _aMapSearch = [[AMapSearchAPI alloc]init];
    self.aMapSearch.delegate = self;
    
//    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}
//手势
//- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
//{
//    // Dismiss keyboard (optional)
//    //
//    [self.view endEditing:YES];
//    [self.frostedViewController.view endEditing:YES];
//    [self.frostedViewController panGestureRecognized:sender];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self) {
        self.navigationController.navigationBar.alpha = 0.300;
    }else{
        self.navigationController.navigationBar.alpha =1;
    }
}
#pragma mark 初始化- init
/**
 *  初始化navigationBar
 */
//初始化NAVIGATION BAR
-(void)initNavigationBar {
    self.title = @"快递";
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"home_navigation_left"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(pushPerCenter) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
    UIButton *rightItemButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 20, 40)];
    [rightItemButton setImage:[UIImage imageNamed:@"home_navigation_right"] forState:UIControlStateNormal];
    rightItemButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightItemButton addTarget:self action:@selector(rightBarButtonItemAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightItemButton];
}

//初始化底部Button
- (void)initBottomView {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCRE_HEIGHT - 50, SCRE_WIDTH, 50)];
    [self.view addSubview:bottomView];
    //画线
    UIBezierPath *straightLineBe = [UIBezierPath bezierPath];
    [straightLineBe moveToPoint:CGPointMake(0, 0)];
    [straightLineBe addLineToPoint:CGPointMake(SCRE_WIDTH, 0)];
    
    CAShapeLayer *shaperLayer = [[CAShapeLayer alloc]init];
    shaperLayer.strokeColor = [[UIColor blackColor]CGColor];
    shaperLayer.lineWidth = 0.2f;
    shaperLayer.path = straightLineBe.CGPath;
    [bottomView.layer addSublayer:shaperLayer];
    
    
    UIButton *callCourierButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, SCRE_WIDTH - 40, 40)];
    [callCourierButton setTitle:@"呼叫快递" forState:UIControlStateNormal];
    [callCourierButton setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:139.0/255.0 blue:23.0/255 alpha:1]];
    callCourierButton.layer.cornerRadius = 5.0;
    callCourierButton.layer.masksToBounds = YES;
    [callCourierButton setTintColor:[UIColor whiteColor]];
    [callCourierButton addTarget:self action:@selector(callCourierAction) forControlEvents:UIControlEventTouchDown];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:callCourierButton];
    
}
//初始化底部快递按钮
- (void)initChoooseExpressTypeButton {
    
    for (int i = 0; i < 5; i++) {
        self.choooseExpressTypeButton = [[UIButton alloc]init];
        _choooseExpressTypeButton.frame = CGRectMake( 15 * (i + 1) + i * (SCRE_WIDTH - 120)/5, 10, (SCRE_WIDTH - 120)/5, 20);
        _choooseExpressTypeButton.backgroundColor = [UIColor whiteColor];
        _choooseExpressTypeButton.layer.cornerRadius = 5;
        _choooseExpressTypeButton.layer.masksToBounds = YES;
        _choooseExpressTypeButton.layer.borderWidth = 0.5;
        _choooseExpressTypeButton.layer.borderColor = [[UIColor colorWithWhite:0.3 alpha:0.8]CGColor];
        _choooseExpressTypeButton.tag = 10 + i;
        _choooseExpressTypeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_choooseExpressTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [_choooseExpressTypeButton setTitle:self.expressInfoArray[i] forState:UIControlStateNormal];
        [_choooseExpressTypeButton addTarget:self action:@selector(chooseExpressAction:) forControlEvents:UIControlEventTouchDown];
        _chooseExpressMaskView.backgroundColor = [UIColor greenColor];
        [_chooseExpressMaskView addSubview:_choooseExpressTypeButton];
    }
    self.expressMoreButton = [[UIButton alloc]initWithFrame:CGRectMake(SCRE_WIDTH - 30, 10, 20, 20)];
//    _expressMoreButton.backgroundColor = [UIColor redColor];
    [_expressMoreButton addTarget:self action:@selector(expressMoreAction) forControlEvents:UIControlEventTouchDown];
    [_expressMoreButton setImage:[UIImage imageNamed:@"home_iconfont-shouqi"] forState:UIControlStateNormal];
    [_chooseExpressMaskView addSubview:_expressMoreButton];
    
    for (int i = 0; i < 5; i++) {
        self.choooseExpressTypeButton = [[UIButton alloc]init];
        _choooseExpressTypeButton.frame = CGRectMake( SCRE_WIDTH + 15 * (i + 1) + i * (SCRE_WIDTH - 120)/5, 10, (SCRE_WIDTH - 120)/5, 20);
        _choooseExpressTypeButton.backgroundColor = [UIColor whiteColor];
        _choooseExpressTypeButton.layer.cornerRadius = 5;
        _choooseExpressTypeButton.layer.masksToBounds = YES;
        _choooseExpressTypeButton.layer.borderWidth = 0.5;
        _choooseExpressTypeButton.layer.borderColor = [[UIColor colorWithWhite:0.3 alpha:0.8]CGColor];
        _choooseExpressTypeButton.tag = 20 + i;
        _choooseExpressTypeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_choooseExpressTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_choooseExpressTypeButton setTitle:self.expressInfoArray[i] forState:UIControlStateNormal];
        [_choooseExpressTypeButton addTarget:self action:@selector(chooseExpressAction:) forControlEvents:UIControlEventTouchDown];
        _chooseExpressMaskView.backgroundColor = [UIColor greenColor];
        [_chooseExpressMaskView addSubview:_choooseExpressTypeButton];
    }
    
    self.expressLessButton = [[UIButton alloc]initWithFrame:CGRectMake(SCRE_WIDTH * 2 - 30 , 10, 20, 20)];
    _expressLessButton.backgroundColor = [UIColor redColor];
    [_expressLessButton addTarget:self action:@selector(expressLessAction) forControlEvents:UIControlEventTouchDown];
    [_chooseExpressMaskView addSubview:_expressLessButton];
    
}

#pragma mark --action
//左按钮navigationitem点击
-(void)rightBarButtonItemAction {
    [YCXMenu setTintColor:[UIColor whiteColor]];
    if ([YCXMenu isShow]){
        [YCXMenu dismissMenu];
    } else {
        [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 50, 64, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            if (item.tag == 100) {
                
                [self.navigationController pushViewController:[[SearchExpressViewController alloc]init] animated:YES];
            } else if(item.tag == 101) {
                [self.navigationController pushViewController:[[RecentOrdersViewController alloc]init] animated:YES];
            } else if (item.tag == 102) {
                [self.navigationController pushViewController:[[CourierCollectionViewController alloc]init] animated:YES];
            }
        }];
    }
}

//左抽屉动画
-(void)pushPerCenter {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
//    LoginHomeViewController *loginHome = [[LoginHomeViewController alloc]init];
//    
//    [self.navigationController pushViewController:loginHome animated:YES];
    
    
}

//呼叫快递action
- (void)callCourierAction {
    
    [self.navigationController pushViewController:[[SystemWorksheetProcessViewController alloc]init] animated:YES];
}

//chooseExpressAction 查询附近的快递点。并在地图上显示
- (void)chooseExpressAction:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    
}

//更多快递
- (void)expressMoreAction {
    [UIView animateWithDuration:0.7 animations:^{
        _chooseExpressMaskView.x -= SCRE_WIDTH;
    }];
}

//返回更少快递（第一页）
- (void)expressLessAction {
    [UIView animateWithDuration:0.7 animations:^{
        _chooseExpressMaskView.x += SCRE_WIDTH;
    }];
}

//完善地址
- (void)completeAdressAction {
    
    [self.navigationController pushViewController:[[AddNewAddressViewController alloc]init] animated:YES];
}

//关于团和快的介绍
- (void)tuanORkuanIntrol {
    
}

//发起搜索请求
- (void)reGeoAction {
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude
                                                    longitude:_currentLocation.coordinate.longitude];
        [_aMapSearch AMapReGoecodeSearch:request];
    }
}

#pragma mark 调用系统定位


#pragma mark 高德地图回调delegate
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    static NSString *reuseIndetifier = @"annotationReuseIndetifier";
    self.annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
    if (_annotationView == nil)
    {
        self.annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
    }
    _annotationView.image = [UIImage imageNamed:@"up_door_pin_image"];
    _annotationView.canShowCallout = NO;
    _annotationView.centerOffset = CGPointMake(0, -18);
    return _annotationView;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    NSLog(@"%f,%f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    
    _currentLocation = [userLocation.location copy];
}

-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {

    if([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self reGeoAction];
    }
    [_annotationView.calloutView.completeAdressBtn addTarget:self action:@selector(completeAdressAction) forControlEvents:UIControlEventTouchDown];
    [_annotationView.calloutView.tuanORkuanBtn addTarget:self action:@selector(tuanORkuanIntrol) forControlEvents:UIControlEventTouchDown];
    
}

#pragma mark 高德地图搜索代理
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:
(AMapReGeocodeSearchResponse *)response
{

    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0)
    {
        title = response.regeocode.addressComponent.province;
    }
    NSLog(@"%@",response.regeocode.addressComponent.adcode);
}


//获取附近POI搜索的结果
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response.pois.count > 0)
    {
        AMapPOI *poi = response.pois[0];
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
        annotation.title = poi.name;
        annotation.subtitle = poi.address;
        [_mapView addAnnotation:annotation];
    }
}

@end
