// Учебная учётная запись живёт только в памяти процесса.
class Account {
  Account(this.name, this.email, this.password);
  String name;
  String email;
  String password;
  String avatar = 'json';
}

class Session {
  static Account? account;
  static bool matches(String email, String password) {
    final user = account;
    return user != null && user.email == email.trim().toLowerCase() &&
        user.password == password;
  }
}
