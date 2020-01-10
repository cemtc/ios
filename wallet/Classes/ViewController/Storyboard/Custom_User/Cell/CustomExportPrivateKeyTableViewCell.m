//
//  CustomExportPrivateKeyTableViewCell.m
//  wallet
//
//  Created by 曾云 on 2019/8/20.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomExportPrivateKeyTableViewCell.h"

@interface CustomExportPrivateKeyTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *address_Image;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *address_Button;

@property (weak, nonatomic) IBOutlet UIImageView *privateKey_Image;
@property (weak, nonatomic) IBOutlet UILabel *privateKey;
@property (weak, nonatomic) IBOutlet UIButton *privateKey_Button;



@end

@implementation CustomExportPrivateKeyTableViewCell
- (IBAction)privateKey_ButtonClick:(UIButton *)sender {
    [UIPasteboard generalPasteboard].string = self.siyao;
    [MBProgressHUD showMessage:@"Copy Success"];
}
- (IBAction)address_ButtonClick:(UIButton *)sender {
    [UIPasteboard generalPasteboard].string = self.addressstr;
    [MBProgressHUD showMessage:@"Copy Success"];
}

- (IBAction)entryButtonClick:(UIButton *)sender {
    sender.selected =!sender.selected;
    self.privateKey.text = @"************************************************************************";
    if (sender.selected) {
        self.privateKey.text = self.siyao;
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];


}
-(void)setNamestr:(NSString *)namestr{
    _namestr = namestr;
    self.name.text = namestr;
    //https://raw.githubusercontent.com/iozhaq/image/master/SAR.png
    NSString *imageUrl = [NSString stringWithFormat:@"https://raw.githubusercontent.com/iozhaq/image/master/%@.png",self.namestr];
    [self.logo sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}
- (void)setAddressstr:(NSString *)addressstr{
    _addressstr = addressstr;
    self.address.text = addressstr;
    self.address_Image.image = [SKUtils createQrCodeSize:CGSizeMake(45, 45) dataString:addressstr];
}
-(void)setSiyao:(NSString *)siyao{
    _siyao = siyao;
    self.privateKey.text = siyao;
     self.privateKey_Image.image = [SKUtils createQrCodeSize:CGSizeMake(45, 45) dataString:siyao];
    self.privateKey.text = @"************************************************************************";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
