//
//  AudioStudy.h
//  AudioTest
//
//  Created by shinyv on 2018/5/14.
//  Copyright © 2018年 shinyv. All rights reserved.
//

#ifndef AudioStudy_h
#define AudioStudy_h

#define AUDIO_URL @"http://devimages.apple.com/iphone/samples/bipbop/gear4/prog_index.m3u8"

#pragma mark - 后台播放设置
/*
 1.首先在AppDelegate.m的- (BOOL)application:didFinishLaunchingWithOptions:方法中添加代码
 
AVAudioSession *session = [AVAudioSession sharedInstance];
[session setCategory:AVAudioSessionCategoryPlayback error:nil];
[session setActive:YES error:nil];
 
 AVAudioSessionCategoryAmbient          //混音播放，可以与其他音频应用同时播放
 AVAudioSessionCategorySoloAmbient      //独占播放
 AVAudioSessionCategoryPlayback         //后台播放，也是独占的
 AVAudioSessionCategoryRecord           //录音模式，用于录音时使用
 AVAudioSessionCategoryPlayAndRecord    //播放和录音，此时可以录音也可以播放
 AVAudioSessionCategoryAudioProcessing  //硬件解码音频，此时不能播放和录制
 AVAudioSessionCategoryMultiRoute       //多种输入输出，例如可以耳机、USB设备同时播放
 

 2.然后在Info.plist文件中添加
 <key>UIBackgroundModes</key>
 <array>
     <string>audio</string>
 </array>
 */


#pragma mark - 锁屏设置
/*
1. 在每次准备播放下一首时，更新锁屏信息：
MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];

MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"封面图片"]];

infoCenter.nowPlayingInfo = @{
                              MPMediaItemPropertyTitle :@"歌曲名",
                              MPMediaItemPropertyArtist :@"歌手名",
                              MPMediaItemPropertyPlaybackDuration :歌曲时间长度,
                              MPNowPlayingInfoPropertyElapsedPlaybackTime : @(已播放时间长度),
                              MPMediaItemPropertyArtwork : artwork
                              };
 
 
 2. 通过耳机、锁屏界面控制,在需要处理远程控制事件的具体控制器或其它类中调用下面这个方法
 #import <MediaPlayer/MPRemoteCommandCenter.h>
 #import <MediaPlayer/MPRemoteCommand.h>
 
 - (void)remoteControlEventHandler
 {
     // 直接使用sharedCommandCenter来获取MPRemoteCommandCenter的shared实例
     MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
 
     // 启用播放命令 (锁屏界面和上拉快捷功能菜单处的播放按钮触发的命令)
     commandCenter.playCommand.enabled = YES;
 
     // 为播放命令添加响应事件, 在点击后触发
     [commandCenter.playCommand addTarget:self action:@selector(playAction:)];
 
     // 播放, 暂停, 上下曲的命令默认都是启用状态, 即enabled默认为YES
     // 为暂停, 上一曲, 下一曲分别添加对应的响应事件
     [commandCenter.pauseCommand addTarget:self action:@selector(pauseAction:)];
 
     [commandCenter.previousTrackCommand addTarget:self action:@selector(previousTrackAction:)];
 
     [commandCenter.nextTrackCommand addTarget:self action:@selector(nextTrackAction:)];
 
     // 启用耳机的播放/暂停命令 (耳机上的播放按钮触发的命令)
     commandCenter.togglePlayPauseCommand.enabled = YES;
 
     // 为耳机的按钮操作添加相关的响应事件
     [commandCenter.togglePlayPauseCommand addTarget:self action:@selector(playOrPauseAction:)];
 }
 
 -(void)playAction:(id)obj{
     [[HYPlayerTool sharePlayerTool] play];
 }
 -(void)pauseAction:(id)obj{
     [[HYPlayerTool sharePlayerTool] pause];
 }
 -(void)nextTrackAction:(id)obj{
     [[HYPlayerTool sharePlayerTool] playNext];
 }
 -(void)previousTrackAction:(id)obj{
     [[HYPlayerTool sharePlayerTool] playPre];
 }
 -(void)playOrPauseAction:(id)obj{
     if ([[HYPlayerTool sharePlayerTool] isPlaying])
     {
         [[HYPlayerTool sharePlayerTool] pause];
     }else
     {
         [[HYPlayerTool sharePlayerTool] play];
     }
 }
 
 
 2.
 - (void)viewDidAppear:(BOOL)animated {
 //    接受远程控制
 [self becomeFirstResponder];
 [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
 }
 
 - (void)viewDidDisappear:(BOOL)animated {
 //    取消远程控制
 [self resignFirstResponder];
 [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
 }
 
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    if (event.type == UIEventTypeRemoteControl) {  //判断是否为远程控制
        switch (event.subtype) {
            case  UIEventSubtypeRemoteControlPlay:
                if (![_player isPlaying]) {
                    [_player play];
                }
                break;
            case UIEventSubtypeRemoteControlPause:
                if ([_player isPlaying]) {
                    [_player pause];
                }
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"下一首");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"上一首 ");
                break;
            default:
                break;
        }
    }
}
 */

