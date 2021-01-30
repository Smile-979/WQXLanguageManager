# WQXLanguageManager
几行代码搞定iOS语言国际化，支持多国语言手动切换。

# 安装
1. 打开终端更新本地库：pod repo update --verbose
2. 在 Podfile 中添加 pod 'WQXLanguageManager'
3. 执行 pod install

# 使用
1. 创建一个名为 WQXLocalizations 的 strings 文件
2. 点击 WQXLocalizations.strings
3. 点击 Xcode 右上角的 Inspectors 按钮
4. 在 Localizations 选项点击 Localize...
5. 点击项目 -> PROJECT -> Localizations 点击+添加你需要支持的语言
6. 设置支持的语言：
[WQXLanguageManager wqx_setSupportedLanguages:@[@"zh-Hans", @"en", @"ja", @"fr"]];
7. 设置当前语言：
[WQXLanguageManager wqx_setCurrentAppLanguageWithKey:@"zh-Hans"];
8. 显示文本：
label.text = [WQXLanguageManager wqx_localizedStringWithKey:@"hello, world"];
