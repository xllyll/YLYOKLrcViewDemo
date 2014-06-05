//
//  YLYViewController.m
//  OKLRCDemo
//
//  Created by 楊盧银Mac on 14-5-15.
//  Copyright (c) 2014年 com.yly16. All rights reserved.
//

#import "YLYViewController.h"
#import "YLYOKLRCView.h"
#import "YLYMusicLRC.h"
#import <AVFoundation/AVFoundation.h>

@interface YLYViewController ()
{
    int _count;
}
@property (strong , nonatomic)AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet YLYOKLRCView *lrcView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (strong , nonatomic)NSMutableArray *list;
@end

@implementation YLYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
	// Do any additional setup after loading the view, typically from a nib.
    
    

}
- (IBAction)playMusic:(id)sender {
    _count = 0;
    NSString *path1 =[[NSBundle mainBundle]pathForResource:@"月半小夜曲" ofType:@"mp3"];
    NSURL *url = [[NSURL alloc]initFileURLWithPath:path1];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [self.player play];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"李克勤 - 月半夜小夜曲" ofType:@"lrc"];
    YLYMusicLRC *lrc = [[YLYMusicLRC alloc]initWithLRCFile:path];
    self.list = lrc.lrcList;
    
    //更新ing歌曲播放时间
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateMusicTimeLabel) userInfo:self repeats:YES];
}

//TODO:更新ing歌曲播放时间
-(void)updateMusicTimeLabel{
    if ((int)self.player.currentTime % 60 < 10) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:0%d",(int)self.player.currentTime / 60, (int)self.player.currentTime % 60];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:%d",(int)self.player.currentTime / 60, (int)self.player.currentTime % 60];
    }
    
    NSDictionary *dic = self.list[_count];
    NSArray *array = [dic[@"lrctime"] componentsSeparatedByString:@":"];//把时间转换成秒
    NSUInteger currentTime = [array[0] intValue] * 60 + [array[1] intValue];
    //判断是否播放歌词
    if (self.player.currentTime >= currentTime && _isPlayLrcing == NO) {
        [self.lrcView beganLrc:self.list];
        _isPlayLrcing = YES;
    }
     
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
