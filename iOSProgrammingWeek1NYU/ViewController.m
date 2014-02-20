//
//  ViewController.m
//  iOSProgrammingWeek1NYU
//
//  Created by Louis Tur on 2/18/14.
//  Copyright (c) 2014 edu.nyu. All rights reserved.
//

#import "ViewController.h"
#include "stdlib.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property (strong, nonatomic) NSDictionary * questionBank;

@property (strong, nonatomic) NSArray * questionArray;
@property (strong, nonatomic) NSMutableArray * answerKey;

@property (nonatomic) NSUInteger entryNumber;
@property (weak, nonatomic) IBOutlet UIButton *revealQuestion;
@property (weak, nonatomic) IBOutlet UIButton *revealAnswer;

@end

@implementation ViewController{
    NSArray * test;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.entryNumber = 0;
    
	self.questionBank = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"What is an action?", @"Acts upon an object",
                         @"What is an outlet?", @"Receives and actions",
                         @"What is your favorite colour?", @"Blue",
                         @"The sun rises in the: ", @"East",
                         @"Magnets, how do they work?", @"Magic",
                         nil];
    self.answerKey = [NSMutableArray arrayWithArray:[self.questionBank allKeys]];
    
    NSLog(@"Pre - Rearrangement: %@", self.answerKey);
    [self randomizeContent];
    
    NSLog(@"Post - Rearrangement: %@", self.answerKey);
    
    //self.questionArray = [NSArray arrayWithObjects:@"What is an action?", @"What is an outlet?", @"What is your favorite colour?", nil];
    
    //self.answerKey = [NSArray arrayWithObjects: @"Acts upon an object", @"Receives and actions",  @"Blue", nil];
    
    
    [self.revealQuestion setTitle:@"Reveal Question" forState:UIControlStateNormal];
    [self.revealAnswer setTitle:@"Reveal Answer" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(UIButton *)sender {
    self.entryNumber++;
    [self entryCheck];
    for (UILabel * label in self.allLabels) {
        label.text = @"";
    }
    
}

- (IBAction)revealQuestion:(UIButton *)sender {
    
    self.questionLabel.text = [self.questionBank objectForKey:self.answerKey[self.entryNumber]];
    //self.questionLabel.text = self.questionArray[self.entryNumber];
    
}

- (IBAction)revealAnswer:(UIButton *)sender {

    self.answerLabel.text = [self.answerKey objectAtIndex:self.entryNumber];
    //self.answerLabel.text = self.answerKey[self.entryNumber];
    
}

-(void) entryCheck{
    if (self.entryNumber >= [self.answerKey count]) {
        self.entryNumber = 0;
    }
}


//rearranges the order of the keys in a semi-random manner
-(void) randomizeContent{
    
    int replaceTo = 0;
    for (int j = 0; j < 20; j++) {
        
        for(int i = 0; i < [self.answerKey count]; i++){
            [self.answerKey exchangeObjectAtIndex:i withObjectAtIndex:replaceTo ];
            replaceTo = arc4random() % [self.answerKey count];
        }
    }
}
@end
