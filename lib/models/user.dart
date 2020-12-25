part of 'models.dart';

class User extends Equatable {
  final int id;
  final String first_name;
  final String last_name;
  final String username;
  final String gender;
  final String email;
  final String phone_number;
  final String urlphoto;
  final String bio;
  final String email_verified_at;
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
      this.phone_number,
      this.urlphoto,
      this.bio,
      this.email_verified_at,
      this.followers_count,
      this.following_count});

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        first_name: data['first_name'],
        last_name: data['last_name'],
        username: data['username'],
        gender: data['gender'],
        email: data['email'],
        phone_number: data['phone_number'],
        urlphoto: data['url_photo'],
        bio: data['bio'],
        email_verified_at: data['email_verified_at'],
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
    String phone_number,
    String urlphoto,
    String bio,
    String email_verified_at,
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
        phone_number: phone_number ?? this.phone_number,
        urlphoto: urlphoto ?? this.urlphoto,
        bio: bio ?? this.bio,
        email_verified_at: email_verified_at ?? this.email_verified_at,
        followers_count: followers_count ?? this.followers_count,
        following_count: following_count ?? this.following_count,
      );

  @override
  List<Object> get props => [
        id,
        first_name,
        last_name,
        username,
        gender,
        email,
        phone_number,
        urlphoto,
        bio,
        email_verified_at,
        followers_count,
        following_count,
      ];
}

User mockUser = User(
  id: 0,
  first_name: 'Nicholas',
  last_name: 'Kevin',
  username: 'nikokevin29',
  gender: 'Male',
  email: 'nikokevin29@gmail.com',
  phone_number: '82227975222',
  urlphoto: 'https://i.pinimg.com/474x/8a/f4/7e/8af47e18b14b741f6be2ae499d23fcbe.jpg',
  bio: 'an Ordinary Banana',
  email_verified_at: '05-05-1999',
  followers_count: 999,
  following_count: 999,
);
