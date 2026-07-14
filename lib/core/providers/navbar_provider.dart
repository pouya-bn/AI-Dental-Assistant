import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navbar_provider.g.dart';

@Riverpod(keepAlive: true)
class Navbar extends _$Navbar {
  @override
  int build() => 0;

  void change(int index) {
    state = index;
  }
}
