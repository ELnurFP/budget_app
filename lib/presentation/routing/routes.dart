enum Routes {
  splash(name: 'Splash', path: '/'),
  notFound(name: 'Not Found', path: '/not-found'),
  root(name: 'Home', path: '/home');

  final String name;
  final String path;

  const Routes({
    required this.name,
    required this.path,
  });

  static List<String> get unprotectedRoutes {
    return <String>[
      splash.path,
      notFound.path,
    ];
  }
}
