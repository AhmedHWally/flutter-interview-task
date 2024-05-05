class RaceModel {
  final String name;
  final String organizer;
  final String date;
  final String country;
  final String city;
  final String image;
  final String type;
  final String distances;

  RaceModel(
      {required this.name,
      required this.organizer,
      required this.date,
      required this.country,
      required this.city,
      required this.image,
      required this.type,
      required this.distances});

  factory RaceModel.fromJson(Map<String, dynamic> json) => RaceModel(
      name: json['name'],
      organizer: json['organizer'] ?? '',
      date: json['date'],
      country: json['country'],
      city: json['city'],
      image: json['image'],
      type: json['type'],
      distances: json['distances']);
}
