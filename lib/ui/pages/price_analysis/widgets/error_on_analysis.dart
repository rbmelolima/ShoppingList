import 'package:flutter/material.dart';

class ErrorOnAnalysis extends StatelessWidget {
  const ErrorOnAnalysis({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Falha ao buscar menores preços, tente novamente"),
      ),
    );
  }
}
