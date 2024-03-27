// ignore: file_names
// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;
import 'package:ila/Models/address.dart';
import 'package:ila/Models/blogs.dart';
import 'package:ila/Models/categories.dart';
import 'package:ila/Models/comment_blog.dart';
import 'package:ila/Models/handle_invoice_object.dart';
import 'package:ila/Models/handle_status_object.dart';
import 'package:ila/Models/invoice_details.dart';
import 'package:ila/Models/invoice_view.dart';
import 'package:ila/Models/object_message.dart';
import 'package:ila/Models/pro_cate.dart';
import 'package:ila/Models/products.dart';
import 'package:ila/Models/account.dart';
import 'package:ila/Models/reply_blog.dart';
import 'package:ila/Models/review.dart';
import 'package:ila/Models/supp_cart.dart';
import 'package:ila/Models/supplier.dart';
import 'package:ila/Models/vouchers.dart';
import 'package:ila/Models/watchlist.dart';
import 'package:ila/Utils/staticvalue.dart';

class APIServices {
  var url = 'http://192.168.1.52:8081/api';
  //LOGIN
  Future<Account> userLogin(username, password) async {
    final response = await http.get(Uri.parse(
        '$url/Account/usersLogin?userName=$username&userPassword=$password'));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed');
    }
  }

  //PRODUCTS
  Future<List<Products>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('$url/Products/userGetAllProducts'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Products>((json) => Products.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Products');
    }
  }

  Future<Products> fetchProductsDetails(idP) async {
    final response = await http
        .get(Uri.parse('$url/Products/userSearchProductbyID?idProduct=$idP'));
    if (response.statusCode == 200) {
      return Products.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Products Details');
    }
  }

  Future<List<Products>> fetchProductSupplier(idS) async {
    //http://localhost:8081/api/Products/userProductbySupplier?idSupplier=1
    final response = await http
        .get(Uri.parse('$url/Products/userProductbySupplier?idSupplier=$idS'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Products>((json) => Products.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Product Supplier');
    }
  }

  //CATEGORIES
  Future<List<ProductCategory>> fetchProductCategory(idS) async {
    final response = await http.get(Uri.parse(
        '$url/Category/userGetProductInCatebyIdSupplier?idSupplier=$idS'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductCategory>((json) => ProductCategory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Product Category');
    }
  }

  Future<List<Categories>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('$url/Category/userGetAllAvalibleCategory'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Categories>((json) => Categories.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Categories');
    }
  }

  //SUPPLIER
  Future<List<Supplier>> fetchSupplier(idC) async {
    final response = await http
        .get(Uri.parse('$url/Supplier/getSupplierbyCate?idCate=$idC'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      //print(response.body);
      return parsed.map<Supplier>((json) => Supplier.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Supplier');
    }
  }

  //ACCOUNT
  Future<Account> fetchProfile(idAcc) async {
    final response = await http
        .get(Uri.parse('$url/Account/userGetProfile?idAccount=$idAcc'));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Profile');
    }
  }

  Future<http.Response> updateProfileAvatar(String a) async {
    final response =
        await http.post(Uri.parse('$url/Account/updateAccountImage'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({'id': StaticValue.idAccount, 'avatar': a}));
    return response;
  }

  Future<bool> updateProfileName(String name) async {
    bool flagUpdate = true;
    try {
      final response =
          await http.post(Uri.parse('$url/Account/updateAccountName'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({'id': StaticValue.idAccount, 'name': name}));
      //
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }

    return flagUpdate;
  }

  Future<bool> updateProfilePhone(String phone) async {
    bool flagUpdate = true;
    try {
      final response =
          await http.post(Uri.parse('$url/Account/updateAccountPhone'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({'id': StaticValue.idAccount, 'phone': phone}));
      //
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }

    return flagUpdate;
  }

  Future<http.Response> checkCurrentPassword(idAcc, oldPass) async {
    String checkPass = '';
    final response = await http.get(Uri.parse(
        '$url/Account/usersVerifyPass?idUser=$idAcc&currentPass=$oldPass'));
    checkPass = response.body;
    return response;
  }

  Future<http.Response> changeUserPassword(idAcc, oldPass, newPass) async {
    String changePass = '';
    final response = await http.get(Uri.parse(
        '$url/Account/usersChangePass?idUser=$idAcc&oldPassword=$oldPass&newPassword=$newPass'));
    changePass = response.body;
    return response;
  }

  //ADDRESS
  Future<List<Address>> fetchAddress(idAcc) async {
    final response = await http
        .get(Uri.parse('$url/Account/userGetAllAddress?idAccount=$idAcc'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      //print(response.body);
      return parsed.map<Address>((json) => Address.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Address');
    }
  }

  Future<Account> fetchUserAddress(idAcc) async {
    final response = await http
        .get(Uri.parse('$url/Account/userGetAddress?idAccount=$idAcc'));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User Address');
    }
  }

  Future<bool> insertAddress(String address, bool status) async {
    bool flagUpdate = true;
    try {
      final response = await http.post(
          Uri.parse('$url/Account/userInsertAddress'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'idAccount': StaticValue.idAccount,
            'userAddress': address,
            'status': status
          }));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<bool> updateAddress(String address, bool status) async {
    bool flagUpdate = true;
    try {
      final response =
          await http.post(Uri.parse('$url/Account/userUpdateAddress'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                'id': StaticValue.idAddress,
                'idAccount': StaticValue.idAccount,
                'userAddress': address,
                'status': status
              }));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<bool> deleteAddress(idA) async {
    bool flagUpdate = true;
    try {
      final response = await http
          .get(Uri.parse('$url/Account/userDeleteAddress?idAddress=$idA'));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }

    return flagUpdate;
  }

  Future<Address> fetchAddresswhereUser(idAddress) async {
    final response = await http
        .get(Uri.parse('$url/Account/userDeitalsAddress?idAddress=$idAddress'));
    if (response.statusCode == 200) {
      return Address.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Address where User');
    }
  }

  //REVIEW
  Future<List<Review>> fetchReview(idP) async {
    final response = await http
        .get(Uri.parse('$url/Review/getReviewbyIdProduct?idProduct=$idP'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      //print(response.body);
      return parsed.map<Review>((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load review');
    }
  }

  Future<List<Review>> fetchSuppReview(idS) async {
    final response = await http
        .get(Uri.parse('$url/Review/getReviewbyIdSupplier?idSupplier=$idS'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      //print(response.body);
      return parsed.map<Review>((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load supp review');
    }
  }

  //BLOGS
  Future<List<Blogs>> fetchBlogs() async {
    final response = await http.get(Uri.parse('$url/Blog/userBlog'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Blogs>((json) => Blogs.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Blogs');
    }
  }

  Future<Blogs> fetchBlogsDetails(idB) async {
    final response =
        await http.get(Uri.parse('$url/Blog/userBlogDetails?idBlog=$idB'));
    if (response.statusCode == 200) {
      return Blogs.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Blogs Details');
    }
  }

  //COMMENT BLOGS
  Future<List<CommentBlog>> fetchCommentBlog(idBlg) async {
    final response = await http
        .get(Uri.parse('$url/Comment/userGetCommentBlogM?idBlog=$idBlg'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<CommentBlog>((json) => CommentBlog.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Comment Blog');
    }
  }

  Future<List<ReplyCommentBlog>> fetchReplyBlog(idBlg, idCmt) async {
    final response = await http.get(Uri.parse(
        '$url/Comment/userGetSubCommentBlog?idBlog=$idBlg&idMainC=$idCmt'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ReplyCommentBlog>((json) => ReplyCommentBlog.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Reply Comment Blog');
    }
  }

  Future<bool> insertComment(comment) async {
    bool flagUpdate = true;
    try {
      final response =
          await http.post(Uri.parse('$url/Comment/userAddNewComment'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                'idAccount': StaticValue.idAccount,
                'idBlog': StaticValue.idBlog,
                'comment': comment,
                'userType': '2'
              }));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<bool> insertReply(idReply, idMainB, idMainC, comment) async {
    bool flagUpdate = true;
    try {
      final response =
          await http.post(Uri.parse('$url/Comment/userAddNewComment'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                'idAccount': StaticValue.idAccount,
                'idBlog': StaticValue.idBlog,
                'idMainB': idMainB,
                'idReply': idReply,
                'idMainC': idMainC,
                'comment': comment,
                'userType': '2'
              }));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<bool> editCommentandReply(idCmt, comment) async {
    bool flagUpdate = true;
    try {
      final response = await http.get(
        Uri.parse(
            '$url/Comment/userEditCommentBlog?idCM=$idCmt&content=$comment'),
      );
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }

    return flagUpdate;
  }

  Future<bool> deleteCommentandReply(idCmt, idBlg) async {
    bool flagUpdate = true;
    try {
      final response = await http.get(Uri.parse(
          '$url/Comment/userDeleteCommentBlog?idComment=$idCmt&idBlog=$idBlg'));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }

    return flagUpdate;
  }

  //CART
  Future<List<SupplierCart>> fetchSupplierCart(idAcc) async {
    final response =
        await http.get(Uri.parse('$url/Cart/userGetCartSMobile?idUser=$idAcc'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<SupplierCart> ls;
      ls = parsed
          .map<SupplierCart>((json) => SupplierCart.fromJson(json))
          .toList();
      for (var item in ls) {
        for (var proItem in item.lsCartS!) {
          proItem.priceProduct = proItem.price! / proItem.amount;
        }
      }
      return ls;
    } else {
      throw Exception('Failed to load Supplier Cart');
    }
  }

  Future<ObjectMessage> insertCartProduct(idP, amount) async {
    ObjectMessage objectReturn;
    final response = await http.post(Uri.parse('$url/Cart/userInsertCart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'idAccount': StaticValue.idAccount,
          'idProduct': idP,
          'addAmount': amount
        }));

    if (response.statusCode == 200) {
      return ObjectMessage.fromJson(jsonDecode(response.body));
      // StaticValue.flagMessage = objectReturn.getFlagMessage;
      // StaticValue.message = objectReturn.getMessage;
      // return objectReturn;
    } else {
      throw Exception('Failed to load Object');
    }
  }

  Future<bool> updateAmount(idAcc, idPro, price, amount) async {
    bool flagUpdate = true;
    try {
      final response = await http.get(
        Uri.parse(
            '$url/Cart/userChangeCart?idAccount=$idAcc&idProduct=$idPro&Price=$price&Amount=$amount'),
      );
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<bool> deleteItemCart(idCart) async {
    bool flagUpdate = true;
    try {
      final response = await http.get(
        Uri.parse('$url/Cart/userRemoveCart?idCart=$idCart'),
      );
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<bool> deletemultiItemCart(lsIdCart) async {
    bool flagUpdate = true;
    try {
      final response = await http.get(
        Uri.parse('$url/Cart/userRemoveMultiCart?lsIdCart=$lsIdCart'),
      );
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  //CHECKOUT
  Future<List<SupplierCart>> fetchCheckout(idAcc, lsIdCart) async {
    final response = await http.get(Uri.parse(
        '$url/Cart/getListCartsCheckOutForM?idUser=$idAcc&lsCartCk=$lsIdCart'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<SupplierCart> ls;
      ls = parsed
          .map<SupplierCart>((json) => SupplierCart.fromJson(json))
          .toList();
      for (var item in ls) {
        for (var proItem in item.lsCartS!) {
          proItem.priceProduct = proItem.price! / proItem.amount;
        }
      }
      return ls;
    } else {
      throw Exception('Failed to load Supplier Cart');
    }
  }

  Future<bool> insertInvoice(HandleInvoiceObject invoice) async {
    bool flagUpdate = true;
    try {
      final response =
          await http.post(Uri.parse('$url/Invoice/userPaymentCartM'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                'idUser': invoice.idUser,
                'idAddress': invoice.idAddress,
                'lsCartSelect': invoice.lsCartSelect,
                'voucherAdmin': invoice.voucherAdmin,
                'lsVoucherS': invoice.lsVoucherS,
                'feeService':
                    Decimal.tryParse((invoice.feeService!).toStringAsFixed(2))
              }));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  //VOUCHERS
  Future<List<Vouchers>> fetchVoucherAdmin() async {
    final response = await http
        .get(Uri.parse('$url/Voucher/getVoucherForUser?voucherType=0'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Vouchers>((json) => Vouchers.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Vouchers');
    }
  }

  Future<List<Vouchers>> fetchVoucherSupplier(idS) async {
    final response = await http
        .get(Uri.parse('$url/Voucher/getLsVoucherSupplier?idSupplier=$idS'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Vouchers>((json) => Vouchers.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Vouchers Supplier');
    }
  }

  //INVOICE
  Future<List<InvoicesView>> fetchUserInvoice(idAcc, status) async {
    final response = await http.get(Uri.parse(
        '$url/Invoice/userGetInvoiceM?idAccount=$idAcc&isStatus=$status'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<InvoicesView>((json) => InvoicesView.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load User Invoice');
    }
  }

  Future<List<InvoiceDetails>> fetchUserInvoiceDetails(idInvc, idAcc) async {
    final response = await http.get(Uri.parse(
        '$url/InvoiceDetails/usersGetInvoiceDetailsM?idInvoice=$idInvc&idUsers=$idAcc'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<InvoiceDetails>((json) => InvoiceDetails.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load User Invoice Details');
    }
  }

  Future<bool> userConfirmInvoiceDetails(HandleStatusObject status) async {
    bool flagUpdate = true;
    try {
      final response =
          await http.post(Uri.parse('$url/Invoice/statusOfInvoice'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                'userCase': status.userCase,
                'statusType': status.statusType,
                'idInvoice': status.idInvoice,
                'idSupplier': status.idSupplier,
                'idInvoiceDetails': status.idInvoiceDetails,
                'idUser': status.idUser
              }));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<bool> userRatingProducts(idPro, idInv, review) async {
    bool flagUpdate = true;
    try {
      final response =
          await http.post(Uri.parse('$url/Review/userRatingProduct'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                'idAccount': StaticValue.idAccount,
                'idProduct': idPro,
                'idInvoice': idInv,
                'review': review,
              }));

      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  //WATCH LIST
  Future<List<Watchlist>> fetchWatchlist(idAcc) async {
    final response = await http.get(Uri.parse(
        '$url/WatchList/usersWatchList?idUser=$idAcc&lsWatchW=&searchProductN=&sortDFlag=0&sortPFlag=0'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Watchlist>((json) => Watchlist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Watchlist');
    }
  }

  Future<bool> insertMultiWatchList(lsIdCart, idAcc) async {
    bool flagUpdate = true;
    try {
      final response = await http.get(Uri.parse(
          '$url/WatchList/userMoveCartsIntoWatchList?lsIdcart=$lsIdCart&idUsers=$idAcc'));
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<ObjectMessage> insertWatchList(idPro, idAcc) async {
    ObjectMessage objectReturn;
    final response = await http.get(Uri.parse(
        '$url/WatchList/usersAddWatchList?idProduct=$idPro&idUser=$idAcc'));

    if (response.statusCode == 200) {
      return ObjectMessage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to insert Watchlist');
    }
  }

  Future<http.Response> deleteWatchList(idPro, idAcc) async {
    String valueDelete = '';
    final response = await http.get(Uri.parse(
        '$url/WatchList/usersDeleteWatchList?idProduct=$idPro&idUser=$idAcc'));
    valueDelete = response.body;
    return response;
  }

  /*AUTO CHECK*/
  //INVOICE DETAILS
  Future<bool> autoCheckConfirmUser(idInv) async {
    bool flagUpdate = true;
    try {
      final response = await http
          .get(Uri.parse('$url/Batch/autoCheckConfirmU?idInvoice=$idInv'));
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  //VOUCHER ADMIN/SUPPLIER
  Future<bool> autoCheckStartVoucher(userType) async {
    bool flagUpdate = true;
    try {
      final response = await http
          .get(Uri.parse('$url/Batch/autoStartVoucher?userType=$userType'));
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  Future<bool> autoCheckEndVoucher(userType) async {
    bool flagUpdate = true;
    try {
      final response = await http
          .get(Uri.parse('$url/Batch/autoEndVoucher?userType=$userType'));
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  //PRODUCT DETAILS
  Future<bool> autoStartEndDiscountUsers() async {
    bool flagUpdate = true;
    try {
      final response =
          await http.get(Uri.parse('$url/Batch/autoStartEndDiscountUsers'));
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }

  //CART
  Future<bool> autoUpdateItemInCart(idAcc) async {
    bool flagUpdate = true;
    try {
      final response = await http
          .get(Uri.parse('$url/Batch/autoUpdateItemInCart?idUsers=$idAcc'));
      if (response.statusCode == 200) {
        flagUpdate = true;
      }
    } catch (e) {
      flagUpdate = false;
    }
    return flagUpdate;
  }
}
