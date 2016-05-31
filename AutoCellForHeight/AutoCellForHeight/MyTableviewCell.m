
//
//  MyTableviewCell.m
//  AutoCellForHeight
//
//  Created by archy on 16/5/30.
//  Copyright © 2016年 archy. All rights reserved.
//

#import "MyTableviewCell.h"
#import "Masonry.h"
@interface MyTableviewCell ()

@property (nonatomic,strong)UILabel *titlable;

@property (nonatomic,strong)UILabel *ContentLable;

@property (nonatomic,strong)UIImageView *ContentImageview;
@property (nonatomic,strong)UILabel *UsernameLabel;

@property (nonatomic,strong)UILabel *timeLabel;
@end

@implementation MyTableviewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addContent];
        [self addLayout];
    }
    return self;
}
-(UILabel *)titlable
{
    if (!_titlable) {
        _titlable =[[UILabel alloc]init];
//        _titlable.backgroundColor =[UIColor redColor];
        _titlable.font =[UIFont systemFontOfSize:14];
        _titlable.textAlignment = NSTextAlignmentLeft;
    }
    return _titlable;
}
-(UILabel *)ContentLable
{
    if (!_ContentLable) {
        _ContentLable =[[UILabel alloc]init];
//        _ContentLable.backgroundColor =[UIColor greenColor];
        _ContentLable.font =[UIFont systemFontOfSize:13];
        _ContentLable.numberOfLines = 2;
    }
    return _ContentLable;
}
-(UIImageView *)ContentImageview
{
    if (!_ContentImageview) {
//        _ContentImageview.backgroundColor =[UIColor brownColor];
        _ContentImageview =[[UIImageView alloc]init];
    }
    return _ContentImageview;
}
-(UILabel *)UsernameLabel
{
    if (!_UsernameLabel) {
        _UsernameLabel =[[UILabel alloc]init];
        _UsernameLabel.font =[UIFont systemFontOfSize:12];
//        _UsernameLabel.backgroundColor =[UIColor orangeColor];
        _UsernameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _UsernameLabel;
}
-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel =[[UILabel alloc]init];
//        _timeLabel.backgroundColor =[UIColor redColor];
        _timeLabel.font =[UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}
-(void)addContent
{
    [self addSubview:self.titlable];
    [self addSubview:self.ContentLable];
    [self addSubview:self.UsernameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.ContentImageview];
 
}
-(void)addLayout
{
    [self.titlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self).offset(12);
        make.height.mas_equalTo(@15);
    }];
    [self.ContentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(12);
        make.right.mas_equalTo(self).offset(-12);
        make.top.mas_equalTo(self.titlable.mas_bottom).offset(12);
//         make.bottom.mas_equalTo(self.ContentImageview.mas_top).offset(12);
    }];

    
    [self.UsernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
//        make.top.mas_equalTo(self.ContentImageview.mas_bottom).offset(12);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-12);
        make.width.mas_equalTo(@120);
        make.height.mas_equalTo(20);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-12);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(120);
    }];
    [self.ContentImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
//        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.top.mas_equalTo(self.ContentLable.mas_bottom).offset(12);
        make.bottom.mas_equalTo(self.UsernameLabel.mas_top).offset(-12);
    }];
    
    }
-(void)setModel:(MydataModel *)Model
{
    self.titlable.text = Model.title;
    self.ContentLable.text = Model.content;
    self.ContentImageview.image = Model.imageName.length > 0 ? [UIImage imageNamed:Model.imageName] : nil;
    self.UsernameLabel.text = Model.username;
    self.timeLabel.text = Model.time;
}
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.timeLabel sizeThatFits:size].height;
    totalHeight += [self.ContentLable sizeThatFits:size].height;
    totalHeight += [self.ContentImageview sizeThatFits:size].height;
    totalHeight += [self.UsernameLabel sizeThatFits:size].height;
    totalHeight += 60; // margins 间距的累加
    return CGSizeMake(size.width, totalHeight);
}
@end
