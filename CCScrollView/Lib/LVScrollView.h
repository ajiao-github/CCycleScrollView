//
//  LVScrollView.h
//
//  Created by ajiao on 16/7/11.
//  Copyright © 2016年 All rights reserved.
//

/*
*********************************************************************************
*
* 🌟🌟🌟 新建LVScrollView交流QQ群：277157761 🌟🌟🌟
*
* 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
* 帮您解决问题。
* Email : 2528982823@qq.com
* GitHub: https://github.com/ajiao-github
*
*********************************************************************************
*/


#import <UIKit/UIKit.h>

@interface LVScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame withAnimationDuration:(NSTimeInterval)animationDuration withLoacalImage:(BOOL)isLocalImg withImageArr:(NSArray *)imageArr andWithPlaceHoldImage:(UIImage *)placeHoldImage;

@end
