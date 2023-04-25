part of pin_code_fields;

class Gradiented extends StatelessWidget {
  const Gradiented({super.key, required this.child, required this.gradient});

  final Widget child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) => ShaderMask(shaderCallback: gradient.createShader, child: child);
}
