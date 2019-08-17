//
//  DTLaunchItem.h
//  AppLaunchPerformance
//
//  Created by 金秋成 on 2019/8/17.
//  Copyright © 2019 金秋成. All rights reserved.
//

#ifndef DTLaunchItem_h
#define DTLaunchItem_h

typedef struct{
    char * _Nonnull key;
    char * _Nonnull name;
    void (* _Nonnull function)(void);
} DTExportedFunction;

#define DT_FUNCTION_EXPORT(key,name) \
static void _DT##key(void); \
__attribute__((used, section("__DTC," "__"#key ".function"))) \
static const DTExportedFunction __Func##key = (DTExportedFunction){(char *)(&#key),(char *)(&#name), (void *)(&_DT##key)}; \
static void _DT##key \

#endif /* DTLaunchItem_h */



