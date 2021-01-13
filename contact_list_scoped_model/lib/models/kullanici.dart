class Kullanici {
  int kullaniciID;
  String kullaniciAd;
  String kullaniciSoyad;
  String kullaniciTelefon;
  String kullaniciEmail;
  String kullaniciResim;
  String kullaniciIliski;
  String kullaniciMeslek;

  Kullanici(this.kullaniciAd, this.kullaniciSoyad, this.kullaniciTelefon,
      this.kullaniciEmail, this.kullaniciResim, this.kullaniciIliski, this.kullaniciMeslek);

  Kullanici.withID(this.kullaniciID, this.kullaniciAd, this.kullaniciSoyad,
      this.kullaniciTelefon, this.kullaniciEmail, this.kullaniciResim, this.kullaniciIliski, this.kullaniciMeslek);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['kullaniciID'] = kullaniciID;
    map['kullaniciAd'] = kullaniciAd;
    map['kullaniciSoyad'] = kullaniciSoyad;
    map['kullaniciTelefon'] = kullaniciTelefon;
    map['kullaniciEmail'] = kullaniciEmail;
    map['kullaniciResim'] = kullaniciResim;
    map['kullaniciIliski'] = kullaniciIliski;
    map['kullaniciMeslek'] = kullaniciMeslek;

    return map;
  }

  Kullanici.fromMap(Map<String, dynamic> map) {
    this.kullaniciID = map['kullaniciID'];
    this.kullaniciAd = map['kullaniciAd'];
    this.kullaniciSoyad = map['kullaniciSoyad'];
    this.kullaniciTelefon = map['kullaniciTelefon'];
    this.kullaniciEmail = map['kullaniciEmail'];
    this.kullaniciResim = map['kullaniciResim'];
    this.kullaniciIliski = map['kullaniciIliski'];
    this.kullaniciMeslek = map['kullaniciMeslek'];
  }
}
