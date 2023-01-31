import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/feature/admin/views/home_admin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

abstract class AdminPage extends State<HomeAdmin> {
  Stream<List<InfoModel>> getStreamInfo() async* {
    yield* FirebaseFirestore.instance.collection('info').snapshots().map(
        (event) =>
            event.docs.map((e) => InfoModel.fromJson(e.data())).toList());
  }
}
