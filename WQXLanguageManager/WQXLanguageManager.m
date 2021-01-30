//
//  WQXLanguageManager.m
//  WQXTools
//
//  Created by 温群香 on 2021/1/29.
//

#import "WQXLanguageManager.h"

@interface WQXLanguageManager ()

@property (nonatomic, copy) NSArray *wqx_languages;

@end

@implementation WQXLanguageManager

+ (instancetype)wqx_sharedManager {
    static WQXLanguageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WQXLanguageManager alloc] init];
    });
    return instance;
}

/** 1. 设置支持的语言 (传国际语言缩写，例如：zh-Hans) */
+ (void)wqx_setSupportedLanguages:(NSArray <NSString *> *)languages {
    if (!languages || ![languages isKindOfClass:[NSArray class]]) return;
    [WQXLanguageManager wqx_sharedManager].wqx_languages = languages;
}

/** 2. 设置当前语言 (key是国际语言缩写，例如：zh-Hans) */
+ (void)wqx_setCurrentAppLanguageWithKey:(NSString *)key {
    if (!key || ![key isKindOfClass:[NSString class]]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"WQXCurrentLanguageKey"];
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"WQXCurrentLanguageKey"];
    }
}

/** 3. 通过key获取对应的国际化字符串 (key不是国际语言缩写) */
+ (NSString *)wqx_localizedStringWithKey:(NSString *)key {
    NSString *language = [self wqx_getCurrentAppLanguage];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    return [[NSBundle bundleWithPath:path] localizedStringForKey:key
                                                           value:nil
                                                           table:@"WQXLocalizations"];
}

/**
 获取当前语言 (这里返回的是国际语言缩写，例如：zh-Hans)
 如果没有设置过语言，则会获取系统当前语言
 如果支持的语言里不包含系统当前语言，则会默认使用英语
 */
+ (NSString *)wqx_getCurrentAppLanguage {
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"WQXCurrentLanguageKey"];
    if (!language || ![language isKindOfClass:[NSString class]]) {
        language = [[NSLocale preferredLanguages] objectAtIndex:0];
    }
    if (![[WQXLanguageManager wqx_sharedManager].wqx_languages containsObject:language]) {
        language = @"en";
    }
    return language;
}

@end
