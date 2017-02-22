//
//  PersonalnfoViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/2/27.
//  Copyright © 2016年 goofyy. All rights reserved.
//
#import "PersonalnfoTabViewController.h"
#import "UIBarButtonItem+GFBarButtonItem.h"
#import "GFHomeNavViewController.h"
#import "UIView+Extend.h"

@interface PersonalnfoTabViewController ()

@end

@implementation PersonalnfoTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -initView
- (void)initView {
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:241.0/255.0 blue:235.0/255.0 alpha:1];
    [self.tableView setScrollEnabled:YES];
    [self setExtraCellLineHidden:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] highImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] target:(GFHomeNavViewController *)self.navigationController action:@selector(popToRoot) forControlEvents:UIControlEventTouchDown];
}

#pragma customFunction 
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//250 244 239

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *persondetalcell = [tableView dequeueReusableCellWithIdentifier:@"persondetalcell"];

    if (!persondetalcell) {
        persondetalcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"persondetalcell"];
    }
    persondetalcell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            persondetalcell.textLabel.text = @"头像";
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
            imageView.layer.cornerRadius = imageView.width/2;
            imageView.layer.masksToBounds = YES;
            imageView.image = [UIImage imageNamed:@"touxiang"];
            persondetalcell.accessoryView = imageView;
        } else if (indexPath.row == 1) {
            persondetalcell.textLabel.text = @"昵称";
            UITextField *te = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, SCRE_WIDTH/2, 40)];
            te.textAlignment = NSTextAlignmentRight;
            te.text = @"Goofyy";
            persondetalcell.accessoryView = te;
        } else if(indexPath.row == 2) {
            persondetalcell.textLabel.text = @"性别";
            UILabel *personalSexLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
            personalSexLabel.text = @"请选择";
            personalSexLabel.textAlignment = NSTextAlignmentRight;
            persondetalcell.accessoryView = personalSexLabel;
            
        } else if (indexPath.row == 3) {
            persondetalcell.textLabel.text = @"年龄";
            UILabel *personalAgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
            personalAgeLabel.text = @"请选择";
            personalAgeLabel.textAlignment = NSTextAlignmentRight;
            persondetalcell.accessoryView = personalAgeLabel;
        }
    } else if (indexPath.section == 1 ) {
        
        if(indexPath.row == 0) {
            persondetalcell.textLabel.text = @"我的签名";
            UITextField *te = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, SCRE_WIDTH/2, 40)];
            te.textAlignment = NSTextAlignmentRight;
            te.text = @"开心就好";
            persondetalcell.accessoryView = te;
        }
       
    }
    
    
    return persondetalcell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i = 0;
    if (section == 0) {
        i = 4;
    } else if(section == 1) {
        i = 2;
    }

    return i;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *heightForSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRE_WIDTH, 10)];
    heightForSectionView.backgroundColor = [UIColor clearColor];
    return heightForSectionView;
}
@end
