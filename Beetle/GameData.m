//
//  GameData.m
//  FlippysFlight
//
//  Created by Dori Mouawad on 7/8/17.
//  Copyright © 2017 Muskan. All rights reserved.
//

#import "GameData.h"

#import "KeychainWrapper.h"

@implementation GameData

//Key variables for GameData
static NSString* const SSGameDataHighScoreKey = @"highScore";
static NSString* const SSGameDataTotalDistanceKey = @"totalDistance";
static NSString* const SSGameDataTotalCoinsKey = @"totalCoins";
static NSString* const SSGameDataNumTimesPlayedKey = @"numTimesPlayed";
static NSString* const SSGameDataTotalCoinsSpentKey = @"totalCoinsSpent";

//Key Variables for Keychain Wrapper Checksum
static NSString* const SSGameDataChecksumKey = @"SSGameDataChecksumKey";

//Custom init: updateFromIcloud when there is a notification from iCloud of new data
- (instancetype)init
{
    self = [super init];
    if (self) {
        if([NSUbiquitousKeyValueStore defaultStore]) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(updateFromiCloud:)
                                                         name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                       object:nil];
        }
    }
    return self;
}

+ (instancetype)sharedGameData
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

//Function: filePath
//Returns: String filePath
//Creates a filepath ending with "gameData", to store gameData
+ (NSString*) filePath
{
    static NSString* filePath = nil;
    if(!filePath){
        filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject ]stringByAppendingPathComponent:@"gameData"];
    }
    return filePath;
}

//Function: loadInstance
//Returns: gameData
//Load file instance from a file, and returns or initilizes the gameData that has been collected
+ (instancetype)loadInstance
{
    NSData* decodedData = [NSData dataWithContentsOfFile: [GameData filePath]];
    
    if (decodedData) {
        //Generates SHA256 has decoded checksum data from saved file
        NSString* checksumOfSavedFile = [KeychainWrapper computeSHA256DigestForData: decodedData];
        
        //Get most recent SHA256 checksum stored in the keychain
        NSString* checksumInKeychain = [KeychainWrapper keychainStringFromMatchingIdentifier: SSGameDataChecksumKey];
        
        //Compare both checksum data then return the game data if it matched
        //Else return blank/initiliazed data.
        if ([checksumOfSavedFile isEqualToString: checksumInKeychain]) {
            GameData* gameData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
            return gameData;
        }
    }
    
    return [[GameData alloc] init];
}

//Function: save
//Returns: nothing
//Writing the data to a file atomically and updates iCloud
- (void) save {
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[GameData filePath] atomically:YES];
    
    //Checksum for when saving data
    NSString* checksum = [KeychainWrapper computeSHA256DigestForData: encodedData];
    
    //If there is an exisiting keychain string, then update it. Else if it does not exit then create it
    if ([KeychainWrapper keychainStringFromMatchingIdentifier: SSGameDataChecksumKey]) {
        [KeychainWrapper updateKeychainValue:checksum forIdentifier:SSGameDataChecksumKey];
    } else {
        [KeychainWrapper createKeychainValue:checksum forIdentifier:SSGameDataChecksumKey];
    }
    
    //Updates iCloud
    if([NSUbiquitousKeyValueStore defaultStore]) {
        [self updateiCloud];
    }
    
}



//Encoder
- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode values used for the game
    [encoder encodeDouble:self.highScore forKey:SSGameDataHighScoreKey];
    [encoder encodeDouble:self.totalDistance forKey: SSGameDataTotalDistanceKey];
    [encoder encodeDouble:self.totalCoins forKey:SSGameDataTotalCoinsKey];
    [encoder encodeDouble:self.numTimesPlayed forKey: SSGameDataNumTimesPlayedKey];
    [encoder encodeDouble:self.coinsSpent forKey:SSGameDataTotalCoinsSpentKey];
    
}

//Decoder
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self){
        //Decode values used for the game
        _highScore = [aDecoder decodeDoubleForKey: SSGameDataHighScoreKey];
        _totalDistance = [aDecoder decodeDoubleForKey:SSGameDataTotalDistanceKey];
        _totalCoins = [aDecoder decodeDoubleForKey:SSGameDataTotalCoinsKey];
        _numTimesPlayed = [aDecoder decodeDoubleForKey:SSGameDataNumTimesPlayedKey];
        _totalCoinsSpent = [aDecoder decodeDoubleForKey:SSGameDataTotalCoinsSpentKey];
    }
    
    return self;
}

//NOT COMPLETE YET
//Function: updateiCloud
//Returns: Nothing
//Process: Updates values in iCloud such as high score, coins, etc.
- (void)updateiCloud
{
    //Access iCloud key value
    NSUbiquitousKeyValueStore *iCloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    //Get high score from cloud
    long cloudHighScore = [iCloudStore doubleForKey: SSGameDataHighScoreKey];
    
    //If local high score is greater than iCloud highscore, then update it
    if (self.highScore > cloudHighScore){
        [iCloudStore setDouble:self.highScore forKey: SSGameDataHighScoreKey];
        [iCloudStore synchronize];
    }
    
    //Get total coins from iCloud
    long cloudTotalCoins = [iCloudStore doubleForKey: SSGameDataTotalCoinsKey];
    
    //If local total coins is different from iCloud, update it
    if (self.totalCoins != cloudTotalCoins){
        [iCloudStore setDouble:self.totalCoins forKey:SSGameDataTotalCoinsKey];
        [iCloudStore synchronize];
    }
}

//NOT COMPLETE YET
//Function: updateFromiCloud
//Returns: nothing
//Process: Checks if there is data from iCloud that is different from local, and changes it. This is helpful
//for people playing accross different iOS devices.
-(void)updateFromiCloud:(NSNotification*) notificationObject
{
    //Get iCloudStore key
    NSUbiquitousKeyValueStore *iCloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    //Get highscore from iCloud
    long cloudHighScore = [iCloudStore doubleForKey: SSGameDataHighScoreKey];
    
    //Get total coins from iCloud
    long cloudTotalCoins = [iCloudStore doubleForKey: SSGameDataTotalCoinsKey];
    
    //Store High score
    self.highScore = MAX(cloudHighScore, self.highScore);
    
    //Store total coins
    self.totalCoins = cloudTotalCoins;
}

//Function: reset
//Returns: nothing
//Process: resets all local scores to 0 after each game instance
- (void)reset
{
    self.score = 0;
    self.distance = 0;
    self.coins = 0;
}

@end
