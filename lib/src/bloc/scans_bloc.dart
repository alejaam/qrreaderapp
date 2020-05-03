import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton =
      new ScansBloc._internal(); //Esto es un constructor interno.

  factory ScansBloc() {
    //El objetivo del factory es regresar la instancia de arriba del singleton que ya deberia estar instanciada.
    return _singleton;
  }
  ScansBloc._internal() {
    // Obtener Scans de la DB
    obtenerScans();
  }

  final _scansController = StreamController<
      List<
          ScanModel>>.broadcast(); //Es broadcast porque en varios lados va a estar escuchando.

//Para escuchar la información que fluye en este stream
  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose() {
    _scansController?.close(); //Por si no tiene un objeto ponemos el ?
  }

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() {
    DBProvider.db.deleteAll();
    obtenerScans();
  }
}
