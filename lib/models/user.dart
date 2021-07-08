class User {
  late String uid;
  late String firstName;
  late String lastName;
  late String contact;
  late String address;
  late String role;

  // User({required this.uid});
  User(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.contact,
      required this.address,
      required this.role});

  User.map(dynamic user){
    this.uid = user["uid"];
    this.firstName = user["firstName"];
    this.lastName = user["lastName"];
    this.contact = user["contact"];
    this.address = user["address"];
    this.role = user["role"];
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['uid'] = uid;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['contact'] = contact;
    map['address'] = address;
    map['role'] = role;
    return map;
  }

  User.fromMap(Map<String, dynamic> map){
    this.uid = map['uid'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.contact = map['contact'];
    this.address = map['address'];
    this.role = map['role'];
  }

}
