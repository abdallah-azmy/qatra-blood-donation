class User {
  String displayName;
  String email;
  String uid;
  String phone;
  String fasila;
  String address;
  String dateOfDonation;
  var date;

  User({this.displayName,
    this.email,
    this.uid,
    this.phone,
    this.fasila,
    this.address,
    this.dateOfDonation,
    this.date});

  factory User.fromMap(Map<String, dynamic> map) => User(
        displayName: map['displayName'],
        email: map['email'],
        uid: map['uid'],
        phone: map['phone'],
        fasila: map['fasila'],
    address: map['address'],
    dateOfDonation: map['dateOfDonation'],
    date: map['date'],
      );

  Map<String, dynamic> toMap(User user) => {
        'displayName': user.displayName,
        'email': user.email,
        'uid': user.uid,
        'phone': user.phone,
    'fasila': user.fasila,
    'address': user.address,
    'dateOfDonation': user.dateOfDonation,
    'date': user.date,
      };
}
