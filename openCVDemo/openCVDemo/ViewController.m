//
//  ViewController.m
//  openCVDemo
//
//  Created by 梁亦明 on 16/8/27.
//  Copyright © 2016年 xiaoming.com. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+OpenCV.h"
#import "DetailController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,assign) long row;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
static NSString *simpleTableIdentifier = @"cellid";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.row = indexPath.row;
    [self performSegueWithIdentifier:@"detail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailController *detail = (DetailController *)segue.destinationViewController;
    detail.row = _row;

}


-(NSArray *)array {
    if (!_array) {
        self.array = @[@"均值模糊", @"高斯模糊", @"双边平滑(美颜效果)", @"实现自己的线性滤波", @"Sobel 导数", @"Laplacian算子", @"Remapping重映射", @"卡通"];
    }
    return _array;
}

@end
