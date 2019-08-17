//
//  DTLauchManager.m
//  AppLaunchPerformance
//
//  Created by 金秋成 on 2019/8/16.
//  Copyright © 2019 金秋成. All rights reserved.
//

#import "DTLauchItemManager.h"
#import <dlfcn.h>
#import <mach-o/getsect.h>




#ifdef __LP64__
typedef uint64_t DTBaseType;
typedef struct section_64  DTBaseSection;
typedef struct mach_header_64  DTBaseMachHeader;
#define DTGetSectByNameFromHeader getsectbynamefromheader_64
#else
typedef uint32_t DTBaseType;
typedef struct section DTBaseSection;
typedef struct mach_header  DTBaseMachHeader;
#define DTGetSectByNameFromHeader getsectbynamefromheader
#endif


@interface DTLauchItemManager ()
{
    id<DTLauchItemManagerLogger> _logger;
    NSLock * _loggerLock;
}

@end

@implementation DTLauchItemManager

static DTLauchItemManager * _shared;
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[DTLauchItemManager alloc] init];
        _shared->_loggerLock = [[NSLock alloc] init];
    });
    return _shared;
}

-(void)launchForKey:(NSString *)key{
    //通过Key找到函数指针
    NSString * newKey = [NSString stringWithFormat:@"__%@.function",key];
    [_logger willLaunchForKey:key];
    
    DTExcuteFunctionsForKey([newKey UTF8String],
                            ^(char * name){
        [_logger willExcuteFunction:[NSString stringWithUTF8String:name] forLaunchKey:key];
    },^(char * name){
        [_logger didExcutedFunction:[NSString stringWithUTF8String:name] forLaunchKey:key];
    });
    [_logger didLaunchedForKey:key];
}

-(void)setLoger:(id<DTLauchItemManagerLogger>)logger{
    [_loggerLock lock];
    _logger = logger;
    [_loggerLock unlock];
}



int DTExcuteFunctionsForKey(const char * key,void(^before)(char * name),void(^after)(char * name)) {
    Dl_info info;
    dladdr((const void *)&DTExcuteFunctionsForKey, &info);
    DTBaseMachHeader * machOHeader = (DTBaseMachHeader *)info.dli_fbase;
    DTBaseType mach_header = (DTBaseType)info.dli_fbase;
    const DTBaseSection * section = getsectbynamefromheader_64(machOHeader, "__DTC", key);
    if (section == NULL) { return 0; }
    size_t size = sizeof(DTExportedFunction);
    for (DTBaseType add = mach_header + section->offset; add < mach_header + section->offset + section->size ; add += size) {
        DTExportedFunction func = *(DTExportedFunction *)add;
        before(func.name);
        func.function();
        after(func.name);
    }
    return 1;
}





@end
