//
//  AppDelegate.m
//  ksdControl
//
//  Created by HANQING on 15/4/13.
//  Copyright (c) 2015年 HANQING. All rights reserved.
//

#import "AppDelegate.h"
#import "ComputerVO.h"
#import "RelayVO.h"
#import "PlayerVO.h"
#import "ProjectVO.h"
#import "GroupVO.h"
#import "AreaVO.h"
#import "JsonControl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


@synthesize areaArray,pavilionName;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self getElements];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

//加载Json字典,并在设置界面显示
- (void)getElements
{
    areaArray = [[NSMutableArray alloc] initWithObjects:nil];
    
    //加载Json数据
    NSDictionary *areaDict = [NSDictionary dictionary];
    areaDict = [JsonControl jsonRead:@"PavilionData"];
    
    //areaKeys保存展区的所有key
    NSArray* areaKeys = [[areaDict allKeys]
                         sortedArrayUsingSelector:@selector(compare:)];
    pavilionName = [areaDict objectForKey:@"展厅名"];
    
    for (int i = 0; i < [areaKeys count]; i++)
    {
        
        //获取展区的字典
        if([areaDict count]!=0 && i < areaDict.count)
        {
            NSString* aKey = [areaKeys objectAtIndex:i];
            
            if(![aKey isEqual:@"展厅名"]&&![aKey isEqual:@"程序版本"])
            {
                
                AreaVO* area = [AreaVO new];
                [area initVO];
                [area setAName:aKey];
                [areaArray addObject:area];
                
                NSDictionary *aDict = [areaDict objectForKey:aKey];
                
                //获取组的所有键值
                NSArray* groupKeys = [[aDict allKeys]sortedArrayUsingSelector:@selector(compare:)];
                
                for(int j =0; j < groupKeys.count;j++)
                {
                    //获取组合的字典
                    NSString* gKey = [groupKeys objectAtIndex:j];
                    NSDictionary *gDict = [aDict objectForKey:gKey];
                    
                    if([[gKey substringToIndex:2] isEqual: @"组元"])
                    {
                        NSString *type = [gDict objectForKey:@"type"];
                        if([type isEqualToString:@"电脑类型"])
                        {
                            NSLog(@"电脑类型:%@",[gDict objectForKey:@"name"]);
                            ComputerVO* computer = [ComputerVO new];
                            [computer initVO];
                            [computer setAType:@"电脑类型"];
                            [computer setIp:[gDict objectForKey:@"ip"]];
                            [computer setAName:[gDict objectForKey:@"name"]];
                            [computer setPort:[[gDict objectForKey:@"port"] intValue]] ;
                            [computer setAddressMac:[gDict objectForKey:@"mac"]];
                            
                            [area.groups addObject:computer];
                            
                        }
                        if([type isEqualToString:@"投影机类型"])
                        {
                            NSLog(@"投影机类型:%@",[gDict objectForKey:@"name"]);
                            ProjectVO* project = [ProjectVO new];
                            [project initVO];
                            [project setAType:@"投影类型"];
                            [project setIp:[gDict objectForKey:@"ip"]];
                            [project setAName:[gDict objectForKey:@"name"]];
                            [project setPort:[[gDict objectForKey:@"port"] intValue]] ;
                            
                            
                            [area.groups addObject:project];
                        }
                        
                        if([type isEqualToString:@"播放类型"])
                        {
                            NSLog(@"播放类型:%@",[gDict objectForKey:@"name"]);
                            PlayerVO* player = [PlayerVO new];
                            [player initVO];
                            [player setAType:@"播放器类型"];
                            [player setIp:[gDict objectForKey:@"ip"]];
                            [player setAName:[gDict objectForKey:@"name"]];
                            [player setPort:[[gDict objectForKey:@"port"] intValue]] ;
                            [player setIsPic:[[gDict objectForKey:@"是否播放图片"] boolValue]];
                            
                            [area.groups addObject:player];
                        }
                        
                        if([type isEqualToString:@"电路类型"])
                        {
                            NSLog(@"电路类型:%@",[gDict objectForKey:@"name"]);
                            RelayVO* relay = [RelayVO new];
                            [relay initVO];
                            [relay setAType:@"电路类型"];
                            [relay setIp:[gDict objectForKey:@"ip"]];
                            [relay setAName:[gDict objectForKey:@"name"]];
                            [relay setPort:[[gDict objectForKey:@"port"] intValue]] ;
                            [relay setCircuit:[[gDict objectForKey:@"电路数"] intValue]];
                            
                            [area.groups addObject:relay];
                        }
                    }
                    
                    if([[gKey substringToIndex:2] isEqual: @"组合"])
                    {
                        NSLog(@"组合");
                        //获取元素的所有键值
                        NSArray* elementKeys = [[gDict allKeys]sortedArrayUsingSelector:@selector(compare:)];
                        
                        GroupVO* group = [GroupVO new];
                        [group initVO];
                        [group setAName:[gKey substringFromIndex:3]];
                        [area.groups addObject:group];
                        
                        
                        //获取元素的字典
                        for (int k = 0; k < elementKeys.count; k++)
                        {
                            NSString* eKey = [elementKeys objectAtIndex:k];
                            NSDictionary *eDict = [gDict objectForKey:eKey];
                            
                            NSString *type = [eDict objectForKey:@"type"];
                            if([type isEqualToString:@"电脑类型"])
                            {
                                ComputerVO* computer = [ComputerVO new];
                                [computer initVO];
                                [computer setAType:@"电脑类型"];
                                [computer setIp:[eDict objectForKey:@"ip"]];
                                [computer setAName:[eDict objectForKey:@"name"]];
                                [computer setPort:[[eDict objectForKey:@"port"] intValue]] ;
                                [computer setAddressMac:[eDict objectForKey:@"mac"]];
                                [group.elements addObject:computer];
                            }
                            if([type isEqualToString:@"投影机类型"])
                            {
                                ProjectVO* project = [ProjectVO new];
                                [project initVO];
                                [project setAType:@"投影类型"];
                                [project setIp:[eDict objectForKey:@"ip"]];
                                [project setAName:[eDict objectForKey:@"name"]];
                                [project setPort:[[eDict objectForKey:@"port"] intValue]] ;
                                [group.elements addObject:project];
                            }
                            
                            if([type isEqualToString:@"播放类型"])
                            {
                                PlayerVO* player = [PlayerVO new];
                                [player initVO];
                                [player setAType:@"播放器类型"];
                                [player setIp:[eDict objectForKey:@"ip"]];
                                [player setAName:[eDict objectForKey:@"name"]];
                                [player setPort:[[eDict objectForKey:@"port"] intValue]] ;
                                [player setIsPic:[[eDict objectForKey:@"是否播放图片"] boolValue]];
                                [group.elements addObject:player];
                            }
                            
                            if([type isEqualToString:@"电路类型"])
                            {
                                RelayVO* relay = [RelayVO new];
                                [relay initVO];
                                [relay setAType:@"电路类型"];
                                [relay setIp:[eDict objectForKey:@"ip"]];
                                [relay setAName:[eDict objectForKey:@"name"]];
                                [relay setPort:[[eDict objectForKey:@"port"] intValue]] ;
                                [relay setCircuit:[[eDict objectForKey:@"电路数"] intValue]];
                                [group.elements addObject:relay];
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "KSD.ksdControl" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ksdControl" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ksdControl.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}



#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
