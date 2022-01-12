class Contact {
  Contact({
    required this.name,
    required this.phone,
    required this.image,
  });

  String name;
  String phone;
  String image;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json["name"],
        phone: json["phone"],
        image: json["image"],
      );
}
