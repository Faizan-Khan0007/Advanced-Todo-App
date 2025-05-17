// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String name;
  final String email;
  User({
    required this.id,
    required this.name,
    required this.email,
  });
}

//now it is not in the domain folder is that fine?
//yes there is no compulsion,entity is there so that your code should have more structure and it is not 
//violated here because other features can depend on the core
