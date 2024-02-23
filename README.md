
**[Rawg.io](https://rawg.io/) API**

* Fetch all game genres
* Save selected genres locally
* Fetch games from selected genres
* Edit selected genres & refresh 
* Present selected game details

**Architecture**
* MVVM + Combine framework

**Libraries used - SPM**

* PureLayout - The ultimate API for iOS & OS X Auto Layout
* SDWebImage - Asynchronous image downloader for cache support
* IHProgressHUD - HUD presentation library

**Adaptive UI**

* Programmatically (Pure Layout)
* Xib

Design decision was to recreate Rawg.io UI for mobile version in swift using UIKit with PureLayout additional extensions. With Xib files & UI library great is powerful mix to create adaptive elements.

**Screenshots**

* iPhone 12 Pro Max

![Simulator Screen Shot - iPhone 12 Pro Max - 2024-02-23 at 17 49 51](https://github.com/Peroi7/iOS-GameApp/assets/50051000/cc6ea381-aadb-4abd-b4f4-4144b580bdbe)
![Simulator Screen Shot - iPhone 12 Pro Max - 2024-02-23 at 17 50 04](https://github.com/Peroi7/iOS-GameApp/assets/50051000/cf1f2447-67e5-49d1-ab9a-1e9b3602500d)
![Simulator Screen Shot - iPhone SE (2nd generation) - 2024-02-23 at 17 54 50](https://github.com/Peroi7/iOS-GameApp/assets/50051000/af5896bf-a86a-4989-8a4f-0a1d24232e78)
![Simulator Screen Shot - iPhone SE (2nd generation) - 2024-02-23 at 17 54 58](https://github.com/Peroi7/iOS-GameApp/assets/50051000/5c4892fc-f233-4e6c-99ce-edfa907647fb)
![Simulator Screen Shot - iPhone 12 Pro Max - 2024-02-23 at 17 50 31](https://github.com/Peroi7/iOS-GameApp/assets/50051000/9e0b234d-4820-4814-b231-691d79105a72)
![Simulator Screen Shot - iPhone 12 Pro Max - 2024-02-23 at 17 51 01](https://github.com/Peroi7/iOS-GameApp/assets/50051000/fdec4817-b94b-420e-9ad6-721dfc2c5234)
![Simulator Screen Shot - iPhone 12 Pro Max - 2024-02-23 at 17 51 13](https://github.com/Peroi7/iOS-GameApp/assets/50051000/fde6947a-fe2b-44e2-a895-639153719792)
![Simulator Screen Shot - iPhone 12 Pro Max - 2024-02-23 at 19 34 27](https://github.com/Peroi7/iOS-GameApp/assets/50051000/db47a6e7-98f8-41d1-afce-70dddf2bb222)

- Reason for developing in Xcode 12.x is due to crashing MacOS Monterey software update on my MacbookAir 15"
