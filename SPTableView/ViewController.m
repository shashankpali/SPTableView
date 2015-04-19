//
//  ViewController.m
//  SPTableView
//
//  Created by Shank on 4/9/15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "SPTable.h"

@interface ViewController ()

@property(strong,nonatomic)UIDynamicAnimator *animator;


@end

@implementation ViewController{
    
    SPTable *mytable;
    UIView *ball;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    mytable=[[SPTable alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:mytable];
    
    ball=[[UIView alloc]initWithFrame:CGRectMake(130, 270, 50, 50)];
    ball.layer.cornerRadius=25;
    
    ball.backgroundColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gumo:)];
    [ball addGestureRecognizer:pan];
    [self.view addSubview:ball];
    
}


-(void)gumo:(UIPanGestureRecognizer *)gaar{
    
    
    _animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    CGPoint translation = [gaar translationInView:self.view];
    
    gaar.view.center = CGPointMake(gaar.view.center.x+translation.x, gaar.view.center.y+translation.y);
    
    [gaar setTranslation:CGPointZero inView:self.view];
    
    mytable.yaxis=gaar.view.center.y-25;
    
    [mytable beginUpdates];
    [mytable endUpdates];
    
    [_animator updateItemUsingCurrentState:gaar.view];
    
    
    if (gaar.view.frame.origin.y<30) {
        
        gaar.view.frame=CGRectMake(gaar.view.frame.origin.x, 30, 50, 50);
    }
    
    
    if (gaar.view.frame.origin.x>=135) {
        
        UISnapBehavior *snap=[[UISnapBehavior alloc]initWithItem:gaar.view snapToPoint:CGPointMake(mytable.frame.size.width-(gaar.view.frame.size.width/2), gaar.view.frame.origin.y)];
        
        [_animator addBehavior:snap];
        
    }
    
    if (gaar.view.frame.origin.x<=135) {
        
        UISnapBehavior *snap=[[UISnapBehavior alloc]initWithItem:gaar.view snapToPoint:CGPointMake(mytable.frame.origin.x+(gaar.view.frame.size.width/2), gaar.view.frame.origin.y)];
        
        [_animator addBehavior:snap];
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
