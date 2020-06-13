abstract class LanguagesState {
  static const noNetwork = const LanguagesNetworkError();
  static const loading = const LanguagesLoading();
  static const success = const LanguagesSuccess();
}

class LanguagesSuccess implements LanguagesState {
  const LanguagesSuccess();
}

class LanguagesNetworkError implements LanguagesState {
  const LanguagesNetworkError();
}

class LanguagesLoading implements LanguagesState {
  const LanguagesLoading();
}
