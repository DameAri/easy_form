import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///Poner la primera mayuscula
String capitalizar(String texto) {
  String res = "";
  if (texto.length > 0) {
    res = texto[0].toUpperCase() + texto.substring(1).toLowerCase();
  }
  return res;
}

List<String> meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];

String colon = '₡';

String formatoNumero(String numero) {
  return numero.replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

Widget formatoFecha(String fecha, double screenHeight, Color color, {bool simple = false}) {
  try {
    int hour = int.tryParse(fecha.split(' ')[1].split(':')[0]) ?? 0;
    bool isPM = hour >= 12;
    Widget hourWid = Text(
      hour.toString() + ' : ' + fecha.split(' ')[1].split(':')[1] + (isPM ? "pm" : "am"),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color),
    );
    return simple
        ? hourWid
        : Column(
            children: [
              Text(
                fecha.split(' ')[0],
                style: TextStyle(fontSize: 16, color: color),
              ),
              hourWid,
            ],
          );
  } catch (err) {
    return Container();
  }
}

///Gives the collection reference path from root
CollectionReference<Map<String, dynamic>> collection(String path) {
  return FirebaseFirestore.instance.collection(path);
}

///Gives a DocumentReference from a path from root
DocumentReference<Map<String, dynamic>> doc(String path) {
  return FirebaseFirestore.instance.doc(path);
}
