//
//  PalModeMenuViewController.m
//  PalCard
//
//  Created by FlyinGeek on 13-2-1.
//  Copyright (c) 2013年 FlyinGeek. All rights reserved.
//

#import "PalModeMenuViewController.h"
#import "PalViewController.h"
#import "MCSoundBoard.h"

#define _BGPIC @"UIimages/main_bg.jpg"
#define _BGPIC2 @"UIimages/cloud-front.png"

#define _ModeChoiceLabelImg @"UIimages/difficulty_choice.png"
#define _EasyModeButtonImg @"UIimages/easy.png"
#define _EasyModeButtonPressedImg @"UIimages/easy_push.png"
#define _NormalModeButtonImg @"UIimages/normal.png"
#define _NormalModeButtonPressedImg @"UIimages/normal_push.png"
#define _HardModeButtonImg @"UIimages/hard.png"
#define _HardModeButtonPressedImg @"UIimages/hard_push.png"
#define _ReturnButtonImg @"UIimages/back.png"
#define _ReturnButtonPressedImg @"UIimages/back_push.png"

#define _ButtonPressedSound @"button_pressed.wav"
#define _MenuSelectedSound @"selected.wav"

#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)

@interface PalModeMenuViewController (){
    bool _soundOff;
}

@property (copy, nonatomic) NSString *mode;
@property (strong, nonatomic) IBOutlet UIImageView *bgPic;
@property (strong, nonatomic) IBOutlet UIImageView *bgPic2;
@property (strong, nonatomic) IBOutlet UIImageView *blackBG;
@property (strong, nonatomic) IBOutlet UIButton *easyButton;
@property (strong, nonatomic) IBOutlet UIButton *normalButton;
@property (strong, nonatomic) IBOutlet UIButton *hardButton;
@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIImageView *cloud1;
@property (strong, nonatomic) IBOutlet UIImageView *cloud2;
@property (strong, nonatomic) IBOutlet UIImageView *cloud3;
@property (strong, nonatomic) IBOutlet UIImageView *difChoice;

@end

@implementation PalModeMenuViewController



- (void)backgroundAnimation
{
    
    // Background  animation
    self.blackBG.alpha = 1.0;
    
    self.bgPic.image  = [UIImage imageNamed:_BGPIC];
    self.bgPic2.image = [UIImage imageNamed:_BGPIC2];
    
    self.bgPic2.alpha = 0.7;
    
    
    CGRect frame = self.bgPic.frame;
    frame.origin.x = 0;
    self.bgPic.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:20.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:9999];
    
    frame = self.bgPic.frame;
    frame.origin.x = -frame.size.width + 320;
    self.bgPic.frame = frame;
    
    [UIView commitAnimations];
    
    // cloud
    
    CGRect frame2 = self.bgPic2.frame;
    frame2.origin.x = 0;
    self.bgPic2.frame = frame2;
    
    [UIView beginAnimations:@"testAnimation2" context:NULL];
    [UIView setAnimationDuration:8.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:9999];
    
    frame2 = self.bgPic2.frame;
    frame2.origin.x = -frame2.size.width + 285;
    self.bgPic2.frame = frame2;
    
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    self.blackBG.alpha = 0.0f;
    [UIView commitAnimations];
    
    
}

- (void) restartAnimation{
    
    [self backgroundAnimation];

}

