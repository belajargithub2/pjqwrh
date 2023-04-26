<p align="center">
  <a href="https://getbootstrap.com/">
    <img src="https://user-images.githubusercontent.com/91040581/212412402-d6839b3e-8679-42a4-936a-4e029ea05f42.svg" width="200" height="140">
  </a>
</p>

<p align="center">
  <a href=https://www.figma.com/file/WjB1p9CIwvjMnbQvitiFgL/Deasy-Mobile-(DSL)">Figma</a>
  ·
  <a href="https://dev-deasy.kreditplus.com/">website</a>
</p>


## Deasy

The dealer management system aims to facilitate payment transactions through Kreditplus.

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Platform Support](#platform-support)
- [Application](#application)
  - [Bumblebee](#bumblebee)
  - [Optimus](#optimus)
- [Test](#test)
  - [Installation lcov](#installation-lcov)
    - [For ubuntu](#for-ubuntu)
    - [For mac](#for-mac)
  - [Run](#test-run)
    - [Bumblebee](#test-run-bumblebee) 
    - [Optimus](#test-run-optimus)
  - [Open Coverage](#open-coverage)
- [Packages](https://github.com/KB-FMF/deasy/tree/develop/packages)
  - [Component](https://github.com/KB-FMF/deasy/tree/develop/packages/component)
    - [Deasy Animation](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_animation)
    - [Deasy Button](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_buttons)
    - [Deasy Dialog](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_dialog)
    - [Deasy Dialog wrapper](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_dialog_wrapper)
    - [Deasy Responsive](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_responsive)
    - [Deasy Size_config](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_size_config)
    - [Deasy Snackbar](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_snackbar)
    - [Deasy Spinner](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_spinner)
    - [Deasy Switch](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_switch)
    - [Deasy Text](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_text)
    - [Deasy Text Form](https://github.com/KB-FMF/deasy/tree/develop/packages/component/deasy_text_form)
  - [Core](https://github.com/KB-FMF/deasy/tree/develop/packages/core)
    - [Deasy Config](https://github.com/KB-FMF/deasy/tree/develop/packages/core/deasy_config)
    - [Deasy Models](https://github.com/KB-FMF/deasy/tree/develop/packages/core/deasy_models)
    - [Deasy Network](https://github.com/KB-FMF/deasy/tree/develop/packages/core/deasy_network)
    - [Deasy Repository](https://github.com/KB-FMF/deasy/tree/develop/packages/core/deasy_repository)
  - [Helper](https://github.com/KB-FMF/deasy/tree/develop/packages/helper)
    - [Deasy Encryptor](https://github.com/KB-FMF/deasy/tree/develop/packages/helper/deasy_encryptor)
    - [Deasy Helper](https://github.com/KB-FMF/deasy/tree/develop/packages/helper/deasy_helper)
    - [Deasy Logger](https://github.com/KB-FMF/deasy/tree/develop/packages/helper/deasy_logger)
  - [Util](https://github.com/KB-FMF/deasy/tree/develop/packages/util)
    - [Deasy Color](https://github.com/KB-FMF/deasy/tree/develop/packages/util/deasy_color)
    - [Deasy Device Info](https://github.com/KB-FMF/deasy/tree/develop/packages/util/deasy_device_info)
    - [Deasy Logout](https://github.com/KB-FMF/deasy/tree/develop/packages/util/deasy_logout)
    - [Deasy Pocket](https://github.com/KB-FMF/deasy/tree/develop/packages/util/deasy_pocket)
    - [Deasy Service](https://github.com/KB-FMF/deasy/tree/develop/packages/util/deasy_service)
- [License](#license)


## Requirements
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.3.9)
- Xcode 13.4
- [Melos](https://melos.invertase.dev/)

## Installation
- Clone this repository
- Run  `dart pub global activate melos` in your computer to activate Melos.
- Run `melos bootstrap` to install dependencies
- Enjoy

## Project Structure

```

root/
|
|____apps/                                  <--- application layer
|     |____bumblebee                        <--- deasy mobile app (merchant & agent roles) 
|     |____optimus                          <--- deasy website (admin, merchant, support roles)
|
|_____packages/                             <--- packages layer
      |____util/                            <--- utility layer
      |    |____deasy_color                 
      |    |____deasy_pocket
      |
      |____helper/                          <--- helper layer
      |    |____deasy_encryptor
      |
      |-----component/                          <--- customable widgets layer (mostly for UI)
      |    |____deasy_text
      |
      |____core/                            <--- core layer (repositories, network, etc)
      |    |____deasy_core
      |
      |____dependencies/                    <--- override external library that Deasy consume
           |____deasy_lint
           |____deasy_get
    

```

## Platform Support
---

|                                   Name                                   | Android | iOS | Web  |
|:------------------------------------------------------------------------:|:-------:|:---:|:----:|
| [Bumblebee](https://github.com/KB-FMF/deasy/tree/develop/apps/bumblebee) |   ✔️    | ✔️  |  ✖️  |
|   [Optimus](https://github.com/KB-FMF/deasy/tree/develop/apps/optimus)   |   ✖️    | ✖️  |  ✔️  |


---

## Application
### Bumblebee
see more about bumblebee [here](https://github.com/KB-FMF/deasy/tree/develop/apps/bumblebee)

### Optimus
see more about optimus [here](https://github.com/KB-FMF/deasy/tree/develop/apps/optimus)

## Test
### Installation lcov
<hr>

#### for ubuntu
- Run `sudo apt-get update -qq -y`
- Run `sudo apt-get install lcov -y`

#### for mac
- Run `brew install lcov`
- Run `brew upgrade lcov`

### Test Run
<hr>

#### Test Run Bumblebee
run this command for test run bumblebee :
``` 
melos -
```

run this command for generate coverage report bumblebee :
```
melos -
```

#### Test Run Optimus
run this command for test run optimus :
``` 
melos -
```

run this command for generate coverage report optimus :
```
melos -
```

### Open Coverage
<hr>

run this command for open coverage report bumblebee :
```
melos -
```

run this command for open coverage report optimus :
```
melos -
```

## License
<hr>

Copyright 2023 by [KreditPlus](https://kreditplus.com/)

## Built With 🛠
* [GetX](https://pub.dev/packages/get) - A power full state management
* [Melos](https://pub.dev/packages/melos) - A tool for managing Dart & Flutter repositories with multiple packages (monorepo).
