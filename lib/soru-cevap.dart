// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, camel_case_types, unnecessary_new, prefer_const_constructors_in_immutables, avoid_returning_null_for_void, file_names

import 'dart:ffi';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/getwidget.dart';

Color renk = Colors.white;
Color dogru_isaretleme = Colors.white;
int puan = 0;
bool basildi = false;

class soru_cevap extends StatefulWidget {
  const soru_cevap({Key? key}) : super(key: key);

  @override
  State<soru_cevap> createState() => _soru_cevapState();
}

class _soru_cevapState extends State<soru_cevap> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> dataList = jsonDecode(sorular);
    int index_degeri = Random().nextInt(dataList.length);
    List butonlar = [
      yanlis_butonu(
        dataList: dataList,
        index_degeri: index_degeri,
        padding: 10,
        yanlis: "yanlis0",
      ),
      yanlis_butonu(
        dataList: dataList,
        index_degeri: index_degeri,
        padding: 10,
        yanlis: "yanlis1",
      ),
      ///////////////////////////////////////////////////////////////
      yanlis_butonu(
        dataList: dataList,
        index_degeri: index_degeri,
        padding: 10,
        yanlis: "yanlis2",
      ),

      ///////////////////////////////////////////////////////////////////

      ///////////////////////////////////////////////////////////////////////
      dogru_buton(dataList: dataList, index_degeri: index_degeri),
      ///////////////
    ];
    butonlar.shuffle();
    print(butonlar);

    return Scaffold(
      appBar: appbar(context),
      floatingActionButton: devam(dataList, butonlar),
      body: Center(
        child: Column(children: [
          Card(
            color: Colors.black,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.question_mark,
                    color: Colors.white,
                    size: 40,
                  ),
                  title: Text(
                    dataList[index_degeri]["Soru"],
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Column(
                  children: [
                    butonlar[0],
                    butonlar[1],
                    butonlar[2],
                    butonlar[3],
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(100.0))),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.scoreboard),
                                  onPressed: () {},
                                ),
                                Text("Skor: $puan")
                              ],
                            ),
                          ),
                        ],
                      ),

                      ///////////////////////////////////////////////////////7
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  FloatingActionButton devam(List<dynamic> dataList, List siklar) {
    return FloatingActionButton(
        child: Icon(
          Icons.arrow_circle_right_outlined,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          basildi = false;
          dogru_isaretleme = Colors.white;
          int index_degeri = Random().nextInt(dataList.length);
          renk = Colors.white;
          karistir(siklar);
          setState(() {});
        });
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Buz Da????', style: TextStyle(fontStyle: FontStyle.normal)),
      backgroundColor: Colors.black,
      foregroundColor: Color.fromARGB(255, 80, 200, 255),
      actions: <Widget>[
        PopupMenuButton<int>(
          icon: Icon(Icons.home),
          iconSize: 42,
          padding: EdgeInsets.only(right: 20),
          onSelected: (item) {
            Navigator.of(context).pop();
          },
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0, child: Text('Ana Sayfa')),
          ],
        ),
      ],
    );
  }
}

class dogru_buton extends StatefulWidget {
  const dogru_buton({
    Key? key,
    required this.dataList,
    required this.index_degeri,
  }) : super(key: key);

  final List dataList;
  final int index_degeri;

  @override
  State<dogru_buton> createState() => _dogru_butonState();
}

