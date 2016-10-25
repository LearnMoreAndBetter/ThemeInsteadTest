# ThemeInsteadTest

实现本地换肤功能

blog地址：http://blog.csdn.net/qq_25303213/article/details/51433624

在我的中心可以切换主题模式

主题颜色封装在ThemeInsteadTool类中
/**
*    @brief  根据资源文件获取主题颜色
*
*    @return 主题颜色
*/
+ (UIColor *)themeColor;

/**
*    @brief  根据资源文件名获取图片
*
*    @param imageName 本地资源文件图片名称
*
*    @return 资源图片
*/
+ (UIImage *)imageWithImageName:(NSString *)imageName;

资源包封装在Resourse下的资源包中
