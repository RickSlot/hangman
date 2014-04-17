#Design Doc


##Classes:


###RSLMainViewController
This viewcontroller is the main entry of the game. it starts the game and handles all input events
```objective-c

//Hide navigation bar
- (void)viewWillAppear:(BOOL)animated;

//Set up everything that is needed for play
- (void)viewDidLoad

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

##RSLHighscoreController
This class handles everything that has to do with highscores. both highscoreviewcontroller and mainviewcontroller have a higschore object.
the highscores will be saved in a plist. every higschore has two values; a name and a score. these are saved with the keys name[1-10] and score[1-10];
```Objective-c
//creates an new object
- (id) init;

//adds a highscore with a name and a score
- (void) addHighscoreWithName:(NSString *) name andScore:(int) score;

//returns the plist with the highscores
- (NSMutableDictionary*)dictionaryFromPlist;

//calulates the score
- (int) calculateHighscoreWithGuessesLeft:(int) guessesLeft wordLength:(int) wordLength totalNumberGuesses:(int) totalNumberGuesses;
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

##Style
- Camelcase
- explaining function names
- // for single line comments /* */ for multilines
- { on the same line as function name
- Model, view, controller
