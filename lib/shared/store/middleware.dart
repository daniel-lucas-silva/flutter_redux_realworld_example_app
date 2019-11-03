part of store;

final persistor = Persistor<AppState>(
  storage: FlutterStorage(
    key: 'conduite',
    location: FlutterSaveLocation.sharedPreferences,
  ),
  serializer: JsonSerializer<AppState>(AppState.rehydrationJSON),
);

List<Middleware<AppState>> createMiddleware() => <Middleware<AppState>>[
  thunkMiddleware,
  persistor.createMiddleware(),
  LoggingMiddleware.printer(),
];
