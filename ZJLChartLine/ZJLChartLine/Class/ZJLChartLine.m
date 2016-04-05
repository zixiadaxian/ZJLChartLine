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
@property (nonatomic  ,strong) NSArray          *xLabels;
@property (nonatomic  ,assign) CGFloat          yMax;
@property (nonatomic  ,assign) NSInteger        yLineCount;
@end


@implementation ZJLChartLine
{
    CGRect _viewFrame;
}
- (instancetype)initWithFrame:(CGRect)frame withDataSource:(id<ZJLChartDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = dataSource;
        
        _viewFrame = frame;
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(zjlChartLineYMaxValue:)]) {
            _yMax = [self.dataSource zjlChartLineYMaxValue:self];
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(zjlChartLineYValues:)]) {
            _yValues = [self.dataSource zjlChartLineYValues:self];
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(zjlChartLineXLabel:)]) {
            _xLabels = [self.dataSource zjlChartLineXLabel:self];
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(zjlChartLineYCount:)]) {
            _yLineCount = [self.dataSource zjlChartLineYCount:self];
        }
        
    }
    return self;
}
/**
 *  添加X轴线
 */
- (void)add_X_Line {
    
}
/**
 *  添加Y轴线
 */
- (void)add_Y_Line {
    
}
/**
 *  添加X标题
 */
- (void)add_X_Label{

}
- (void)reloadData{

    [self add_X_Line];
    [self add_Y_Line];
    [self add_X_Label];
}



@end
