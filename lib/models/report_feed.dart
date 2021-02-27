part of 'models.dart';

class ReportFeed extends Equatable {
  final int id;
  final int idFeed;
  final int idUser;
  ReportFeed({
    this.id,
    this.idFeed,
    this.idUser,
  });

  @override
  List<Object> get props => [
        id,
        idFeed,
        idUser,
      ];

  factory ReportFeed.fromJson(Map<String, dynamic> data) => ReportFeed(
        id: data['id'],
        idFeed: int.parse(data['id_feed'].toString()),
        idUser: int.parse(data['id_user'].toString()),
      );
}
