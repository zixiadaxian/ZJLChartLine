//
//  ZJLChartLine.h
//  ZJLChartLine
//
//  Created by HiPal on 16/4/5.
//  Copyright © 2016年 Hipal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJLChartLine;
@protocol ZJLChartDataSource <NSObject>
@required
/**
 *  @param chart 配置多条轨迹线线段
 *
 */
- (NSMutableArray *)zjlChartLineYValues:(ZJLChartLine *)chart;
/**
 *  X 数值
 */
- (NSArray *)zjlChartLineXLabel:(ZJLChartLine *)chart;
/**
 *  Y轴多少行
 */
- (NSInteger )zjlChartLineYCount:(ZJLChartLine *)chart;
/**
 *  Y 最大值
 */
- (CGFloat)zjlChartLineYMaxValue:(ZJLChartLine *)chart;
@end

@interface ZJLChartLine : UIView

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(id<ZJLChartDataSource>)dataSource;


@end
