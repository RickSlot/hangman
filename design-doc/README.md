#Design Doc


##Classes:


###RSLMainViewController
This viewcontroller is the main entry of the game. it starts the game and handles all input events
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


###RSLGameplay
This class handles all the gameplay elements such as choosing a word and checking the input
```Objective-c
//Inits the word and settings
- (id) init;

//Checks if the character exists in the word. returns a string indicating if it does
- (NSString *) checkIfCharacterExistsInWord: (NSString *) character;

//Checks if a character is already picked, if not call checkIfCharacterExistsinword
- (NSString *) characterPicked:(NSString * ) character;
```


###RSLFlipsideViewController
This view controller handles all settings
```objective-c
//Set up sliders and load user defaults
- (void)viewDidLoad;

//react to change event
- (IBAction)numberOfGuessesChanged:(UISlider *)sender;

//React to change event
- (IBAction)wordLengthChanged:(UISlider *)sender; 
```


###RSLHighscoresViewController
This view controller displays the 10 highest scores ever
```objective-c
//load higschores and set up labels
- (void)viewDidLoad;
```
