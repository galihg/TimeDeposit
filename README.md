# Table of Content

1. [Tech-Stack](#Tech-Stack)
    1. [User Interface](#User-Interface)
    2. [Architecture](#Architecture)
    3. [Dependencies Management](#Dependency-Management)
3. [How To Run](#How-To-Run)
    1. [Adding Dependencies](#Adding-Dependencies)
    2. [Run Project](#Run-Project)
    3. [Call init method of OneKycSdk on App Launch](#Call-Init-Method)
4. [Third Party Dependencies](#Third-Party-Dependencies)


## Tech-Stack: <a name="Tech-Stack"></a>


### User Intercace: <a name="User-Interface"></a>
The user interface is developed programmatically using `UIKit`


### Architecture: <a name="Architecture"></a>
This project is developed following the MVVM-C architectural pattern


### Dependency Management: <a name="Dependency-Management"></a>
This project uses `Cocoapods` as its dependency management


## How To Run: <a name="How-To-Integrate"></a>
1. Run `pod install` on terminal on the root folder of the project
2. Build and run the project using the `xcworkspace` file


### Adding Dependencies: <a name="Adding-Dependencies"></a>
Add dependency to `podfile` if you want to add new dependencies in developing the project. If you have not set up `Cocoapods` yet, run `gem install cocoapods` first on your terminal. 


### Third Party Dependencies: <a name="Third-Party-Dependencies"></a>
This project depends on following third party libraries:

| Index |                          Name                          |                  Description               |
|:-----:|:------------------------------------------------------:|:------------------------------------------:|
|   1   |                          PKHUD                         |                 UI components              |
|   2   |                      DLRadioButton                     |                 UI components              |
|   3   |                          Nimble                        |                   Unit Test                |
|   4   |                          Quick                         |                   Unit Test                |