#pragma mark - 震动
/*
 AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
 */

#pragma mark - 声音输出改变

/*
//添加通知，拔出耳机后暂停播放
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];

//一旦输出改变则执行此方法
//@param notification 输出改变通知对象

-(void)routeChange:(NSNotification *)notification{
    NSDictionary *dic=notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            [self.player pause];
        }
    }
}
 //这样就能在拔掉耳机的时候，暂停播放了
 */

#pragma mark - 短声音声音
/*
//播放系统声音
  SystemSoundID soundID;
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"44th Street Medium" ofType:@"caf"];

//    NSURL *url = [NSURL fileURLWithPath:path];

//    //为声音文件注册为系统声音
//    AudioServicesCreateSystemSoundID((CFURLRef)url, &soundID);

     2.AudioServicesCreateSystemSoundID(
     (__bridge CFURLRef)[NSURLfileURLWithPath:path], &soundID);
 

//    AudioServicesPlaySystemSound(soundID);//播放系统声音
      AudioServicesPlayAlertSound(soundID);  播放音频加震动
 
 2）关于__bridge
 
 Apple 通过 Core Foundation framework 提供了很多常用组件比如URL，array，string等C语言的接口，这可以让开发者可以直接编写C语言的代码来实现相关的功能而无需用Objective-C。所以如上面看到的CFURLRef在功能上等同于NSURL的指针。那么从iOS5开始，在使用ARC的情况下，开发者通过在特定的名称前面加上__bridge来提示编译器要将一个Objective-C的对象传递给一个C API下的对象。就是这样。
 */

