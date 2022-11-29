enum MatrixFileType { image, pdf, audio, video, other }

extension MatrixFileTypeExt on MatrixFileType {
  String get name {
    switch (this) {
      case MatrixFileType.image:
        return 'image';
      case MatrixFileType.pdf:
        return 'pdf';
      case MatrixFileType.audio:
        return 'audio';
      case MatrixFileType.video:
        return 'video';
      case MatrixFileType.other:
        return 'other';
    }
  }

  String get toJson {
    switch (this) {
      case MatrixFileType.image:
        return 'IMAGEM';
      case MatrixFileType.pdf:
        return 'PDF';
      case MatrixFileType.audio:
        return 'audio';
      case MatrixFileType.video:
        return 'video';
      case MatrixFileType.other:
        return 'OUTROS';
    }
  }
}

MatrixFileType matrixFileFromJson(String? type) {
  switch (type) {
    case 'IMAGEM':
      return MatrixFileType.image;
    case 'PDF':
      return MatrixFileType.pdf;
    case 'audio':
      return MatrixFileType.audio;
    case 'video':
      return MatrixFileType.video;
    case 'OUTROS':
      return MatrixFileType.other;
    default:
      return MatrixFileType.other;
  }
}
