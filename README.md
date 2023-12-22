# Get Wallpaper

<<<<<<< HEAD
Get Wallpaper is a mobile application built using Flutter. It allows users to browse, download, and set wallpapers from the internet. The application fetches wallpaper data from an external API and displays it in a user-friendly interface.
=======
[![Dart](https://github.com/anugrahsputra/get_wallpaper/actions/workflows/dart.yml/badge.svg)](https://github.com/anugrahsputra/get_wallpaper/actions/workflows/dart.yml)
[![Codemagic build status](https://api.codemagic.io/apps/652973b20b29ad11c55f65b1/652973b20b29ad11c55f65b0/status_badge.svg)](https://codemagic.io/apps/652973b20b29ad11c55f65b1/652973b20b29ad11c55f65b0/latest_build)
>>>>>>> 3a0a77899a2d6b794f9063ab1b62ab6b1acfafc4

## Features

- **Browse Wallpapers:** Users can browse through a list of wallpapers.
- **Search Wallpapers:** Users can search for specific wallpapers using the search functionality.
- **Wallpaper Details:** Users can view details of a specific wallpaper, including the photographer's name and the average color of the wallpaper.
- **Download Wallpapers:** Users can download their favorite wallpapers and set them as their device's wallpaper.

## Code Structure

The project follows a clean architecture pattern and uses the BLoC pattern for state management.

- `lib/main.dart`: This is the entry point of the application. It initializes the BLoC observers and runs the main application.
- `lib/presentation/pages`: This directory contains all the pages/screens of the application. Each page is a separate widget.
- `lib/presentation/widgets`: This directory contains reusable widgets used across different pages.
- `lib/data`: This directory contains the data layer of the application, including the models and data providers.
- `lib/core`: This directory contains the core functionalities of the application, including utilities and constants.

## Dependencies

The project uses several dependencies for various functionalities:

- `async_wallpaper`: For setting wallpapers asynchronously.
- `bloc` and `flutter_bloc`: For state management.
- `dio`: For making network requests.
- `dartz`: For functional programming support.
- `get_it`: For dependency injection.
- `go_router`: For routing and navigation.
- `google_fonts`: For using Google fonts.
- `palette_generator`: For generating dominant colors from images.
- `shared_preferences`: For local data persistence.

For a complete list of dependencies, refer to the `pubspec.yaml` file.

## Setup

To run this project:

1. Clone the repository.
2. Run `flutter pub get` to fetch the dependencies.
3. Run `flutter run` to start the application.

Please note that you might need to set up your own Pexel API keys and endpoints to fetch the wallpaper data.
