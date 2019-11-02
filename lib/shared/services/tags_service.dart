part of services;

class TagsService {
  getAll() async => await api.get('/tags');
}
