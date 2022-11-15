// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toDbJson());

class UserModel {
  UserModel({
    this.gender = "",
    this.name = const Name(),
    this.location = const Location(),
    this.email = "",
    this.login = const Login(),
    this.dob,
    this.registered,
    this.phone = "",
    this.cell = "",
    this.id = const Id(),
    this.picture = const Picture(),
    this.nat = "",
  });

  String gender;
  Name name;
  Location location;
  String email;
  Login login;
  Dob? dob;
  Dob? registered;
  String phone;
  String cell;
  Id id;
  Picture picture;
  String nat;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        gender: json["gender"] == null ? "" : json["gender"],
        name: json["name"] == null ? Name() : Name.fromJson(json["name"]),
        // location: json["location"] == null
        //     ? Location()
        //     : Location.fromJson(json["location"]),
        email: json["email"] == null ? "" : json["email"],
        // dob: json["dob"] == null ? Dob() : Dob.fromJson(json["dob"]),
        // registered: json["registered"] == null
        //     ? Dob()
        //     : Dob.fromJson(json["registered"]),
        phone: json["phone"] == null ? "" : json["phone"],
        id: json["id"] == null ? Id() : Id.fromJson(json["id"]),
        picture: json["picture"] == null
            ? Picture()
            : Picture.fromJson(json["picture"]),
      );

  factory UserModel.fromDbJson(Map<String, dynamic> json) => UserModel(
        gender: json["gender"] == null ? "" : json["gender"],
        name: json["name"] == null ? Name() : Name(first: json["name"]),
        // location: json["location"] == null
        //     ? Location()
        //     : Location.fromJson(json["location"]),
        email: json["email"] == null ? "" : json["email"],
        // dob: json["dob"] == null ? Dob() : Dob.fromJson(json["dob"]),
        // registered: json["registered"] == null
        //     ? Dob()
        //     : Dob.fromJson(json["registered"]),
        phone: json["phone"] == null ? "" : json["phone"],
        id: json["id"] == null ? Id() : Id(name: json["uid"]),
        picture: json["picture"] == null
            ? Picture()
            : Picture(medium: json["picture"]),
      );

  Map<String, dynamic> toDbJson() => {
        "gender": gender == null ? "N/A" : gender,
        "name": name == null ? "" : name.title + name.first + name.last,
        "location": location == null ? "" : location.country,
        "email": email == null ? "" : email,
        "phone": phone == null ? "" : phone,
        "uid": id == null ? "" : id.name,
        "picture": picture == null ? "" : picture.medium,
      };
}

class Dob {
  Dob({
    this.date,
    this.age = "0",
  });

  DateTime? date;
  String age;

  factory Dob.fromJson(Map<String, dynamic> json) => Dob(
        date: json["date"] == null
            ? DateTime.now()
            : DateTime.parse(json["date"]),
        age: json["age"] == null ? "0" : json["age"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "date": date == null
            ? DateTime.now().toIso8601String()
            : date!.toIso8601String(),
        "age": age == null ? null : age,
      };
}

class Id {
  const Id({
    this.name = "",
    this.value = "",
  });

  final String name;
  final String value;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        name: json["name"] == null ? "" : json["name"],
        value: json["value"] == null ? "" : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "value": value == null ? null : value,
      };
}

class Location {
  const Location({
    this.street = const Street(),
    this.city = "",
    this.state = "",
    this.country = "",
    this.postcode = "",
    this.coordinates = const Coordinates(),
    this.timezone = const Timezone(),
  });

  final Street street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final Coordinates coordinates;
  final Timezone timezone;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        street:
            json["street"] == null ? Street() : Street.fromJson(json["street"]),
        city: json["city"] == null ? "" : json["city"],
        state: json["state"] == null ? "" : json["state"],
        country: json["country"] == null ? "" : json["country"],
        postcode: json["postcode"] == null ? "" : json["postcode"],
        coordinates: json["coordinates"] == null
            ? Coordinates()
            : Coordinates.fromJson(json["coordinates"]),
        timezone: json["timezone"] == null
            ? Timezone()
            : Timezone.fromJson(json["timezone"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street == null ? null : street.toJson(),
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "postcode": postcode == null ? null : postcode,
        "coordinates": coordinates == null ? null : coordinates.toJson(),
        "timezone": timezone == null ? null : timezone.toJson(),
      };
}

class Coordinates {
  const Coordinates({
    this.latitude = "",
    this.longitude = "",
  });

  final String latitude;
  final String longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"] == null ? "" : json["latitude"],
        longitude: json["longitude"] == null ? "" : json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude == null ? "" : latitude,
        "longitude": longitude == null ? "" : longitude,
      };
}

class Street {
  const Street({
    this.number = "",
    this.name = "",
  });

  final String number;
  final String name;

  factory Street.fromJson(Map<String, dynamic> json) => Street(
        number: json["number"] == null ? "" : json["number"].toString(),
        name: json["name"] == null ? "" : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "number": number == null ? null : number,
        "name": name == null ? null : name,
      };
}

class Timezone {
  const Timezone({
    this.offset = "",
    this.description = "",
  });

  final String offset;
  final String description;

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        offset: json["offset"] == null ? "" : json["offset"],
        description: json["description"] == null ? "" : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset == null ? null : offset,
        "description": description == null ? null : description,
      };
}

class Login {
  const Login({
    this.uuid = "",
    this.username = "",
    this.password = "",
    this.salt = "",
    this.md5 = "",
    this.sha1 = "",
    this.sha256 = "",
  });

  final String uuid;
  final String username;
  final String password;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        uuid: json["uuid"] == null ? "" : json["uuid"],
        username: json["username"] == null ? "" : json["username"],
        password: json["password"] == null ? "" : json["password"],
        salt: json["salt"] == null ? "" : json["salt"],
        md5: json["md5"] == null ? "" : json["md5"],
        sha1: json["sha1"] == null ? "" : json["sha1"],
        sha256: json["sha256"] == null ? "" : json["sha256"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid == null ? null : uuid,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "salt": salt == null ? null : salt,
        "md5": md5 == null ? null : md5,
        "sha1": sha1 == null ? null : sha1,
        "sha256": sha256 == null ? null : sha256,
      };
}

class Name {
  const Name({
    this.title = "",
    this.first = "",
    this.last = "",
  });

  final String title;
  final String first;
  final String last;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        title: json["title"] == null ? "" : json["title"],
        first: json["first"] == null ? "" : json["first"],
        last: json["last"] == null ? "" : json["last"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "first": first == null ? null : first,
        "last": last == null ? null : last,
      };
}

class Picture {
  const Picture({
    this.large = "",
    this.medium = "",
    this.thumbnail = "",
  });

  final String large;
  final String medium;
  final String thumbnail;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        large: json["large"] == null ? "" : json["large"],
        medium: json["medium"] == null ? "" : json["medium"],
        thumbnail: json["thumbnail"] == null ? "" : json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "large": large == null ? null : large,
        "medium": medium == null ? null : medium,
        "thumbnail": thumbnail == null ? null : thumbnail,
      };
}
