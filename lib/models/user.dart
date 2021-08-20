class User {
  String uid;
  String firstName;
  String lastName;
  String contact;
  String address;
  String role;
  String status;

  // User({required this.uid});
  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.contact,
      this.address,
      this.role,
      this.status
      });

  User.map(dynamic user){
    this.uid = user["uid"];
    this.firstName = user["firstName"];
    this.lastName = user["lastName"];
    this.contact = user["contact"];
    this.address = user["address"];
    this.role = user["role"];
    this.status = user["status"];
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['uid'] = uid;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['contact'] = contact;
    map['address'] = address;
    map['role'] = role;
    map['status'] = status;
    return map;
  }

  User.fromMap(Map<String, dynamic> map){
    this.uid = map['uid'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.contact = map['contact'];
    this.address = map['address'];
    this.role = map['role'];
    this.status = map['status'];
  }

}
