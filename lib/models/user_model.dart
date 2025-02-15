class UserModel{
    String? uid;
    String fullName;
    String email;
    String phone;
    String password;

    // Constructor
    UserModel({
        this.uid,
        required this.email,
        required this.phone,
        required this.password,
        required this.fullName
    });

    Map<String,dynamic> toJson(){
        return {
            'uid': uid,
            'fullName': fullName,
            'email': email,
            'phone': phone,
            'password': password
        };
    }

    factory UserModel.fromJson(Map<String,dynamic> json){
        return UserModel(
           uid: json['uid'],
            fullName: json['fullName'],
            email: json['email'],
            phone: json['phone'],
            password: json['password']?? ''  // default to empty string if 'password' field is missing in JSON
        );
    }
}