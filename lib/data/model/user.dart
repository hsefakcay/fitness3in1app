class User {
  String id;
  String name;
  String surname;
  String mail;
  String password;
  int age;
  String gender;
  double height;
  double weight;
  String programType;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.mail,
    required this.password,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.programType,
  });

  // Create a User object from a map (usually from Firebase)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      mail: map['mail'],
      password: map['password'],
      age: map['age'],
      gender: map['gender'],
      height: map['height'],
      weight: map['weight'],
      programType: map['programType'],
    );
  }

  // Convert the User object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'mail': mail,
      'password': password,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'programType': programType,
    };
  }
}
