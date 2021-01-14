# State-Management-with-Flutter

-----------

 Stateful Widget'lar aracılığıyla setState motudunu kullanarak UI'da değişiklik yapabiliyoruz. Fakat setState metodu her widget'ımız için gerekmese bile sürekli rebuild işlemi
 yapar. Küçük çaplı uygulamalarda bu sorun olmasa bile uygulamamız büyüdükçe bu durum bize sıkıntı yaratacaktır. Sadece gerekli widgetların yenilenmesi, uygulama performansını
 önemli ölçüde arttırır. Bu kısımda **State Management** dediğimiz olay bize yardımcı oluyor. Bu sayede bütün UI'ı rebuild etmek yerine sadece değişikliğe uğrayan widget'ları 
 yeniliyoruz.
 
 Bu olayı sağlamak için Flutter bize Provider ve Scoped Model gibi paketlerle yardımcı oluyor.
 
 - Provider ile Scoped Model Arasındaki Fark
 
 Temelde ikisi de aynı işlevi görüyor. İki paket arasında çok spesifik bi fark olduğu söylenemez. Genel olarak sadece syntax farkı var denilebilir.
 Dikkatimi çeken en önemli fark : 
 
  - Provider ile :
 ```javascript 
 home: MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DatabaseHelper()),
        ChangeNotifierProvider.value(value: FormatPhoto()),
      ],
        child: ContactPage()),
 ```
   - Scoped Model ile :
 ```javascript 
    home: ScopedModel(
        model: DatabaseHelper(),
        child: ScopedModel(
          model: FormatPhoto(),
            child: ContactPage())),
 ```
            
 **Provider** ile birden fazla sınıfı bir dizi şeklinde widget ağacına aktarabiliyorken **Scoped Model** ile iç içe Scoped Model kullanarak aktarabildim. 
 
 - **Syntax Karşılıkları (Provider vs Scoped Model)**
    1. **ChangeNotifier --> Model**  (İlgili değişikleri kontrol ettiğimiz sınıfa extend ederiz.(Genelde ViewModel kısmı için tercih edilebilir))
    2. **notifyListeners()**  (Yukarıdaki sınıfların extend edildiği sınıflarda değişiklikleri arayüze bildirmek için kullanılır iki paket için de kullanımı aynıdır.)
    3. **Consumer --> ScopedModelDescendant** (Değişiklik olması gereken widgetla sarmalanacak widgetlardır. İkisi de aynı parametreleri alır. BuidContext, ilgili           Provider/Model,
    ve child parametreleridir. Child parametresi sarmalanan widget'da build olmasını istemediğimiz bir kısım varsa kullanılmak için verilir ama kullanılması gerekmez.
    Bu widget kullanılırken dikkat edilmesi gereken en önemi şey sarmalandığı widget kümesini olabildiğince minimum seviyede tutmaktır. Aksi durumda gerekmeyen kısımların tekrar
    rebuild olması State Management mantığına ters olacaktır. :blush:)
    4. **Provider.of<FormatPhoto>(context) --> ScopedModel.of<FormatPhoto>(context)** (İki kullanım da birbirine oldukça benzemektedir. Bazı durumlarda widgeti 3. maddedeki
    widget'larla sarmalamak yerine tek bir yerde kullanmak isteyebiliriz. Mesela bir butona basarken veya widget ağacında küçük bir kısımda değişiklik göstermek isteyebiliriz.
    Bu iki durum arasındaki fark hangisinde rebuild olması hangisinde yapılacak değişikliği tetiklemesi gerektiği. Eğer bir butonsa yapılacak değişikliği tetiklemsi gerekir ki
    bu durumda rebuild olmasına gerek yoktur. Bu yüzden (context, listen: false) yapılır. Aksi durumda (context) parametresinin geçilmesi yeterlidir.)
  
  > Aradaki farklar yukarıdaki iki projede daha anlaşılır bir şekilde fark edilecektir. :+1:
  
  ----------
  

   
