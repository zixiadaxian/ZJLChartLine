//
//  UIBezierPath+Granularity.h
//  ZJLChartLine
//
//  Created by HiPal on 16/4/5.
//  Copyright © 2016年 Hipal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Granularity)
/**
 *  返回平滑的曲线   国外大神写的
 *
 *  @param granularity 两点之间插入多少个点(点越多 越平滑)
 */
- (UIBezierPath*)smoothedPathWithGranularity:(NSInteger)granularity;


@end
