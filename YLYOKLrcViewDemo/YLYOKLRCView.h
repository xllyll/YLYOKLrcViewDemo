//
//  YLYOKLRCView.h
//  OKLRCDemo
//
//  Created by 楊盧银Mac on 14-5-15.
//  Copyright (c) 2014年 com.yly16. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YLYOKLRCView : UIView
{
    //V2.0>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    int _numberOfLrc;
    float _courrentNumber;
}
@property (copy   , nonatomic)NSString *lrcStr;
@property (strong , nonatomic)UILabel  *lrcLabel;
@property (strong , nonatomic)UIView   *OKlrcView;
@property (strong , nonatomic)UILabel  *OKlrcLabel;
@property (strong , nonatomic)NSMutableArray *OKlrcList;
@property (strong , nonatomic)NSMutableArray *LrcList;
@property (strong , nonatomic)NSMutableArray *TimeList;


//V2.0>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//--------------------普通模式--------------------
- (void)beganLrc:(NSMutableArray*)list;
@end
