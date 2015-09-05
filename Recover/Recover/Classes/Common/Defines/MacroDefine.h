//
//  MacroDefine.h
//  BabySante
//
//  Created by 刘轩 on 15/7/16.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//



/*系统目录
 */
#define getDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define getCaches     [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define getLibrary    [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define getTemp       [NSString stringWithFormat:@"%@/temp", kCaches]


/* 字符串nil 值 转 空字符串
 * @str   字符型值
 */
#define getValueIfNilReturnStr(str) (!str || [str isKindOfClass:[NSNull class]]) ? @"" : str

/* 加载Url 地址
 * @strUrl    URL字符串
 */
#define getUrlWithStrValue(strUrl) [NSURL URLWithString:getValueIfNilReturnStr(strUrl)]


/** 组合字符串
*  @str   初始字符串
*  @objc  拼接的字符串 / 字符串数据
*/

#define getStringAppendingStr(str,objc) ({\
NSString *retStr = str;\
if ([objc isKindOfClass:[NSString class]]) {\
   retStr = [retStr stringByAppendingString:(NSString *)objc];\
}else if ([objc isKindOfClass:[NSArray class]]){\
for (NSObject *item in (NSArray *)objc) {\
        if ([item isKindOfClass:[NSString class]]) {\
          retStr = [retStr stringByAppendingString:(NSString *)item];\
        }\
    }\
}\
retStr;\
})



/** 获取图片
 *  @Res     图片素材名称
 */
#define getImageWithRes(Res) [UIImage imageNamed:Res]


/** 返回颜色值
*/
#define getColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/** 返回颜色值
 */
#define getColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

/*设置颜色值：UIColorFromRGB(0x067AB5)
 *
 */
#define getColorWithValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/**
 *  App 当前版本
 */
#define getAPPBoundVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];


/*当前设备的系统版本
 *
 */
 #define getSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])

/*屏幕尺寸
 *
 */
#define  getScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define  getScreenHeight         ([UIScreen mainScreen].bounds.size.height)



/*
 *获取数组元素
 */
#define getValueFromArray(arr,indexPath) [arr objectAtIndex:indexPath.row]

/*
 *获取字典元素
 */
#define getValueFromDictionary(Dict,key) [Dict objectForKey:key]


#define getObjectFromJSonString(jsonStr) [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]\
                                                     options:NSJSONReadingMutableContainers\
                                                       error:nil]




/**
 * 注册TabelViewHeaderFooterView
 *
 */
#define mRegisterNib_HearderFooter_TabelView(view,Class)    [view registerNib:[UINib nibWithNibName:NSStringFromClass([Class class]) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([Class class])];

//注册nib
#define mRegisterNib_TableView(view,Class)       [view registerNib:[UINib nibWithNibName:NSStringFromClass([Class class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([Class class])]

#define mRegisterNib_CollectionView(view,Class)  [view registerNib:[UINib nibWithNibName:NSStringFromClass([Class class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([Class class])]


/*
 * 取得Cell容器中的TableviewCell 对象
 */
#define getDequeueReusableCellWithClass(cellClass) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath]

/*
 * 取得Cell容器中的TableviewCell 对象
 */
#define getDequeueReusableCellWithIdentifier(cellIndetifier) [tableView dequeueReusableCellWithIdentifier:cellIndetifier forIndexPath:indexPath]



/** 宏方法定义 --从Sb中实例化ViewController
 *  @storyBoardName   StoryBoard 文件名
 *  @controller       ViewController类
 */
#define getViewControllFromStoryBoard(storyBoardName,viewController) [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([viewController class])]


/* 读取Xib文件的类
 *  @Class   xib 类文件
 *  @owner   所有者
 */
#define getViewByNib(Class, owner) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Class class]) owner:owner options:nil] lastObject]




/**
 *  presentModuleView NavigationController 弹出模态视图
 *
 *  @param storyboard     Storyboard
 *  @param viewController ViewController
 *  @param object         PassValue  (NSObject)
 *
 *  @return void
 */
#define presentViewControllerWith(storyboard,viewController,object) \
viewController *controller = [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([viewController class])]; \
if ([viewController instancesRespondToSelector:@selector(viewObject)])\
[controller setValue:object forKey:@"viewObject"];\
UINavigationController *nav_Remind = mLoadViewController(sbStoryBoard_MoudleUserStatus, @"BaseNavigationViewController");\
nav_Remind.viewControllers = @[controller];\
[self presentViewController:nav_Remind animated:YES completion:nil];



/**
 *  Push NavigationController 视图压栈操作
 *
 *  @param storyboard     Storyboard
 *  @param viewController ViewController
 *  @param object         PassValue  (NSObject)
 *
 *  @return void
 */
#define pushViewControllerWith(storyboard,viewController,object) \
viewController *controller = [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([viewController class])]; \
if ([viewController instancesRespondToSelector:@selector(viewObject)])\
[controller setValue:object forKey:@"viewObject"];\
controller.hidesBottomBarWhenPushed = YES;\
[self.navigationController pushViewController:controller animated:YES];

