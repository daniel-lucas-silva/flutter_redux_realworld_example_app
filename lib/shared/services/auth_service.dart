part of services;

class AuthService {
  static login(data) async => await api.post('/users/login', data: data);

  static register(data) async => await api.post('/users', data: data);

  static update(data) async => await api.put('/user', data: data);

  static current() async => await api.get('/user');
}
