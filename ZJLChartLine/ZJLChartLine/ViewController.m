//
//  ViewController.m
//  ZJLChartLine
//
//  Created by HiPal on 16/4/5.
//  Copyright © 2016年 Hipal. All rights reserved.
//

#import "ViewController.h"
#import "ZJLChartLine.h"

@interface ViewController ()<ZJLChartDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZJLChartLine *chartLine = [[ZJLChartLine alloc] initWithFrame:CGRectMake(0, 0, 320, 300) withDataSource:self];
    [self.view addSubview:chartLine];
    [chartLine reloadData];
}

#pragma mark --ZJLChartLineDataSource

/**
 *  返回多少行
 */
- (NSInteger)zjlChartLineYCount:(ZJLChartLine *)chart{
    return 5;
}
/**
 *  Y 轴最大值
 */
- (CGFloat)zjlChartLineYMaxValue:(ZJLChartLine *)chart {
    return 500;
}
/**
 *  X 轴 说明
 */
- (NSArray *)zjlChartLineXLabel:(ZJLChartLine *)chart {
    return @[@"1-1",@"1-2",@"1-3",@"1-4",@"1-5",@"1-6",@"1-7"];
}
/**
 *  曲线线段数量
 */
- (NSMutableArray *)zjlChartLineYValues:(ZJLChartLine *)chart {
    
    NSMutableArray *line1 = [NSMutableArray arrayWithObjects:@"0", @"500",@"10",@"500",@"10",@"150",@"10",nil];
    NSMutableArray *line2 = [NSMutableArray arrayWithObjects:@"0", @"150",@"60",@"70",@"0",@"40",@"0",nil];
    return [NSMutableArray arrayWithObjects:line1, line2,nil];
}
@end
