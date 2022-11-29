// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import '../../../core.dart';
import '../../domain/usecases/share_file_usecase.dart';
import '../../utils/file_name_from_path.dart';
import '../../utils/share/share_file_extend.dart';

class ShareFileStore extends NotifierStore<Exception, bool> {
  final String? urlRemoteFile;
  final TokenEntity? token;
  final IDownloadFileUsecaseFactory downloadFileUsecaseFactory;
  final MatrixFileType matrixFileType;
  ShareFileStore({
    required this.matrixFileType,
    this.urlRemoteFile,
    this.token,
    required this.downloadFileUsecaseFactory,
  }) : super(false);

  Future<void> shareSelectedFile() async {
    setLoading(true);
    // se tiver urlPathFile faz o download para compartilhar
    // se tiver urlPathFile só compartilha
    if ((token != null) && (urlRemoteFile != null)) {
      final result = await downloadFileUsecaseFactory(
        token: token!,
        filePath: urlRemoteFile!,
      );
      result.fold((l) => setError(Exception(l.statusMessage)), (r) async {
        //Recupera caminho local do arquivo
        Directory tempDir = await getTemporaryDirectory();
        await tempDir.create(recursive: true);
        String tempPath = tempDir.path;
        String nameFileForPath =
            FileNameFromPath().call(completPath: urlRemoteFile!);
        String localPath = '$tempPath/$nameFileForPath';
        //Compartilha arquivo local
        matrixFileType == MatrixFileType.image
            ? await ShareFileUsecase(
                ShareFileExtend.instance,
              ).shareImageFromLocalStorage(
                path: localPath,
                text: nameFileForPath,
                subject: 'Image.',
              )
            : await ShareFileUsecase(
                ShareFileExtend.instance,
              ).sharePdfFromLocalStorage(
                path: localPath,
                text: nameFileForPath,
                subject: 'Image.',
              );
      });
    }
    update(!state);
    setLoading(false);
  }
}
