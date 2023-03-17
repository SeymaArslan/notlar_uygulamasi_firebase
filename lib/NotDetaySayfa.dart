import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi_firabase/Notlar.dart';
import 'package:notlar_uygulamasi_firabase/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NotDetaySayfa extends StatefulWidget {
  Notlar not;
  NotDetaySayfa({required this.not});

  @override
  State<NotDetaySayfa> createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  var refNotlar = FirebaseDatabase.instance.ref().child("notlar");

  Future<void> sil(String not_id) async{
  refNotlar.child(not_id).remove();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa() ));
  }

  Future<void> guncelle(String not_id, String ders_adi, int not1, int not2) async{
    var bilgi = HashMap<String, dynamic>();
    bilgi["ders_adi"] = ders_adi;
    bilgi["not1"] = not1;
    bilgi["not2"] = not2;
    refNotlar.child(not_id).update(bilgi);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa() ));
  }

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfDersAdi.text = not.ders_adi;
    tfNot1.text = not.not1.toString();
    tfNot2.text = not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DERS NOT DETAY"),
        actions: [
          TextButton(
            onPressed: (){
              sil(widget.not.not_id);   },
            child: Text("Sil", style: TextStyle(color: Colors.white),),
          ),
          TextButton(
            child: Text("Guncelle", style: TextStyle(color: Colors.white),),
            onPressed: (){
              guncelle(widget.not.not_id, tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text) );
            },
          )
        ],
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(hintText: "Ders Adı"),    ),
              TextField(
                controller: tfNot1,
                decoration: InputDecoration(hintText: "1. Not"),    ),
              TextField(
                controller: tfNot2,
                decoration: InputDecoration(hintText: "2. Not"),    ),
            ],
          ),
        ),
      ),
    );
  }
}
