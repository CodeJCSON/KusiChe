//
//  SettingViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/2/27.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "SettingTabViewController.h"
#import "UIBarButtonItem+GFBarButtonItem.h"
#import "GFHomeNavViewController.h"

@interface SettingTabViewController ()

@end

@implementation SettingTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

#pragma mark initView
- (void)initView {
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:244.0/255.0 blue:239.0/255.0 alpha:1];
    [self.tableView setScrollEnabled:YES];
    [self setExtraCellLineHidden:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] highImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] target:(GFHomeNavViewController *)self.navigationController action:@selector(popToRoot) forControlEvents:UIControlEventTouchDown];
}


-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *setttingCell = [tableView dequeueReusableCellWithIdentifier:@"setttingCell"];
    if (!setttingCell) {
        setttingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"setttingCell"];
    }
    setttingCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            setttingCell.textLabel.text = @"账户安全";
        } else if (indexPath.row == 1) {
            setttingCell.textLabel.text = @"联系客服";
        } else if (indexPath.row == 2) {
            setttingCell.textLabel.text = @"用户指南";
        }
        
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            setttingCell.textLabel.text = @"法律条款";
        } else if (indexPath.row == 1) {
            setttingCell.textLabel.text = @"意见与反馈";
        } else if (indexPath.row == 2) {
            setttingCell.textLabel.text = @"关于快递";
        } else if (indexPath.row == 3) {
            setttingCell.textLabel.text = @"给好评";
        }
    }
    return setttingCell;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int i = 0;
    if (section == 0) {
        i = 3;
    } else if (section == 1) {
        i = 4;
    }
    return i;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *heightForSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRE_WIDTH, 10)];
    heightForSectionView.backgroundColor = [UIColor clearColor];
    return heightForSectionView;
}

@end
