import 'package:flutter_riverpod/flutter_riverpod.dart';

final isViewList = StateProvider<bool>((ref) => false);

void toggleView(WidgetRef ref) {
  ref
      .read(isViewList.notifier)
      .update((state) => ref.read(isViewList) == true ? false : true);
}
