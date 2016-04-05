//
//  ViewController.m
//  SNChartView
//
//  Created by wangsen on 15/12/25.
//  Copyright © 2015年 wangsen. All rights reserved.
//

#import "ViewController.h"
#import "SNChart.h"
@interface ViewController () <SNChartDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SNChart * chart = [[SNChart alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100) withDataSource:self andChatStyle:SNChartStyleLine];
    chart.curve = YES;//曲线 折线开关
    [chart showInView:self.view];
}

- (NSMutableArray *)chatConfigYValue:(SNChart *)chart {
    
    
    NSArray *arr1 = @[@"0.1",@"0.5",@"1.70",@"0.30",@"0.50",@"1.04",@"0.7",@"0.14",@"0.14",@"0.14"];
    NSArray *arr2 = @[@"0.3",@"0.2",@"1.60",@"0.35",@"0.20",@"0.14",@"0.5",@"0.20",@"0.12",@"0.12"];
    
    return [NSMutableArray arrayWithObjects:arr1,arr2, nil];
}

- (NSArray *)chatConfigXValue:(SNChart *)chart {
    return @[@"12-1",@"12-2",@"12-3",@"12-4",@"12-5",@"12-6",@"12-7",@"12-8",@"12-9",@"12-10"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