#pragma mark - AVAudioPlayer
/*
 Class:
     AVAudioPlayer
     Note:可以通过音频的NSData或者本地音频文件的url，来创建一个AVAudioPlayer实例

 Object:
     player
 
 Relation:
     Note:支持音频格式
     AAC
     AMR (Adaptive multi-Rate，一种语音格式)
     ALAC (Apple lossless Audio Codec)
     iLBC (internet Low Bitrate Codec，另一种语音格式)
     IMA4 (IMA/ADPCM)
     linearPCM (uncompressed)
     u-law 和 a-law
     MP3 (MPEG-Laudio Layer 3)
 
 
 
 Method:
 1.- (nullable instancetype)initWithContentsOfURL:(NSURL *)url error:(NSError **)outError;

     Model: [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL]
     Note:从本地某个音频Path初始化类
 
   - (nullable instancetype)initWithData:(NSData *)data error:(NSError **)outError;
     Note:加载NSdata对象的音频文件，返回 AVAudioPlayer 对象
 
 2.- (BOOL)play;
 
     Model: [player play]
     Note:开始播放(异步)
 
 3.- (BOOL)pause;
 
     Model: [player pause]
     Note:暂停播放，可调用play方法从暂停点再次开始播放
 
 4.- (BOOL)stop;
 
     Model: [player stop]
      Note:停止播放，只能重新开始播放，stop会撤销prepareToPlay方法所做的准备。
 
 5.- (BOOL)prepareToPlay;
 
     Model: [player prepareToPlay]
     Note:准备播放，应在play方法前调用，这样可以提前获取需要的硬件支持，并加载音频到缓冲区。在调用   play方法时，减少开始播放的延迟。
 
 6.- (BOOL)playAtTime:(NSTimeInterval)time NS_AVAILABLE(10_7, 4_0);
     Note:在某个时间点播放
 
 7.- (void)updateMeters;
     Note:更新音频测量值，注意如果要更新音频测量值必须设置meteringEnabled为YES，通过音频测量值可以即时获得音频分贝等信息
 
 8.- (float)averagePowerForChannel:(NSUInteger)channelNumber;
     Note:获得指定声道的分贝峰值，注意如果要获得分贝峰值必须在此之前调用updateMeters方法
 
9.- (float)averagePowerForChannel:(NSUInteger)channelNumber;
 Note:平均音量
 
 10.- (float)peakPowerForChannel:(NSUInteger)channelNumber;
 Note:最高音量
 
 
 Property:
 1.@property(readonly, getter=isPlaying) BOOL playing;
 Note:是否在播放中
 
 2.@property(readonly) NSTimeInterval duration;
 Note:音频的时长
 
 3.@property float volume;
 Note:单独设置音乐的音量（默认1.0，可设置范围为0.0至1.0，两个极端为静音、系统音量
 
 4.@property float pan NS_AVAILABLE(10_7, 4_0);
 Note:修改左右声道的平衡（默认0.0，可设置范围为-1.0至1.0，两个极端分别为只有左声道、只有右声道）
 
 5.@property float rate NS_AVAILABLE(10_8, 5_0);
 Note:设置播放速度（默认1.0，可设置范围为0.5至2.0，两个极端分别为一半速度、两倍速度）
 
 6.@property NSInteger numberOfLoops;
 Note:设置循环播放（默认1，若设置值大于0，则为相应的循环次数，设置为-1可以实现无限循环）
 
 7.@property NSTimeInterval currentTime;
 NOote:当前播放时间点
 
 8.@property(readonly) NSTimeInterval deviceCurrentTime NS_AVAILABLE(10_7, 4_0);
 Note:输出设备播放音频的时间，注意如果播放中被暂停此时间也会继续累加
 
 9.@property(readonly, nullable) NSURL *url;
 Note:音频文件路径，只读
 
 10.@property(readonly, nullable) NSData *data;
 Note:音频数据，只读
 
 11.@property(nonatomic, copy, nullable) NSArray<AVAudioSessionChannelDescription *> *channelAssignments NS_AVAILABLE(10_9, 7_0);
 Note:获得或设置播放声道
 
 12.@property(getter=isMeteringEnabled) BOOL meteringEnabled;
 Note:可以监控音量变化

 13.@property(readonly) NSUInteger numberOfChannels;
 Note:得到音频的声道数目
 
 14.@property BOOL enableRate NS_AVAILABLE(10_8, 5_0);
 Note:是否允许改变播放速率 可以结合rete属性使用
 
 15.@property(readonly) NSDictionary *settings
 Note:音频播放设置信息，只读
 
 Delegate:
 1.- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
 Note:音频播放完成
 
 2.- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error;
 Note: 音频解码发生错误
 
 3.- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 8_0);
 Note:如果音频被中断，比如有电话呼入，该方法就会被回调，该方法可以保存当前播放信息，以便恢复继续播放的进度
 
 4.- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0);
 Model:  if(flags== AVAudioSessionInterruptionFlags_ShouldResume&&player!= nil) [player play];
 Note:中断事件结束,一般在此方法内重新播放音乐
 */


#pragma mark - AVPlayerItem
/*
 Class:
     AVPlayerItem
     Note:需同player一起使用。
 
 Object:
     playerItem
 
 Method:
 1.- (instancetype)initWithURL:(NSURL *)URL;
     Model:[[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlStr]];
     Note:通过本地，网络URL进行初始化
 
 2.+ (instancetype)playerItemWithURL:(NSURL *)URL;
     Note:便捷初始化
 
 Property:
 
 */

