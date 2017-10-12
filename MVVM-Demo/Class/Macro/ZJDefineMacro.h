//
//  ZJDefineMacro.h
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/23.
//  Copyright © 2017年 张建. All rights reserved.
//

#ifndef ZJ_DefineMacro_Pch
#define ZJ_DefineMacro_Pch

//**********宏定义********
//screen尺寸
#define kScreenSize             [UIScreen mainScreen].bounds.size
#define kScreenWidth            kScreenSize.width
#define kScreenHeight           kScreenSize.height

//block防止循环引用
#define ZJWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//字体大小
#define KFont(size)             [UIFont systemFontOfSize:size]
#define kBoldFont(boldSize)     [UIFont boldSystemFontOfSize:boldSize]


#endif
