class ItemClass {
  final String title;
  final String? subtitle;
  final String? img;
  final Function()? onTap;

  ItemClass({
    required this.title,
    this.img,
    this.onTap,
    this.subtitle,
  });
}
