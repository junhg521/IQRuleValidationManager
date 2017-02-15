//
//  IQRuleMacro.h
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#ifndef IQRuleMacro_h
#define IQRuleMacro_h

#ifdef DEBUG
#define DLog(format,...) NSLog((@"[函数名:%s]\n" format), __FUNCTION__, ##__VA_ARGS__);
#else
#define DLog(...) do {} while(0);
#endif

#endif /* IQRuleMacro_h */