class _dogru_butonState extends State<dogru_buton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 15, left: 40, right: 40),
      child: ElevatedButton(
        onPressed: () async {
          if (basildi == true) {
            return null;
          } else {
            puan += 10;
          }
          basildi = true;
          dogru_isaretleme = Colors.green;
          await EasyLoading.showSuccess('Do??ru Cevap!',
              duration: Duration(seconds: 1));
          setState(() {});
        },
        child: Text(widget.dataList[widget.index_degeri]["dogru"],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(300, 60),
          maximumSize: Size(300, 60),
          primary: dogru_isaretleme,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

class yanlis_butonu extends StatefulWidget {
  yanlis_butonu({
    Key? key,
    required this.dataList,
    required this.index_degeri,
    required this.padding,
    required this.yanlis,
  }) : super(key: key);

  final List dataList;
  final int index_degeri;
  final double padding;
  final String yanlis;

  @override
  State<yanlis_butonu> createState() => _yanlis_butonuState();
}

class _yanlis_butonuState extends State<yanlis_butonu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: widget.padding, bottom: 15, left: 40, right: 40),
      child: ElevatedButton(
        onPressed: () async {
          if (basildi == true) {
            return null;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Do??ru Cevap: ${widget.dataList[widget.index_degeri]["dogru"]}",
                style: TextStyle(fontSize: 19),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ));
            puan -= 10;
          }
          basildi = true;

          await EasyLoading.showError('Yanl???? Cevap!',
              duration: Duration(seconds: 1));
          renk = Colors.red;
          dogru_isaretleme = Colors.green;
          setState(() {});
        },
        child: Text(widget.dataList[widget.index_degeri][widget.yanlis],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16)),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(300, 60),
          maximumSize: Size(300, 60),
          primary: renk,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

void karistir(List liste) {
  liste.shuffle();
}

