//
//  WChart.m
//  WChartView
//
//  Created by wangsen on 15/12/24.
//  Copyright © 2015年 wangsen. All rights reserved.
//

#import "SNChart.h"
#import "SNChartLine.h"
@interface SNChart ()
@property (nonatomic, strong) UIScrollView * myScrollView;
@property (nonatomic, strong) SNChartLine * chartLine;
@property (nonatomic, weak) id<SNChartDataSource>dataSource;
@property (nonatomic, assign) SNChartStyle chartStyle;
@end
@implementation SNChart

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(id<SNChartDataSource>)dataSource andChatStyle:(SNChartStyle)chartStyle {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        self.dataSource = dataSource;
        self.chartStyle = chartStyle;
        self.curve = NO;
    }
    return self;
}


- (void)startDraw {
    
    self.myScrollView.frame = self.bounds;
    self.chartLine = [[SNChartLine alloc] initWithFrame:self.bounds];
    [self.myScrollView addSubview:self.chartLine];
    
    NSMutableArray * yArray = [self.dataSource chatConfigYValue:self];
    NSArray * xArray = [self.dataSource chatConfigXValue:self];
//    NSInteger count = xArray.count - yArray.count;
    
//    if (count > 0) {
//        
//        for (NSInteger i = 0; i < count; i++) {
//            [yArray addObject:@(0).stringValue];
//
//        }
//    }
    
    NSArray * sourtArray = [yArray[0] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj2 floatValue] > [obj1 floatValue];
    }];
    
    self.chartLine.yMax = [sourtArray.firstObject floatValue];
    self.chartLine.curve = self.curve;
    [self.chartLine setXValues:xArray];
    [self.chartLine setYValues:yArray];
    
    [self.chartLine startDrawLines];
    
    self.myScrollView.contentSize = CGSizeMake(chartLineTheXAxisSpan * xArray.count + chartLineStartX, 0);
    CGRect frame = self.chartLine.frame;
    frame.size.width = chartLineStartX + xArray.count * chartLineTheXAxisSpan;
    self.chartLine.frame = frame;
   
}

- (void)showInView:(UIView *)view {
    [self startDraw];
    [view addSubview:self];
}

- (UIScrollView *)myScrollView {
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] init];
        [self addSubview:_myScrollView];
    }
    return _myScrollView;
}
@end
