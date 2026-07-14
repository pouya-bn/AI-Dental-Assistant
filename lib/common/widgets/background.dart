import 'package:ava/common/values/imports.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF012459),
            Color(0x000065FF),
            Color(0xFF0349B3),
            Color(0xFF012459),
          ],
          stops: [0.0, 0.16, 0.31, 0.71],
        ).createShader(bounds);
      },
      child: Container(
        color: AppColors.blue14,
      ),
    );
  }
}

class Background2 extends StatelessWidget {
  const Background2({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/background.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