////////////////////////////////////////////////////////////////////////////////////////
String sorular = """[
  {
    "Soru": "Antartika hangi yar??m k??rededir?",
    "yanlis0":"Kuzey Yar??m K??re",
    "yanlis1":"Bat?? Yar??m K??re",
    "yanlis2":"Do??u Yar??m K??re",
    "dogru":"G??ney Yar??m K??re"
  },
  {
    "Soru": "Antarktika???n??n s??zc??k anlam?? nedir?",
    "yanlis0":"G??ney B??lgesi",
    "yanlis1":"Arktik ??st?? B??lge",
    "yanlis2":"Beyaz B??lge",
    "dogru":"Arktik Tersi B??lge"
  },
  {
    "Soru": "Antarktika???da kimler ya??ar?",
    "yanlis0":"Eskimolar",
    "yanlis1":"Hi?? kimse",
    "yanlis2":"Denizciler",
    "dogru":"Ara??t??rmac??lar"
  },
  {
    "Soru": "Antarktika???da kimler ya??ar?",
    "yanlis0":"Eskimolar",
    "yanlis1":"Hi?? kimse",
    "yanlis2":"Denizciler",
    "dogru":"Ara??t??rmac??lar"
  },
  {
    "Soru": "Antarktika nereye veya kime aittir?",
    "yanlis0":"Avrupa Birli??i",
    "yanlis1":"NATO",
    "yanlis2":"Amerika???ya",
    "dogru":"Hi??biri"
  },
  {
    "Soru": "Antarktika neden so??uktur?",
    "yanlis0":"Sera gaz?? fazla oldu??u i??in",
    "yanlis1":"Kar??n g??ne?? ??????nlar??n?? yans??tt?????? i??in",
    "yanlis2":"G??ne?????e ??ok uzak oldu??u i??in",
    "dogru":"G??ne?? ??????nlar?? e??ik a????yla geldi??i i??in"
  },
  {
    "Soru": "Antarktika???da ??l????len en y??ksek s??cakl??k nedir?",
    "yanlis0":"30,4 derece",
    "yanlis1":"10,7 derece",
    "yanlis2":"18,5 derece",
    "dogru":"20,4 derece"
  },
  {
    "Soru": "Antarktika???da ??l????len en y??ksek s??cakl??k nedir?",
    "yanlis0":"30,4 derece",
    "yanlis1":"10,7 derece",
    "yanlis2":"18,5 derece",
    "dogru":"20,4 derece"
  },
  {
    "Soru": "Antarktika???da ??l????len en d??????k s??cakl??k nedir?",
    "yanlis0":"- 100,9 derece",
    "yanlis1":"- 18,3 derece",
    "yanlis2":"- 50 derece",
    "dogru":"- 89,2 derece"
  },
  {
    "Soru": "G??ney I????klar?? neden olu??ur?",
    "yanlis0":"I????k atmosferde renkli g??r??lecek bi??imde k??r??l??r",
    "yanlis1":"Y??ld??zlar??n hareketi atmosferde ??????k yans??malar?? olu??turur",
    "yanlis2":"Kutuplardaki hava durumu ??????k k??r??lmalar??n?? etkiler",
    "dogru":"D??nya???n??n manyetik alan?? elektrik y??klerini kutuplara ??eker"
  },
 
  {
    "Soru": "G??ney I????klar??na ne ad verilir?",
    "yanlis0":"Aurora Borealis",
    "yanlis1":"Aurora Layman",
    "yanlis2":"Aurora Antarktis",
    "dogru":"Aurora Australis"
  },
  {
    "Soru": "Antarktika???da hangi canl?? t??r?? ya??ar?",
    "yanlis0":"Kutup Ay??lar??",
    "yanlis1":"Kutup Tilkileri",
    "yanlis2":"Morslar",
    "dogru":"Penguenler"
  },
  {
    "Soru": "Antarktika???da ka?? t??r penguen ya??ar?",
    "yanlis0":"16",
    "yanlis1":"7",
    "yanlis2":"2",
    "dogru":"5"
  },
  {
    "Soru": "Antarktika???daki penguenler nas??l say??l??r?",
    "yanlis0":"Elektronik K??pe Y??ntemiyle",
    "yanlis1":"S??r?? Takip Y??ntemiyle",
    "yanlis2":"S??r?? Takip Y??ntemiyle",
    "dogru":"Uydu g??r??nt??leri kullan??larak"
  },
  {
    "Soru": "Antarktika???da hangi t??r balina ya??amaz?",
    "yanlis0":"Kambur Balina",
    "yanlis1":"Katil Balina",
    "yanlis2":"Mavi Balina",
    "dogru":"Beyaz Balina"
  },
  {
    "Soru": "D??nya i??in en ??ok oksijen ??reten canl?? s??n??f?? hangisidir?",
    "yanlis0":"A??a??lar",
    "yanlis1":"??imenler",
    "yanlis2":"??i??ekler",
    "dogru":"Planktonlar ve Algler"
  },
  {
    "Soru": "Baz?? buzullar neden ye??il veya k??rm??z?? renkte g??r??n??r?",
    "yanlis0":"G??ne?? ??????nlar??n??n k??r??lma ??eklinden dolay??",
    "yanlis1":"????lerindeki minerallerden dolay??",
    "yanlis2":"??evre kirlili??inden dolay??",
    "dogru":"??zerlerindeki planktonlardan dolay??"
  },
  {
    "Soru": "Albedo nedir?",
    "yanlis0":"Buzullar??n ?????????? yans??tma durumu",
    "yanlis1":"I????????n parlakl??k ??l????t??",
    "yanlis2":"G??ne?? ??????nlar??n??n atmosferden yans??mas??",
    "dogru":"Bir cismin ?????????? yans??tma kapasitesi"
  },
  {
    "Soru": "Buzk??ranlar ne i?? yapar?",
    "yanlis0":"Buzullar?? k??rarak fok bal??klar??na yol a??ar",
    "yanlis1":"Ara??t??rma ??rne??i olarak buzul toplarlar",
    "yanlis2":"Petrole ula??mak i??in buzullar?? k??rarlar",
    "dogru":"Buzullar?? k??rarak gemilere yol a??arlar"
  },
  {
    "Soru": "Antarktika???y?? ??evreleyen denize ne ad verilir?",
    "yanlis0":"Kuzey Buz Denizi",
    "yanlis1":"Atlas Okyanusu",
    "yanlis2":"Pasifik Okyanusu",
    "dogru":"Antarktika Okyanusu"
  },
  {
    "Soru": "Buzullar??n mavi veya ??effaf g??r??nmelerinin nedeni nedir?",
    "yanlis0":"K??r??c??l??k indisi y??ksek buzullar mavi, d??????k buzullar ??effaf g??r??n??r",
    "yanlis1":"Y??ksekteki buzullar g??ky??z??n?? yans??tt?????? i??in mavi g??r??n??r, al??aktakiler ??effaft??r",
    "yanlis2":"Mineral oran?? fazla olan buzullar mavi, az olanlar ??effaft??r",
    "dogru":"Yeni buzullar beyaz, eski buzullar mavi renk g??r??n??r"
  },
  {
    "Soru": "Antarktika???y?? kimler ke??fetti?",
    "yanlis0":"Amerikal??lar",
    "yanlis1":"Norve??liler",
    "yanlis2":"Vikingler",
    "dogru":"??ngilizler"
  },
  {
    "Soru": "Kutuplar bizim i??in neden ??nemlidir?",
    "yanlis0":"K??lt??rel ??e??itlilik sa??lad??klar?? i??in",
    "yanlis1":"Kutuplarda ara??t??rma yapmak ??nemli oldu??u i??in",
    "yanlis2":"Kutuplarda bolca petrol bulundu??u i??in",
    "dogru":"Kutuplardaki hava ko??ullar??n??n de??i??mesi ekolojiyi etkiledi??i i??in"
  },
  {
    "Soru": "Buzullar erirse a??a????daki olaylardan hangisi ger??ekle??mez?",
    "yanlis0":"Kutuplardaki hayvanlar ??l??r",
    "yanlis1":"Deniz seviyesi y??kselir",
    "yanlis2":"Ekosistem zarar g??r??r",
    "dogru":"D??nyan??n ekseni de??i??ir"
  },
  {
    "Soru": "Kutuplar?? korumak i??in a??a????dakilerden hangisi yap??lmal??d??r?",
    "yanlis0":"Enerji israf?? yapmak",
    "yanlis1":"Kutuplardaki petrol?? ????karmak",
    "yanlis2":"Denizlere ????p atmak",
    "dogru":"At??klar?? geri d??n????t??rmek"
  },
  {
    "Soru": "Svalbard K??resel Tohum Deposu nerededir?",
    "yanlis0":"Antarktika???da ",
    "yanlis1":"Kanada???da",
    "yanlis2":"CERN???de ",
    "dogru":"Arktik???te"
  },
  {
    "Soru": "Kutuplardaki T??rkler hangi dili konu??ur?",
    "yanlis0":"K??rg??z T??rk??esi ",
    "yanlis1":"T??rkiye T??rk??esi",
    "yanlis2":"Kazak T??rk??esi",
    "dogru":"Yakut T??rk??esi"
  },
  {
    "Soru": "Kutuplardaki T??rkler hangi dili konu??ur?",
    "yanlis0":"K??rg??z T??rk??esi ",
    "yanlis1":"T??rkiye T??rk??esi",
    "yanlis2":"Kazak T??rk??esi",
    "dogru":"Yakut T??rk??esi"
  },
  {
    "Soru": "A??a????daki bilim insanlar??ndan hangisinin soyad?? Antarktika???da bir b??lgeye verilmi??tir?",
    "yanlis0":"Burcu ??zsoy",
    "yanlis1":"Sinan Yirmibe??o??lu",
    "yanlis2":"Aziz Sancar",
    "dogru":"Serap Tilav"
  },
  {
    "Soru": "??lk T??rk Kutup Kamp?? hangi y??l kurulmu??tur?",
    "yanlis0":"2010",
    "yanlis1":"2005",
    "yanlis2":"2010",
    "dogru":"2019"
  },
  {
    "Soru": "Okyanuslarda dola????m?? sa??layan ak??nt?? d??ng??s??n??n tamamlanmas?? ne kadar s??rer?",
    "yanlis0":"120 y??l",
    "yanlis1":"18 ay",
    "yanlis2":"16 hafta",
    "dogru":"1000 y??l"
  },
  {
    "Soru": "Hangisi Antarktika???da yerle??ik insan ya??am?? olmamas??na kar????n kirlilik olmas??n??n nedenlerinden biri de??ildir?",
    "yanlis0":"Hava kirlili??inin r??zgarlarla ta????nmas??",
    "yanlis1":"Ak??nt??lar??n kirlili??i ta????mas??",
    "yanlis2":"Gemilerin petrol s??z??nt??lar??",
    "dogru":"Kutup Sumrular??n??n gittikleri yerden getirdikleri"
  }
]""";
