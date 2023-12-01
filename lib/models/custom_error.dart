class CustomError {
  final String code;
  final String message;
  final String plugin;

  CustomError({this.code = '', this.message = '', this.plugin = ''});

  @override
  String toString() =>
      'CustomError from <code: $code, message: $message, plugin: $plugin>';
}
