//
//  IQRuleMacro.h
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#ifndef IQRuleMacro_h
#define IQRuleMacro_h

#define __DEBUG__

#ifdef __DEBUG__
#define DLog(format,...) NSLog((@"[文件名:%s],[函数名:%s],[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...) do {} while(0);
#endif


#endif /* IQRuleMacro_h */
