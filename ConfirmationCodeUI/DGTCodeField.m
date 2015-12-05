//
//  DGTChallengeCodeView.m
//  ConfirmationCodeUI
//
//  Created by Manuel Deschamps on 12/4/15.
//  Copyright © 2015 Manuel Deschamps. All rights reserved.
//

#import "DGTCodeField.h"

@interface DGTCodeField ()

@property (nonatomic, retain, readonly) DGTCodeField *view;

@property (weak, nonatomic) IBOutlet UILabel *digits;

@property (nonatomic, readonly) IBInspectable NSInteger codeLength;
@property (nonatomic, readonly) IBInspectable NSString *placeHolder;

@end

@implementation DGTCodeField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setUpFromNib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]){
        [self setUpFromNib];
    }
    return self;
}

- (void)setUpFromNib
{
    NSBundle *bundle = [NSBundle bundleForClass:[DGTCodeField class]];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([DGTCodeField class]) bundle:bundle];
    
    _view = [nib instantiateWithOwner:self options:nil][0];
    self.view.frame = [self bounds];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.userInteractionEnabled = YES;
    
    // Initialization code
    _codeEntry = [NSMutableString string];
    
    // Default values
    if (!self.codeLength) {
        _codeLength = 6;
    } else {
        _codeLength = MIN(self.codeLength, 12);
    }
    
    if (!self.placeHolder || !self.placeHolder.length) {
        _placeHolder = @"-";
    }
    
    [self addSubview:self.view];
}

- (UIKeyboardType) keyboardType
{
    return UIKeyboardTypeNumberPad;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    [self becomeFirstResponder];
}

- (void)drawRect:(CGRect)rect
{
    NSString *code = [self.codeEntry copy];
    if (self.secureTextEntry) {
        code = [[NSString string] stringByPaddingToLength:code.length withString:@"\u2022" startingAtIndex:0];
    }
    
    NSInteger add = self.codeLength - code.length;
    if (add > 0) {
        NSString *pad = [[NSString string] stringByPaddingToLength:add withString:self.placeHolder startingAtIndex:0];
        code = [code stringByAppendingString:pad];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:code];
    [attributedString addAttribute:NSKernAttributeName value:@10 range:NSMakeRange(0, attributedString.length-1)];

    self.digits.text = @"";
    [self.digits setAttributedText:attributedString];
}

- (BOOL)hasText {
    return self.codeEntry.length > 0;
}

- (void)insertText:(NSString *)theText {
    if (self.codeEntry.length >= self.codeLength){
        return;
    }
    
    [self.codeEntry appendString:theText];
    [self setNeedsDisplay];
    [self notifyEntryCompletion];
}

- (void)deleteBackward {
    if (!self.codeEntry.length){
        return;
    }
    
    NSRange theRange = NSMakeRange(self.codeEntry.length-1, 1);
    [self.codeEntry deleteCharactersInRange:theRange];
    [self setNeedsDisplay];
    [self notifyEntryCompletion];
}

- (void) notifyEntryCompletion
{
    if (self.codeEntry.length >= self.codeLength) {
        [self.delegate entryIsCompletedWithCode:[self.codeEntry copy]];
    } else {
        [self.delegate entryIsIncomplete];
    }
}

@end
