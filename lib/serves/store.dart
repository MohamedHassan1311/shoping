import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoping/models/cover.dart';
import 'package:shoping/models/product.dart';

import '../constant.dart';

class Store {
  final Firestore _firestore = Firestore.instance;
  addProudect(Product product) async {
    await _firestore.collection(KProudectColletion).add({
      KProudectCatogery: product.Pcatogery,
      KProudectLoction: product.Ploction,
      KProudectDescription: product.Pdescriptin,
      KProudectName: product.Pname,
      KProudectPrice: product.Pprice,
      KProudectPrand: product.ProPrand,
      KProudectCondation: product.ProPcon,
    });
  }

  addCover(Cover cover) async {
    await _firestore
        .collection(Kcover)
        .add(({KcoverPhoto: cover.CoverLocation}));
  }

  Stream<QuerySnapshot> loadProudect(Consts) {
    return _firestore.collection(Consts).snapshots();
  }

  deletProduct(proId) {
    _firestore.collection(KProudectColletion).document(proId).delete();
  }

  editProduct(data, id) {
    _firestore.collection(KProudectColletion).document(id).updateData(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(Koreder).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(KorederDetiles).document().setData({
        KProudectName: product.Pname,
        KProudectPrice: product.Pprice,
        KQantan: product.qantati,
        KProudectLoction: product.Ploction,
//        KProudectCatogery: product.Pcatogery
      });
    }
  }
}
