import 'package:core/core.dart' as core show ShareFileStore;
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../../base_style_sheet.dart';

class ShareButton extends StatefulWidget {
  final String url;
  final TokenEntity token;
  final MatrixFileType matrixFileType;
  const ShareButton({
    super.key,
    required this.url,
    required this.token,
    required this.matrixFileType,
  });

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  late final core.ShareFileStore shareStore;
  final SnackBar snackBar = const SnackBar(
    content: Text(
      'Não foi possível compartilhar este arquivo,'
      ' verifique sua conexão com a internet e tente novamente.',
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 5),
    backgroundColor: Colors.redAccent,
  );

  @override
  void initState() {
    shareStore = core.ShareFileStore(
      matrixFileType: widget.matrixFileType,
      urlRemoteFile: widget.url,
      token: widget.token,
      downloadFileUsecaseFactory: DownloadFileUsecaseFactory(),
    );
    shareStore.observer(
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<core.ShareFileStore, Exception, bool>(
      store: shareStore,
      onLoading: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DefaultLoading(
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      onState: (context, state) =>
          TripleBuilder<core.ShareFileStore, Exception, bool>(
        store: shareStore,
        builder: (_, tripal) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 24,
                onPressed:
                    tripal.isLoading ? null : shareStore.shareSelectedFile,
                icon: Icon(
                  CoreIcons.share,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
