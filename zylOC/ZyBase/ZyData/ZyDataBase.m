//
//  ZyDataBase.m
//  zylOC
//
//  Created by 张钰营 on 2018/6/1.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyDataBase.h"
#import <FMDB.h>

#import "Person.h"
#import "Car.h"

@interface ZyDataBase ()

@end


@implementation ZyDataBase{
    FMDatabase  *_db;
}
    
+(instancetype)sharedDataBase{
    static ZyDataBase *zyDataBase = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zyDataBase = [[super allocWithZone:nil] init];
    });
    return zyDataBase;
}
    
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [ZyDataBase sharedDataBase];
}
    
-(id)copyWithZone:(NSZone *)zone{
    return [ZyDataBase sharedDataBase];
}
    
-(id)mutableCopyWithZone:(NSZone *)zone{
    return [ZyDataBase sharedDataBase];
}
    
-(id)copy{
    return self;
}
    
-(id)mutableCopy{
    return self;
}
    
-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    NSString *personSql = @"CREATE TABLE 'person' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'person_id' VARCHAR(255),'person_name' VARCHAR(255),'person_age' VARCHAR(255),'person_number'VARCHAR(255)) ";
    NSString *carSql = @"CREATE TABLE 'car' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'own_id' VARCHAR(255),'car_id' VARCHAR(255),'car_brand' VARCHAR(255),'car_price'VARCHAR(255)) ";
    
    [_db executeUpdate:personSql];
    [_db executeUpdate:carSql];
    
    
    [_db close];
    
}
#pragma mark - 接口
    
- (void)addPerson:(Person *)person{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"person_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"person_id"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO person(person_id,person_name,person_age,person_number)VALUES(?,?,?,?)",maxID,person.name,@(person.age),@(person.number)];
    
    
    
    [_db close];
    
}
    
- (void)deletePerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM person WHERE person_id = ?",person.ID];
    
    [_db close];
}
    
- (void)updatePerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"UPDATE 'person' SET person_name = ?  WHERE person_id = ? ",person.name,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_age = ?  WHERE person_id = ? ",@(person.age),person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_number = ?  WHERE person_id = ? ",@(person.number + 1),person.ID];
    
    
    
    [_db close];
}
    
- (NSMutableArray *)getAllPerson{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person"];
    
    while ([res next]) {
        Person *person = [[Person alloc] init];
        person.ID = @([[res stringForColumn:@"person_id"] integerValue]);
        person.name = [res stringForColumn:@"person_name"];
        person.age = [[res stringForColumn:@"person_age"] integerValue];
        person.number = [[res stringForColumn:@"person_number"] integerValue];
        
        [dataArray addObject:person];
        
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}
    /**
     *  给person添加车辆
     *
     */
- (void)addCar:(Car *)car toPerson:(Person *)person{
    [_db open];
    
    //根据person是否拥有car来添加car_id
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM car where own_id = %@ ",person.ID]];
    
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"car_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"car_id"] integerValue]);
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO car(own_id,car_id,car_brand,car_price)VALUES(?,?,?,?)",person.ID,maxID,car.brand,@(car.price)];
    
    
    
    [_db close];
    
}
    /**
     *  给person删除车辆
     *
     */
- (void)deleteCar:(Car *)car fromPerson:(Person *)person{
    [_db open];
    
    
    [_db executeUpdate:@"DELETE FROM car WHERE own_id = ?  and car_id = ? ",person.ID,car.car_id];
    
    
    [_db close];
    
    
    
}
    /**
     *  获取person的所有车辆
     *
     */
- (NSMutableArray *)getAllCarsFromPerson:(Person *)person{
    
    [_db open];
    NSMutableArray  *carArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM car where own_id = %@",person.ID]];
    while ([res next]) {
        Car *car = [[Car alloc] init];
        car.own_id = person.ID;
        car.car_id = @([[res stringForColumn:@"car_id"] integerValue]);
        car.brand = [res stringForColumn:@"car_brand"];
        car.price = [[res stringForColumn:@"car_price"] integerValue];
        
        [carArray addObject:car];
        
    }
    [_db close];
    
    return carArray;
    
}
- (void)deleteAllCarsFromPerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM car WHERE own_id = ?",person.ID];
    
    
    [_db close];
}

@end
