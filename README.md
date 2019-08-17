# AppLaunchItemManager
###Usage
**First**,copy `lib` folder into your project.

**Second**,use marco blow in anywhere you need to export
```
DT_FUNCTION_EXPORT(key,name)(){
     //do your launch staff
}
```
**key** length should at range 1~16,
**name** is just use for logging.

**Third**,use code blow to invoke all the functions you need,the code can be called anywhere and anytime,it's up to you.

```
[[DTLauchItemManager sharedInstance] launchForKey:key];
```
The param **key** should equal to marco's **key**