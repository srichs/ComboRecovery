//
//  CRTableViewCell.m
//  Combo Recovery
//
//  Created by srich on 11/7/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "CRTableViewCell.h"

@implementation CRTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
