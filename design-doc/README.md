#Design Doc


##Classes:


###RSLMainViewController
```objective-c

//Hide navigation bar
- (void)viewWillAppear:(BOOL)animated;

//Set up everything that is needed for play
- (void)viewDidLoad


- (void)keyboardWillHide:(NSNotification *)n
- (void)keyboardWillShow:(NSNotification *)n;

//handle user input
-(BOOL) textFieldShouldReturn:(UITextField *)textField;

//display message when game is won
- (void) gamewin;

//display message when gameover
- (void) gameover;
```

