import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/data/data.dart';
import 'package:get_wallpaper/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../helper/mock.dart';

void main() {
  MockWallpaperRepository mockRepository = MockWallpaperRepository();
  GetDetailWallpaper detailWallpaper = GetDetailWallpaper(mockRepository);

  const tImageSource = ImageSource(
    original:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
    large2x:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    large:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
    medium:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
    small:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
    portrait:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
    landscape:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
    tiny:
        "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280",
  );

  const tWallpaper = Wallpaper(
    id: 2014422,
    width: 3024,
    height: 3024,
    url: "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
    photographer: "Joey Farina",
    photographerUrl: "https://www.pexels.com/@joey",
    photographerId: 680589,
    avgColor: "#978E82",
    src: tImageSource,
    liked: false,
    alt: "Brown Rocks During Golden Hour",
  );

  test('should get detail wallpaper from repository', () async {
    when(mockRepository.detailWallpaper(any))
        .thenAnswer((_) async => const Right(tWallpaper));

    final result = await detailWallpaper.execute(1);

    expect(result, const Right(tWallpaper));
  });
}
