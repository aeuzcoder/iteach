class CourseModel {
  final String name;
  final int level;
  final int period;
  final String? image;
  int? id;
  final int teacherId;
  final int price;

  CourseModel({
    required this.name,
    required this.level,
    required this.period,
    this.image,
    required this.id,
    required this.teacherId,
    required this.price,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      name: json['name'],
      level: json['level'],
      period: json['period'],
      image: json['image'],
      id: json['id'],
      teacherId: json['teacher_id'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'period': period,
      if (image != null) 'image': image,
      if (id != null) 'id': id,
      'teacher_id': teacherId,
      'price': price,
    };
  }
}
