//
//  ViewController.m
//  ImageCaptureTest
//
//  Created by Developer on 06/09/14.
//  Copyright (c) 2014 Arpit. All rights reserved.
//

#import "ViewController.h"
#import "EmptyViewController.h"

@interface ViewController ()
- (IBAction)takePhoto:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;

@property int tag;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	[self performSelector:@selector(showDetail) withObject:nil afterDelay:2.0];
}

- (void) showDetail {
	EmptyViewController *vc = [[EmptyViewController alloc] initWithNibName:@"Empty" bundle:[NSBundle mainBundle]];
	[self presentViewController:vc animated:true completion:nil];
}

- (void) pushDetail {
	EmptyViewController *vc = [[EmptyViewController alloc] initWithNibName:@"Empty" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:vc animated:true];
}


- (IBAction)resign:(id)sender {}
- (IBAction)resignTextViewzPlease:(id)sender {}
- (IBAction)saveButtonTouched:(id)sender {}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender {
    _tag = ((UIButton *)sender).tag;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];


}

#pragma mark - UIImagePickerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    [[self getImageView:_tag] setImage:image];
    
}

- (UIImageView *) getImageView : (int) tag{
    for (UIImageView *imageView in _imageViews) {
        if (imageView.tag == tag) {
            return imageView;
        }
    }
    return nil;
}

//-(void) UpdateDatabase:(id)_object with:(NSMutableArray *)updatesArray
//{
//    
//    NSManagedObjectContext *threadManagedObjectContext = [self myManagedContext] ;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSManagedObjectContextObjectsDidChangeNotification object:threadManagedObjectContext] ;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mergeContextChangesForNotification:) name:NSManagedObjectContextObjectsDidChangeNotification object:threadManagedObjectContext];
//    
//    NSManagedObject *object = [threadManagedObjectContext objectWithID:[_object objectID]] ;
//    if (updatesArray) {
//        for (NSDictionary *updatedDic in updatesArray) {
//            [object setValue:[[updatedDic allValues] lastObject] forKey:[[keyValue allKeys] lastObject]];
//        }
//        
//        NSError *error;
//        bool result = [threadManagedObjectContext save:&error];
//        if (!result)
//        {
//            NSLog(@" error saving context, %@, %@", error, error.userInfo);
//        }
//    }
//}

@end