#pragma mark - AVPlayer
/*
 Class:
     AVPlayer
     Note:支持播放本地、分步下载、或在线流媒体音视频，不仅可以播放音频，配合AVPlayerLayer类可实现视频播放。另外支持播放进度监听。
     Note:支持格式
     支持视频格式： WMV，AVI，MKV，RMVB，RM，XVID，MP4，3GP，MPG等。
     支持音频格式：MP3，WMA，RM，ACC，OGG，APE，FLAC，FLV等。
 
 Object:
     player
 
 Method:
 1.- (instancetype)initWithPlayerItem:(nullable AVPlayerItem *)item
     Model:player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
     Note:通过AVPlayerItem对象初始化

 2.+ (instancetype)playerWithPlayerItem:(nullable AVPlayerItem *)item;
     Note:便捷初始化
 
 3.- (void)play;
     Note:播放
 
 4.- (void)pause;
     Note:暂停
 
 3.- (void)seekToTime:(CMTime)time;
         Model://根据值计算时间
         float time = sender.value * CMTimeGetSeconds(self.player.currentItem.duration);
         [self.player seekToTime:CMTimeMake(time, 1)];
     Note:跳转指定时间并播放
 
 Property:
 
 
 Relation:
 
 //播放视频时
 self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
 self.playerLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 500);
 [self.view.layer addSublayer:self.playerLayer];
 
 1.[self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
 Note:在准备播放前，通过KVO添加播放状态改变监听
 
 Model:-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
 {
     if ([keyPath isEqualToString:@"status"])
     {
         switch (self.player.status)
         {
             case AVPlayerStatusUnknown:
             {
                 NSLog(@"未知转态");
             }
             break;
             case AVPlayerStatusReadyToPlay:
             {
                 //进度
                 self.avSlider.maximumValue = self.playerItem.duration.value / self.playerItem.duration.timescale;
                 NSLog(@"准备播放");
             }
             break;
             case AVPlayerStatusFailed:
             {
                 NSLog(@"加载失败");
             }
             break;
 
             default:
                 break;
             }
 
         }
     }
     //移除监听（观察者）
     [object removeObserver:self forKeyPath:@"status"];
 }
 
 2.[self.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
 Note:KVO监听音乐缓冲状态
 
 -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
 
 {
 
     if ([keyPath isEqualToString:@"loadedTimeRanges"])
     {
 
         NSArray * timeRanges = self.player.currentItem.loadedTimeRanges;
         //本次缓冲的时间范围
         CMTimeRange timeRange = [timeRanges.firstObject CMTimeRangeValue];
 
         //缓冲总长度
         NSTimeInterval totalLoadTime = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
 
         //音乐的总时间
         NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
 
         //计算缓冲百分比例
         NSTimeInterval scale = totalLoadTime/duration;
 
         //更新缓冲进度条
         //self.loadTimeProgress.progress = scale;
     }
 }
 
 3.Note:开始播放时，通过AVPlayer的方法监听播放进度，并更新进度条（定期监听的方法）
 
__weak typeof(self) weakSelf = self;
[player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
    //当前播放的时间
    float current = CMTimeGetSeconds(time);
 
    //总时间
    float total = CMTimeGetSeconds(item.duration);
 
    if (current) {
        float progress = current / total;
        //更新播放进度条
        weakSelf.playSlider.value = progress;
    }
}];
 
 4.Note:开始播放后，通过KVO添加播放结束事件监听
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player.currentItem];
 */


 #pragma mark - AVQueuePlayer
/*
 
 Class:AVQueuePlayer
       Note:AVPlayer只支持单个媒体资源的播放，我们可以使用AVPlayer的子类AVQueuePlayer实现列表播放
 Object:
     queuePlayer
 
 Mothod:
 1.+ (instancetype)queuePlayerWithItems:(NSArray<AVPlayerItem *> *)items;
 Note:通过给定的AVPlayerItem数组创建一个AVQueuePlayer实例
 
 2.- (AVQueuePlayer *)initWithItems:(NSArray<AVPlayerItem *> *)items;
 Note:通过给定的AVPlayerItem数组初始化AVQueuePlayer实例
 
 3.- (NSArray<AVPlayerItem *> *)items;
 Note:获得当前的播放队列数组
 
 4.- (void)advanceToNextItem;
 Note:停止播放当前音乐，并播放队列中的下一首
 
 5.- (void)insertItem:(AVPlayerItem *)item afterItem:(nullable AVPlayerItem *)afterItem;
 Note:往播放队列中插入新的AVPlayerItem
 
 6.- (void)removeItem:(AVPlayerItem *)item;
 Note:从播放队列中移除指定AVPlayerItem
 
 7.- (void)removeAllItems;
 Note:清空播放队列
 
 Note:官方API中没找到播放上一首的方法，所以其实直接用AVPlayer做列表播放也是可以的，自己维护一个播放列表数组，监听用户点击上一首和下一首按钮，并监听播放结束事件，调用 AVPlayer 实例的replaceCurrentItemWithPlayerItem:方法传入播放列表中的上一首或下一首就行
 */

#pragma mark - AVPlayerViewController
#endif /* AudioStudy_h */