- (void)viewWillAppear:(BOOL)animated {
    
	[super viewWillAppear:animated];
    
    // register for later use:
    // restart animation when game enter to foreground
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
    
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void) viewDidDisappear:(BOOL)animated{
    
    // unregister when view disappear
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
	[self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self backgroundAnimation];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // I use storyboard to design UI for iphone 5
    // here are frame tweaks for iPhone 4/4S
    if (!DEVICE_IS_IPHONE5) {
        
        [self.difChoice setFrame:CGRectMake(40, 0, 240, 128)];
        
        [self.easyButton setFrame:CGRectMake(95, 120, 130, 78)];
        
        [self.normalButton setFrame:CGRectMake(95, 215, 130, 78)];
        
        [self.hardButton setFrame:CGRectMake(95, 310, 130, 78)];
        
        [self.cloud1 setFrame:CGRectMake(70, 95, 180, 120)];
        
        [self.cloud2 setFrame:CGRectMake(70, 195, 180, 120)];
        
        [self.cloud3 setFrame:CGRectMake(70, 290, 180, 120)];
        
        [self.returnButton setFrame:CGRectMake(250, 425, 50, 30)];
    }
    
    
    // set default images
    self.difChoice.image = [UIImage imageNamed:_ModeChoiceLabelImg];
    
    self.bgPic.image  = [UIImage imageNamed:_BGPIC];

    
    [self.easyButton setBackgroundImage:[UIImage imageNamed:_EasyModeButtonImg] forState:UIControlStateNormal];
    
    [self.easyButton setBackgroundImage:[UIImage imageNamed:_EasyModeButtonPressedImg] forState:UIControlStateHighlighted];

    [self.normalButton setBackgroundImage:[UIImage imageNamed:_NormalModeButtonImg] forState:UIControlStateNormal];
    
    [self.normalButton setBackgroundImage:[UIImage imageNamed:_NormalModeButtonPressedImg] forState:UIControlStateHighlighted];
    
    [self.hardButton setBackgroundImage:[UIImage imageNamed:_HardModeButtonImg] forState:UIControlStateNormal];
    
    [self.hardButton setBackgroundImage:[UIImage imageNamed:_HardModeButtonPressedImg] forState:UIControlStateHighlighted];
    
    [self.returnButton setBackgroundImage:[UIImage imageNamed:_ReturnButtonImg] forState:UIControlStateNormal];
    
    [self.returnButton setBackgroundImage:[UIImage imageNamed:_ReturnButtonPressedImg] forState:UIControlStateHighlighted];
    
    
    // check whether user has turned off sound
    NSString *turnOffSound = [[NSUserDefaults standardUserDefaults] valueForKey:@"turnOffSound"];
    
    if (turnOffSound) {
        
        if ([turnOffSound isEqualToString:@"YES"]) {
            _soundOff = YES;
        }
        else if ([turnOffSound isEqualToString:@"NO"]) {
            _soundOff = NO;
        }
    }

    if (!_soundOff) {
        [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:_MenuSelectedSound ofType:nil] forKey:@"selected"];
        [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:_ButtonPressedSound ofType:nil] forKey:@"button"];
    }
    
    
	
    // start background animation
    [self backgroundAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if (!_soundOff) {
        AVAudioPlayer *player = [MCSoundBoard audioPlayerForKey:@"MainBGM"];
        [player stop];
    }

    PalViewController *palVC = segue.destinationViewController;
    palVC.mode = self.mode;
    
    //[self.navigationController presentViewController:palVC animated:NO completion:nil];
    
}

- (IBAction)easyModeButtonPressed:(UIButton *)sender {
    
    if (!_soundOff) {
        [MCSoundBoard playSoundForKey:@"selected"];
    }
    self.mode = @"easy";
}

- (IBAction)normalModeButtonPressed:(UIButton *)sender {
    
    if (!_soundOff) {
        [MCSoundBoard playSoundForKey:@"selected"];
    }
    self.mode = @"normal";
}

- (IBAction)hardModeButtonPressed:(UIButton *)sender {
    
    if (!_soundOff) {
        [MCSoundBoard playSoundForKey:@"selected"];
    }
    self.mode = @"hard";
}


- (IBAction)returnButtonPressed:(UIButton *)sender {
    
    if (!_soundOff) {
        [MCSoundBoard playSoundForKey:@"button"];
    }
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}


- (void)viewDidUnload {
    [self setDifChoice:nil];
    [self setBgPic:nil];
    [self setBgPic2:nil];
    [self setBlackBG:nil];
    [self setCloud1:nil];
    [self setCloud2:nil];
    [self setCloud3:nil];
    [self setEasyButton:nil];
    [self setHardButton:nil];
    [self setNormalButton:nil];
    [super viewDidUnload];
}
@end
