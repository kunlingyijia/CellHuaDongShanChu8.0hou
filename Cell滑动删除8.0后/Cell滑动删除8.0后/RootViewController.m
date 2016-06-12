//
//  RootViewController.m
//  Cell滑动删除8.0后
//
//  Created by 席亚坤 on 16/6/12.
//  Copyright © 2016年 席亚坤. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property(nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation RootViewController
//懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i<20; i++) {
        NSString * str = [NSString stringWithFormat:@"%d行",i];
        [self.dataArray addObject:str];

    }

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat: @"%@",_dataArray[indexPath.row]];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



//iOS 8.0 后才有的方法
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *shanchu = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除");
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    UITableViewRowAction * biaoqian = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"置顶");
        //插入
        [self.dataArray insertObject:_dataArray[indexPath.row] atIndex:0];
        //删除
        [self.dataArray removeObjectAtIndex:indexPath.row+1];
        //刷新
        [self.tableView reloadData];
       
    }];
    return @[shanchu,biaoqian];
}

@end
