enum AfrDialogAction { confirm, abort }

extension AfrDialogActionX on AfrDialogAction {
  bool get isConfirmed => this == AfrDialogAction.confirm;
  bool get isAborted => this == AfrDialogAction.abort;
}

