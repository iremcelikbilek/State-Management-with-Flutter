import 'dart:io';

import 'package:contact_with_provider/database/database_helper.dart';
import 'package:contact_with_provider/models/kullanici.dart';
import 'package:contact_with_provider/screens/add_contact_page.dart';
import 'package:contact_with_provider/utils/format_photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Page"),
      ),
      body: ListBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) =>
                MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: DatabaseHelper()),
                    ChangeNotifierProvider.value(value: FormatPhoto()),
                  ],
                    child: AddContactPage()),
          ));
        },
      ),
    );
  }
}

class ListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseHelper>(
      builder: (context, databaseHelper, child) {
        return FutureBuilder(
          future: databaseHelper.kullaniciListesiniGetir(),
          builder: (context, AsyncSnapshot<List<Kullanici>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //sleep(Duration(milliseconds: 500));
              return (snapshot.data.length <= 0)
                  ? Center(child: Text("Gösterilecek contact yok"))
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          leading: CircleAvatar(
                            backgroundImage: (snapshot.data[index].kullaniciResim != null)
                                ? Provider.of<FormatPhoto>(context).imageFromBase64String(snapshot.data[index].kullaniciResim)
                                : AssetImage("assets/images/profil_icon.png"),
                          ),
                          title: Text(snapshot.data[index].kullaniciAd +
                              " " +
                              snapshot.data[index].kullaniciSoyad),
                          subtitle: Text(snapshot.data[index].kullaniciTelefon),
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Email",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data[index].kullaniciEmail ??
                                            "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .accentColor),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "İlişki",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data[index]
                                                .kullaniciIliski ??
                                            "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .accentColor),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Meslek",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data[index]
                                                .kullaniciMeslek ??
                                            "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .accentColor),
                                      ),
                                    )
                                  ],
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    OutlineButton(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColor),
                                        onPressed: () {
                                          databaseHelper.kullaniciSil(snapshot
                                              .data[index].kullaniciID);
                                        },
                                        child: Text(
                                          "SİL",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    OutlineButton(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .accentColor),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider.value(
                                                    value: DatabaseHelper(),
                                                    child: AddContactPage()),
                                          ));
                                        },
                                        child: Text(
                                          "GÜNCELLE",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .accentColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text(
                      "Yükleniyor",
                    )
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
