class SliderObject {
  final String title;
  final String subtitle;
  final String imagePath;

  const SliderObject({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int currentIndex;
  final int numberOfSlides;

  const SliderViewObject(
      {required this.sliderObject,
      required this.currentIndex,
      required this.numberOfSlides});
}
