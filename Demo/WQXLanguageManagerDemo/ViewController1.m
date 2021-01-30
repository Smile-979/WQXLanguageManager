//
//  ViewController1.m
//  WQXLanguageManagerDemo
//
//  Created by 温群香 on 2021/1/29.
//

#import "ViewController1.h"

#import "WQXLanguageManager.h"

@interface ViewController1 ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *languages;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.languages = @[
    @{@"language": @"zh-Hans", @"title": @"简体中文"},
    @{@"language": @"en", @"title": @"English"},
    @{@"language": @"ja", @"title": @"にほんご"},
    @{@"language": @"fr", @"title": @"Français"}
    ];

    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
               cancelTitle:(NSString *)cancelTitle
             cancelHandler:(void (^)(void))cancelHandler
              confirmTitle:(NSString *)confirmTitle
            confirmHandler:(void (^)(void))confirmHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancelTitle && [cancelTitle isKindOfClass:[NSString class]] && cancelTitle.length > 0) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            cancelHandler ? cancelHandler() : nil;
        }];
        [alert addAction:cancel];
    }
    if (confirmTitle && [confirmTitle isKindOfClass:[NSString class]] && confirmTitle.length > 0) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            confirmHandler ? confirmHandler() : nil;
        }];
        [alert addAction:confirm];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString *currentLanguage = [WQXLanguageManager wqx_getCurrentAppLanguage];
    if ([currentLanguage isEqualToString:self.languages[indexPath.row][@"language"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = self.languages[indexPath.row][@"title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *currentLanguage = [WQXLanguageManager wqx_getCurrentAppLanguage];
    if ([currentLanguage isEqualToString:self.languages[indexPath.row][@"language"]]) return;
    [WQXLanguageManager wqx_setCurrentAppLanguageWithKey:self.languages[indexPath.row][@"language"]];
    [tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppCurrentLanguageDidChangeNotificationName"
                                                        object:nil];
    __weak typeof(self) weakSelf = self;
    [self showAlertWithTitle:@"温馨提示" message:@"语言设置已完成，是否前往查看？" cancelTitle:@"取消" cancelHandler:nil confirmTitle:@"前往查看" confirmHandler:^{
        weakSelf.tabBarController.selectedIndex = 0;
    }];
}

@end
