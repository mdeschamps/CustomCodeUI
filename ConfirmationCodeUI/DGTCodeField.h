//
//  DGTChallengeCodeView.h
//  ConfirmationCodeUI
//
//  Created by Manuel Deschamps on 12/4/15.
//  Copyright © 2015 Manuel Deschamps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DGTCodeFieldDelegate

- (void) entryIsCompletedWithCode:(NSString *)code;
- (void) entryIsIncomplete;

@end

IB_DESIGNABLE
@interface DGTCodeField : UIView <UIKeyInput, UITextInputTraits>

@property (nonatomic, retain, readonly) NSMutableString *codeEntry;

@property (nonatomic,getter=isSecureTextEntry) IBInspectable BOOL secureTextEntry;

@property (nonatomic, readwrite) id<DGTCodeFieldDelegate> delegate;

@end