import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi_firabase/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NotKayitSayfa extends StatefulWidget {
  @override
  State<NotKayitSayfa> createState() => _NotKayitSayfaState();
}

class _NotKayitSayfaState extends State<NotKayitSayfa> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  var refNotlar = FirebaseDatabase.instance.ref().child("notlar");

  Future<void> kayit(String ders_adi, int not1, int not2) async{
    var bilgi = HashMap<String, dynamic>();
    bilgi["not_id"] = ""; // not_id yi boş bıraktık sebebi kaydı id tutarak almayışımız
    bilgi["ders_adi"] = ders_adi;
    bilgi["not1"] = not1;
    bilgi["not2"] = not2;
    refNotlar.push().set(bilgi);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa() ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DERS NOTU KAYDI"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(hintText: "Ders Adı"),
              ),
              TextField(
                controller: tfNot1,
                decoration: InputDecoration(hintText: "1. Not"),
              ),
              TextField(
                controller: tfNot2,
                decoration: InputDecoration(hintText: "2. Not"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          kayit(tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
        },
        tooltip: "Not Kayıt",
        icon: const Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
