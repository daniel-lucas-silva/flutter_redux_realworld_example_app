part of store;

Future<Store<AppState>> createStore() async {

  final initialState = await persistor.load();

  final Store<AppState> store = Store(
    appReducer,
    initialState: initialState,
    middleware: createMiddleware(),
  );

  return store;
}
