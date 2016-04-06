//
//  ZJLChartLine.m
//  ZJLChartLine
//
//  Created by HiPal on 16/4/5.
//  Copyright © 2016年 Hipal. All rights reserved.
//

#import "ZJLChartLine.h"

static const CGFloat chart_X_Y_Label    = 50.f; //X Y  label高度
static const CGFloat chartLine_To_Top_Span      = 30.f; // 距离顶部高度 右边
static const CGFloat chartLine_To_Line_Span      = 70.0; // X 网格间距

@interface ZJLChartLine ()

@property (nonatomic, weak) id<ZJLChartDataSource>dataSource;

@property (nonatomic  ,strong) NSMutableArray   *yValues;
@property (nonatomic  ,strong) NSArray          *xLabels;
@property (nonatomic  ,assign) CGFloat          yMax;
@property (nonatomic  ,assign) NSInteger        yLineCount;
@property (nonatomic  ,strong) UIScrollView     *scrollView;
@property (nonatomic  ,strong) UIView           *lineView;
@end


@implementation ZJLChartLine
{
    CGRect _viewFrame;
}
- (instancetype)initWithFrame:(CGRect)frame withDataSource:(id<ZJLChartDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor grayColor];
        
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
        if (chart_X_Y_Label + chartLine_To_Line_Span * _yLineCount < _viewFrame.size.width) {
            self.scrollView.contentSize = CGSizeMake(_viewFrame.size.width , 0);
        }else{
            self.scrollView.contentSize = CGSizeMake(chart_X_Y_Label + chartLine_To_Line_Span * (_xLabels.count-1)+chartLine_To_Top_Span , 0);
        }
        
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, chart_X_Y_Label + chartLine_To_Line_Span *( _xLabels.count -1 ), _viewFrame.size.height)];
        [_scrollView addSubview:_lineView];
    }
    return _lineView;
}
/**
 *  添加X轴线
 */
- (void)add_X_Line {
    UIBezierPath * path = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    for (NSInteger i = 0; i <= _yLineCount; i++) {
        
        [path moveToPoint:CGPointMake(chart_X_Y_Label, chartLine_To_Top_Span + ((_viewFrame.size.height -  chart_X_Y_Label-chartLine_To_Top_Span)/_yLineCount )* i)];
        [path addLineToPoint:CGPointMake(chart_X_Y_Label + chartLine_To_Line_Span * (_xLabels.count -1),  chartLine_To_Top_Span + ((_viewFrame.size.height -  chart_X_Y_Label-chartLine_To_Top_Span)/_yLineCount )* i)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 0.3f;
        [self.lineView.layer addSublayer:shapeLayer];
    }
}
/**
 *  添加Y轴线
 */
- (void)add_Y_Line {
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    for (NSInteger i = 0; i < _xLabels.count; i++) {
        [path moveToPoint:CGPointMake(chart_X_Y_Label+  chartLine_To_Line_Span*i,chartLine_To_Top_Span)];
        [path addLineToPoint:CGPointMake(chart_X_Y_Label+  chartLine_To_Line_Span*i, _lineView.frame.size.height-chart_X_Y_Label)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 0.3f;
        [self.lineView.layer addSublayer:shapeLayer];
    }
}
/**
 *  添加X标题
 */
- (void)add_X_Label{
    for (int i = 0; i < _xLabels.count; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(chart_X_Y_Label - 5 +chartLine_To_Line_Span*i , _lineView.frame.size.height - chart_X_Y_Label , chartLine_To_Line_Span, chart_X_Y_Label)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:10.f];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = _xLabels[i];
        [self.lineView addSubview:label];
    }
}
/**
 *  添加Y标题
 */
- (void)add_Y_Label{
    
    CGFloat y_Value = _yMax / _yLineCount ;
    for (NSInteger i = 0; i <= _yLineCount ; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,  ((_lineView.frame.size.height - chartLine_To_Top_Span-chart_X_Y_Label)/ _yLineCount * i), chartLine_To_Line_Span, chart_X_Y_Label)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:10.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%.0f", _yMax - y_Value * i];
        [self.lineView addSubview:label];
    }
}
- (void)reloadData{

    [self add_X_Line];
    [self add_Y_Line];
    [self add_X_Label];
    [self add_Y_Label];
    
}



@end
