//
//  DLCompanyNewsOneSmallPictureCell.m
//  DLAppStore
//
//  Created by 小星星吃KFC on 2020/9/24.
//  Copyright © 2020 江苏电力信息技术有限公司. All rights reserved.
//

#import "DLCompanyNewsOneSmallPictureCell.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>
@implementation DLCompanyNewsOneSmallPictureCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _initUI];
    }
    return self;
}

-(void)_initUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.dateLabel];
    [self.bgView addSubview:self.contentImageView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView);
        make.left.equalTo(self.bgView);
        make.right.mas_lessThanOrEqualTo(self.contentImageView.mas_left).mas_offset(-9);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.mas_lessThanOrEqualTo(self.contentImageView.mas_left).mas_offset(-9);
        make.bottom.equalTo(self.contentImageView);
    }];
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
        make.width.equalTo(self.bgView).multipliedBy(0.33);
    }];
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView.alloc init];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel.alloc init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel.alloc init];
        _dateLabel.font = [UIFont systemFontOfSize:11];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.alpha = 0.4;
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.numberOfLines = 1;
    }
    return _dateLabel;
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [UIImageView.alloc init];
        _contentImageView.layer.cornerRadius = 6;
    }
    return _contentImageView;
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end