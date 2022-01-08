// To parse this JSON data, do
//     final banckCardModel = banckCardModelFromJson(jsonString);
import 'dart:convert';

BanckCardModel banckCardModelFromJson(String str) =>
    BanckCardModel.fromJson(json.decode(str));

String banckCardModelToJson(BanckCardModel data) => json.encode(data.toJson());

class BanckCardModel {
  BanckCardModel({
    required this.currentAmount,
    required this.expireDate,
    required this.id,
    required this.name,
    required this.numberCard,
    required this.wonerName,
  });

  String currentAmount;
  String expireDate;
  String id;
  String name;
  String numberCard;
  String wonerName;

  factory BanckCardModel.fromJson(Map json) {
    if (json.isEmpty) {
      return BanckCardModel(
        currentAmount: 'currentAmount',
        expireDate: 'expireDate',
        id: 'id',
        name: 'name',
        numberCard: 'numberCard',
        wonerName: 'wonerName',
      );
    }
    return BanckCardModel(
      currentAmount: json["currentAmount"] as String,
      expireDate: json["expireDate"] as String,
      id: json["id"] as String,
      name: json["name"] as String,
      numberCard: json["numberCard"] as String,
      wonerName: json["wonerName"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "currentAmount": currentAmount,
        "expireDate": expireDate,
        "id": id,
        "name": name,
        "numberCard": numberCard,
        "wonerName": wonerName,
      };
}
