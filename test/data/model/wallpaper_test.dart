import 'package:flutter_test/flutter_test.dart';
import 'package:get_wallpaper/data/data.dart';

void main() {
  group('.fromJson()', () {
    test('should convert json value to field', () {
      final actual = Wallpaper.fromJson(
        const {
          "id": 2014422,
          "width": 3024,
          "height": 3024,
          "url":
              "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
          "photographer": "Joey Farina",
          "photographer_url": "https://www.pexels.com/@joey",
          "photographer_id": 680589,
          "avg_color": "#978E82",
          "src": {
            "original":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
            "large2x":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
            "large":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
            "medium":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
            "small":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
            "portrait":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
            "landscape":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
            "tiny":
                "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
          },
          "liked": false,
          "alt": "Brown Rocks During Golden Hour"
        },
      );

      const matcher = Wallpaper(
        id: 2014422,
        width: 3024,
        height: 3024,
        url:
            "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
        photographer: "Joey Farina",
        photographerUrl: "https://www.pexels.com/@joey",
        photographerId: 680589,
        avgColor: "#978E82",
        src: ImageSource(
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
        ),
        liked: false,
        alt: "Brown Rocks During Golden Hour",
      );

      expect(actual, matcher);
    });
  });

  group('.toJson()', () {
    test('should conver field to json value', () {
      const data = Wallpaper(
        id: 2014422,
        width: 3024,
        height: 3024,
        url:
            "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
        photographer: "Joey Farina",
        photographerUrl: "https://www.pexels.com/@joey",
        photographerId: 680589,
        avgColor: "#978E82",
        src: ImageSource(
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
        ),
        liked: false,
        alt: "Brown Rocks During Golden Hour",
      );

      expect(data.toJson(), {
        "id": 2014422,
        "width": 3024,
        "height": 3024,
        "url":
            "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
        "photographer": "Joey Farina",
        "photographer_url": "https://www.pexels.com/@joey",
        "photographer_id": 680589,
        "avg_color": "#978E82",
        "src": {
          "original":
              "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
          "large2x":
              "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          "large":
              "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
          "medium":
              "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
          "small":
              "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
          "portrait":
              "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
          "landscape":
              "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
          "tiny":
              "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
        },
        "liked": false,
        "alt": "Brown Rocks During Golden Hour"
      });
    });
  });
}
