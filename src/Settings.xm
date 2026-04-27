#import <UIKit/UIKit.h>

#define kYTetoCategory 910001

@interface YTSettingsSectionItem : NSObject
+ (instancetype)itemWithTitle:(NSString *)title titleDescription:(NSString *)titleDescription accessibilityIdentifier:(NSString *)identifier detailTextBlock:(id)detailTextBlock selectBlock:(BOOL (^)(id, NSUInteger))selectBlock;
@end

@interface YTIIcon : NSObject
@property (nonatomic, assign) NSInteger iconType;
@end

@interface YTSettingsViewController : UIViewController
- (void)setSectionItems:(NSMutableArray *)items forCategory:(NSUInteger)category title:(NSString *)title icon:(id)icon titleDescription:(NSString *)titleDescription headerHidden:(BOOL)headerHidden;
- (YTSettingsSectionItem *)_ytetoRow:(NSString *)title subtitle:(NSString *)subtitle url:(NSString *)url;
@end

@interface YTSettingsGroupData : NSObject
+ (NSMutableArray<NSNumber *> *)tweaks;
@end

%hook YTSettingsGroupData
+ (NSMutableArray<NSNumber *> *)tweaks {
    NSMutableArray *tweaks = %orig;
    if (![tweaks containsObject:@(kYTetoCategory)]) [tweaks addObject:@(kYTetoCategory)];
    return tweaks;
}
%end

%hook YTSettingsViewController
- (void)updateSectionForCategory:(NSUInteger)category withEntry:(id)entry {
    %orig;
    if (category != kYTetoCategory) return;

    YTIIcon *icon = [%c(YTIIcon) new];
    icon.iconType = 44;

    [self setSectionItems:@[
        [self _ytetoRow:@"👤  GGiuliano93 ›"             subtitle:@"Follow me on my Socials!"                                   url:@"https://x.com/ggiuliano93"],
        [self _ytetoRow:@"❤️  Support the development ›" subtitle:@"Only if you really want~"                                   url:@"https://ko-fi.com/ggiuliano93"],
        [self _ytetoRow:@"🔗  GitHub Repository ›"       subtitle:@"Star the repo, request a feature or report a bug."          url:@"https://github.com/ggiuliano93/YTeto"],
        [self _ytetoRow:@"🤝  Credits ›"                 subtitle:@"Open source libraries and collaborators. Support/Donate." url:@"https://github.com/ggiuliano93/YTeto#credits"],
    ].mutableCopy forCategory:kYTetoCategory title:@"YTeto" icon:icon titleDescription:nil headerHidden:NO];
}

%new
- (YTSettingsSectionItem *)_ytetoRow:(NSString *)title subtitle:(NSString *)subtitle url:(NSString *)url {
    return [%c(YTSettingsSectionItem) itemWithTitle:title
                                   titleDescription:subtitle
                            accessibilityIdentifier:nil
                                    detailTextBlock:nil
                                        selectBlock:^BOOL(id cell, NSUInteger idx) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
        return YES;
    }];
}
%end
