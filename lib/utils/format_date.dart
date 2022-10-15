import 'dart:developer';

String formatDate(DateTime date) {
  try {
    return "${date.day}/${date.month}/${date.year} às ${date.hour}:${date.minute}";
  } catch (e) {
    log("Erro ao converter a data para o formato esperado");
    return "";
  }
}
