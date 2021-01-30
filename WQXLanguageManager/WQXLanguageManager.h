//
//  WQXLanguageManager.h
//  WQXTools
//
//  Created by 温群香 on 2021/1/29.
//

/**
 使用步骤：
 1. 创建一个名为 WQXLocalizations 的 strings 文件
 2. 点击 WQXLocalizations.strings
 3. 点击 Xcode 右上角的 Inspectors 按钮
 4. 在 Localizations 选项点击 Localize...
 5. 点击项目 -> PROJECT -> Localizations 点击+添加你需要支持的语言
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WQXLanguageManager : NSObject

/** 1. 设置支持的语言 (传国际语言缩写，例如：zh-Hans) */
+ (void)wqx_setSupportedLanguages:(NSArray <NSString *> *)languages;

/** 2. 设置当前语言 (key是国际语言缩写，例如：zh-Hans) */
+ (void)wqx_setCurrentAppLanguageWithKey:(NSString *)key;

/** 3. 通过key获取对应的国际化字符串 (key不是国际语言缩写) */
+ (NSString *)wqx_localizedStringWithKey:(NSString *)key;

/**
 获取当前语言 (这里返回的是国际语言缩写，例如：zh-Hans)
 如果没有设置过语言，则会获取系统当前语言
 如果支持的语言里不包含系统当前语言，则会默认使用英语
 */
+ (NSString *)wqx_getCurrentAppLanguage;

@end

NS_ASSUME_NONNULL_END
