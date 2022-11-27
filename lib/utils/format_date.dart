import 'dart:developer';

String formatDate(DateTime date) {
  try {
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');

    return "${date.day}/${date.month}/${date.year} às $hour:$minute";
  } catch (e) {
    log("Erro ao converter a data para o formato esperado");
    return "";
  }
}
