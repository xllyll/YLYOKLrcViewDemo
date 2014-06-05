//
//  YLYOKLRCView.m
//  OKLRCDemo
//
//  Created by 楊盧银Mac on 14-5-15.
//  Copyright (c) 2014年 com.yly16. All rights reserved.
//

#import "YLYOKLRCView.h"

@implementation YLYOKLRCView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self comfig];
    }
    return self;
}
-(void)awakeFromNib{
    [self comfig];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)comfig{
    
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    self.clipsToBounds = YES;
    _courrentNumber = 0.0f;
    self.lrcLabel = [[UILabel alloc]initWithFrame:self.bounds];
    self.lrcLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:self.lrcLabel];
    
    
    
    self.OKlrcView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _courrentNumber+29, self.bounds.size.height)];
    [self.OKlrcView setBackgroundColor:[UIColor clearColor]];
    self.OKlrcView.clipsToBounds = YES;
    [self addSubview:self.OKlrcView];
    
    self.OKlrcLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.OKlrcLabel.textColor = [UIColor redColor];
    self.OKlrcLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.OKlrcView addSubview:self.OKlrcLabel];
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    self.OKlrcList = [[NSMutableArray alloc]init];
    self.LrcList = [[NSMutableArray alloc]init];
    self.TimeList = [[NSMutableArray alloc]init];
    
}
-(void)setOKLRCLabelString:(NSString *)string{
    //设置字体,包括字体及其大小
    UIFont *font = self.lrcLabel.font;
    self.OKlrcView.clipsToBounds = YES;
    CGSize titleSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    float x = (self.frame.size.width-titleSize.width)/2;
    if (string.length == 0) {
        titleSize.width = 20;
    }
    self.lrcLabel.frame = CGRectMake(x, 0, titleSize.width, self.frame.size.height);
    self.OKlrcView.frame = CGRectMake(x, 0, 0, self.OKlrcView.frame.size.height);
    self.lrcStr = string;
    
    self.lrcLabel.text = self.lrcStr;
    self.OKlrcLabel.text = self.lrcStr;

}

//TODO:V2.0>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//--------------------普通模式--------------------
-(void)beganLrc:(NSMutableArray *)list{
    _numberOfLrc = 0;
    self.LrcList = list;
    NSDictionary *rootDic = [self.LrcList firstObject];
    [self setOKLRCLabelString:[rootDic objectForKey:@"lrc"]];
    int i = 0;
    for (NSDictionary *dic in self.LrcList) {
        i++;
        NSString *timeStr = [dic objectForKey:@"lrctime"];
        NSArray *array = [timeStr componentsSeparatedByString:@":"];//把时间转换成秒
        float currentTime = [array[0] floatValue] * 60 + [array[1] floatValue];
        if (i >= self.LrcList.count) {
            currentTime = 10;
        }
        else{
            NSDictionary *dic2 = [self.LrcList objectAtIndex:i];
            timeStr = [dic2 objectForKey:@"lrctime"];
            array = [timeStr componentsSeparatedByString:@":"];//把时间转换成秒
            float currentTime2 = [array[0] floatValue] * 60 + [array[1]floatValue];
            currentTime = currentTime2 - currentTime;
        }
        [self.TimeList addObject:[NSNumber numberWithFloat:currentTime]];
    }
    [self firstUpdate:[[self.TimeList firstObject] floatValue]];
}

-(void)firstUpdate:(float)time{
    _courrentNumber= 0;
    NSLog(@"%f",time);
    time = time/self.lrcLabel.frame.size.width;
    
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(updateLrcView:) userInfo:self repeats:YES];
}
-(void)updateLrcView:(NSTimer*)sender{
    
    
    if (self.OKlrcView.frame.size.width > self.lrcLabel.frame.size.width){
        _numberOfLrc++;
        [self setOKLRCLabelString:[[self.LrcList objectAtIndex:_numberOfLrc] objectForKey:@"lrc"]];
        [self firstUpdate:[[self.TimeList objectAtIndex:_numberOfLrc] floatValue]];
        [sender invalidate];
    }
    self.OKlrcView.frame = CGRectMake(self.OKlrcView.frame.origin.x, 0, _courrentNumber, self.OKlrcView.frame.size.height);
    _courrentNumber++;
}
@end
