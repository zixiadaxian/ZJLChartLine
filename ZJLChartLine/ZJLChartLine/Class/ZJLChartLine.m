//
//  ZJLChartLine.m
//  ZJLChartLine
//
//  Created by HiPal on 16/4/5.
//  Copyright © 2016年 Hipal. All rights reserved.
//

#import "ZJLChartLine.h"

@interface ZJLChartLine ()

@property (nonatomic, weak) id<ZJLChartDataSource>dataSource;

@property (nonatomic  ,strong) NSMutableArray   *yValues;
@property (nonatomic  ,strong) NSMutableArray   *xLabels;
@property (nonatomic  ,assign) CGFloat          yMax;
@property (nonatomic  ,assign) NSInteger        yLineCount;
@end

@implementation ZJLChartLine

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(id<ZJLChartDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = dataSource;
    }
    return self;
}

@end
