class FileNameFromPath {
  FileNameFromPath._();
  static final FileNameFromPath _instance = FileNameFromPath._();

  factory FileNameFromPath() {
    return _instance;
  }

  String call({required String completPath}) {
    return completPath.split('/').last;
  }
}
