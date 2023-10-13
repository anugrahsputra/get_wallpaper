Get Wallpaper app is a simple app that allows you to download wallpapers from the internet and set them as your wallpaper.

[![Dart](https://github.com/anugrahsputra/get_wallpaper/actions/workflows/dart.yml/badge.svg)](https://github.com/anugrahsputra/get_wallpaper/actions/workflows/dart.yml)
[![Codemagic build status](https://api.codemagic.io/apps/652973b20b29ad11c55f65b1/652973b20b29ad11c55f65b0/status_badge.svg)](https://codemagic.io/apps/652973b20b29ad11c55f65b1/652973b20b29ad11c55f65b0/latest_build)

# Getting Started
Get all the dependencies by running:
```bash
flutter pub get
```
This flutter uses freezed package to generate the models and cubits. To generate the models and cubits, run the following command in the terminal:
```bash
dart run build_runner build --delete-conflicting-outputs
```
To run the app, run the following command:
```bash
flutter run
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## To Do
- [x] Add a search bar to search for wallpapers
- [x] Implement categories
- [ ] Add a corousel to display the latest wallpapers
- [ ] Add a favorites button to save wallpapers
- [ ] Add a favorites page to view all the favorite wallpapers
- [ ] Add a settings page to change the theme of the app
- [ ] Add a settings page to change the language of the app
