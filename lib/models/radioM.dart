class RadioM {
  late String id;
  String name;
  String tagline;
  String color;
  String desc;
  String url;
  String icon;
  String image;
  String lang;
  bool disliked;
  String category;
  int order;

  RadioM({
    required this.name,
    required this.tagline,
    required this.color,
    required this.desc,
    required this.url,
    required this.icon,
    required this.image,
    required this.lang,
    required this.disliked,
    required this.category,
    required this.order,
  });

  factory RadioM.fromJson(Map<String, dynamic> json) => RadioM(
        name: json["name"],
        tagline: json["tagline"],
        color: json["color"],
        desc: json["desc"],
        url: json["url"],
        icon: json["icon"],
        image: json["image"],
        lang: json["lang"],
        disliked: json["disliked"],
        category: json["category"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tagline": tagline,
        "color": color,
        "desc": desc,
        "url": url,
        "icon": icon,
        "image": image,
        "lang": lang,
        "disliked": disliked,
        "category": category,
        "order": order,
      };
}
