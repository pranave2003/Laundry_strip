class UserModel {
  String? email;
  String? password;
  String? uid;
  String? name;
  String? District;
  String? Address;
  String? phone;
  String?status;
  String?ban;

  UserModel(
      {this.email,
      this.password,
      this.name,
      this.uid,
      this.District,
      this.Address,
      this.phone,
      this.status,
        this.ban
      }
      );
}
