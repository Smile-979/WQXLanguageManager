//
//  ViewController0.m
//  WQXLanguageManagerDemo
//
//  Created by 温群香 on 2021/1/29.
//

#import "ViewController0.h"

#import "WQXLanguageManager.h"

@interface ViewController0 ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController0

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.label = [[UILabel alloc] init];
    self.label.frame = CGRectMake(16, 300, 0, 0);
    self.label.text = [WQXLanguageManager wqx_localizedStringWithKey:@"hello, world"];
    self.label.font = [UIFont systemFontOfSize:17];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
    [self layoutLabel];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:) name:@"AppCurrentLanguageDidChangeNotificationName"
                                               object:nil];
}

- (void)layoutLabel {
    CGRect frame = self.label.frame;
    frame.size = [self.label sizeThatFits:CGSizeMake(self.view.frame.size.width - 32, HUGE)];
    if (frame.size.width < self.view.frame.size.width - 32) {
        frame.size.width = self.view.frame.size.width - 32;
    }
    self.label.frame = frame;
}

- (void)didReceiveNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:@"AppCurrentLanguageDidChangeNotificationName"]) {
        self.label.text = [WQXLanguageManager wqx_localizedStringWithKey:@"hello, world"];
        [self layoutLabel];
    }
}

@end
