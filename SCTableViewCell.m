//
//  SCTableViewCell.m
//  Combo Recovery
//
//  Created by srich on 7/5/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "SCTableViewCell.h"

@implementation SCTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
