part of services;

class ProfileService {
  follow(String username) async => await api.post('/profiles/$username/follow');

  unfollow(String username) async => await api.delete('/profiles/$username/follow');

  get(String username) async => await api.get('/profiles/$username');
}
