part of services;

class AuthService {
  static login(email, password) async => await api.post(
        '/users/login',
        data: {
          "user": {
            "email": email,
            "password": password,
          }
        },
      );

  static register(email, password, username) async => await api.post(
        '/users',
        data: {
          "user": {
            "email": email,
            "password": password,
            "username": username,
          }
        },
      );

  static update(data) async => await api.put('/user', data: { "user": data });

  static current() async => await api.get('/user');
}
