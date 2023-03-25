class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "SELECT ITEMS",
    image: "assets/images/image1.png",
    desc:
        "Takit is simply dummy \ntext of the printing and typesetting industry.",
  ),
  OnboardingContents(
    title: "PURCHASE",
    image: "assets/images/image2.png",
    desc:
        "Takit is simply dummy \ntext of the printing and typesetting industry.",
  ),
  OnboardingContents(
    title: "DELIVERY",
    image: "assets/images/image3.png",
    desc:
        "Takit is simply dummy \ntext of the printing and typesetting industry.",
  ),
];
