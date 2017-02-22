# DiDi - KuaiDi
```
okay , the time is 02:18. i am so hungry...hahaaha😇😇😇
Get in back to the point,Let Me introduce this Pro
```
####Develope Environment
```
Xcode: 7.3.1 (the version is very terrible)
MAC OSX : 10.11.4 (15E65)
Programming Language: objective-C + (ARC)
```
####Third Reference FrameWork || Lib
```
MAP FrameWork ： GaoDe Map
Barcode Scan  :	ZXingObjC <u can get it from github>
...
```
####APP Preview
![GitHub set up](https://github.com/mgoofyy/DiDiKuaiDi/blob/kuaidi/demo.gif)
####Introductions
```
First u can scan the barCode use the app.
And Custom GaoDe Map : <PS: BaiDu Map is shit.Memory leak IS very very terrible. u can test it. when i use it first in my app. i want to say : "what the hell?">
...
The App develope by MVC 
autolayout the APP and Pure Code
The App is complete View.
```
####Project Structure
###### u can ignore it
```
. 
├── AMap.bundle
│   ├── AMap3D.bundle
│   ├── images
│   └── offline
├── AMapSearchKit.framework
│   └── Headers
├── CaoCaoKuaiDi
│   ├── Assets.xcassets
│   ├── Base.lproj
│   └── Class
│       ├── FrameWork
│       │   ├── Extension
│       │   └── ZXingObjC
│       │       ├── aztec
│       │       │   ├── decoder
│       │       │   ├── detector
│       │       │   └── encoder
│       │       ├── client
│       │       │   └── result
│       │       ├── common
│       │       │   ├── detector
│       │       │   └── reedsolomon
│       │       ├── core
│       │       ├── datamatrix
│       │       │   ├── decoder
│       │       │   ├── detector
│       │       │   └── encoder
│       │       ├── maxicode
│       │       │   └── decoder
│       │       ├── multi
│       │       ├── oned
│       │       │   └── rss
│       │       │       └── expanded
│       │       │           └── decoders
│       │       ├── pdf417
│       │       │   ├── decoder
│       │       │   │   └── ec
│       │       │   ├── detector
│       │       │   └── encoder
│       │       └── qrcode
│       │           ├── decoder
│       │           ├── detector
│       │           ├── encoder
│       │           └── multi
│       │               └── detector
│       ├── Global
│       │   └── Controller
│       ├── Home
│       │   ├── Controller
│       │   ├── LeftHome
│       │   │   ├── CourierCollection
│       │   │   │   └── Controller
│       │   │   ├── Message
│       │   │   │   └── Controller
│       │   │   ├── MyOrders
│       │   │   │   ├── Controller
│       │   │   │   └── View
│       │   │   ├── MyWallet
│       │   │   │   ├── Controller
│       │   │   │   └── View
│       │   │   ├── OftenAdress
│       │   │   │   └── Controller
│       │   │   ├── Personalnfo
│       │   │   │   └── Controller
│       │   │   ├── Recommend
│       │   │   │   └── Controller
│       │   │   └── Setting
│       │   │       └── Controller
│       │   └── View
│       │       ├── Class
│       │       ├── LBXScan
│       │       └── YCXMenu
│       ├── Other
│       └── PersonalCount
│           ├── Controller
│           ├── Login
│           │   └── Controller
│           └── Register
│               └── Controller
├── CaoCaoKuaiDi.xcodeproj
│   ├── project.xcworkspace
│   │   └── xcuserdata
│   │       └── goofy.xcuserdatad
│   └── xcuserdata
│       └── goofy.xcuserdatad
│           ├── xcdebugger
│           └── xcschemes
├── CaoCaoKuaiDiTests
├── CaoCaoKuaiDiUITests
└── MAMapKit.framework
    ├── AMap.bundle
    │   ├── AMap3D.bundle
    │   ├── images
    │   └── offline
    └── Headers
```



