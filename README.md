# RxSwiftStudy
RxSwiftStudy 用于记录自己在RxSwift上面的学习，这不会是一个完整的项目，而是日常写下的demo，希望通过日积月累，最后用RxSwift+MVVM完成一个项目


## RxSwift
它只是基于`Swift`语言的`Rx`标准实现接口库，所以`RxSwift`里不包含任何`Cocoa`或者UI方面的类。
## RxCocoa
是基于`RxSwift`针对于iOS开发的一个库，它通过`Extension`的方法给原生的比如`UI`控件添加了`Rx`的特性，使得我们更容易订阅和响应这些控件的事件。
## RxDataSources
使用`RxSwift`对`UITableView`和`UICollectionView`的数据源做了一层包装，大大减少我们的工作量。
## RxAlamofire
`RxAlamofire`是对`Alamofire`的封装
## ObjectMapper
`ObjectMapper`是一个使用`Swift`语言编写的数据模型转换框架。使用它，我们可以很方便地将模型对象（类和结构体）转换为`JSON`，或者根据`JSON`生成对应的模型对象。
## Moya 
`Moya`是一个帮助我们管理`Alamofire`的网络管理层，可以让我们去更清晰的去管理我们的网络请求。
## HandyJSON
`HandyJSON`是一个用于`Swift`语言中的`JSON`序列化/反序列化库。（我目前使用的）


## 如何增加新的属性？
```
extension Reactive where Base : UIView {
    public var backgroundColor: Binder<UIColor> {
        return Binder(self.base){
            view, color in
            view.backgroundColor = color
        }
    }
}
```

另附之前我写过一些关于`RxSwift`基础用法[地址在此](https://www.jianshu.com/p/cb5d37116dd2)

## 参考：
[航哥](http://www.hangge.com/)
[RxSwift中文文档](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/)
