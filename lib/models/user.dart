part of 'models.dart';

class User extends Equatable {
  final int id;
  final String first_name;
  final String last_name;
  final String username;
  final String gender;
  final String email;
  final String phonenumber;
  final String urlphoto;
  final String bio;
  final int followers_count;
  final int following_count;
  static String token;

  User(
      {this.id,
      this.first_name,
      this.last_name,
      this.username,
      this.gender,
      this.email,
      this.phonenumber,
      this.urlphoto,
      this.bio,
      this.followers_count,
      this.following_count});

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        first_name: data['first_name'],
        last_name: data['last_name'],
        username: data['username'],
        gender: data['gender'],
        email: data['email'],
        urlphoto: data['urlphoto'],
        bio: data['bio'],
        followers_count: data['followers_count'],
        following_count: data['following_count'],
      );

  User copyWith({
    int id,
    String first_name,
    String last_name,
    String username,
    String gender,
    String email,
    String phonenumber,
    String urlphoto,
    String bio,
    int followers_count,
    int following_count,
  }) =>
      User(
          id: id ?? this.id,
          first_name: first_name ?? this.first_name,
          last_name: last_name ?? this.last_name,
          username: username ?? this.username,
          gender: gender ?? this.gender,
          email: email ?? this.email,
          phonenumber: phonenumber ?? this.phonenumber,
          urlphoto: urlphoto ?? this.urlphoto,
          bio: bio ?? this.bio,
          followers_count: followers_count ?? this.followers_count,
          following_count: following_count ?? this.following_count);

  @override
  List<Object> get props => [
        id,
        first_name,
        last_name,
        username,
        gender,
        email,
        phonenumber,
        urlphoto,
        bio,
        followers_count,
        following_count
      ];

  
}

User mockUser = User(
      id: 0,
      first_name: 'Nicholas',
      last_name: 'Kevin',
      username: 'nikokevin29',
      gender: 'Male',
      email: 'nikokevin29@gmail.com',
      phonenumber: '082227975222',
      urlphoto: 'https://i.pinimg.com/474x/8a/f4/7e/8af47e18b14b741f6be2ae499d23fcbe.jpg',
      bio: 'an Ordinary Banana',
      followers_count: 999,
      following_count: 999);