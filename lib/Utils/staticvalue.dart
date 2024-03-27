class StaticValue {
  //Account
  static int? idAccount;
  static String? userAvatar;
  static String? userFullName;
  static String? userPhone;
  //Address
  static int? idAddress;
  //Blog
  static int? idBlog;
  
  //Cart
  static String? lsIdCart;
  static Map<int, int> mCartItem = {};
  static Map<int, bool> mMainCartCk = {};
  static Map<int, bool> mSubCartCkBox = {};
  static Map<int, double> priceItemCart = {};
  static Map<int, int> amountItemCart = {};
  //ItemCheckBoxAll
  static bool checkedB = false;
  //
  static int amountInCart = 0;
  //Checkout
  /*BasePriceCheckOut*/
  static Map<int, double> cPriceESupplier = {}; //Price Each Supplier
  /*Price For Display*/
  static Map<int, double> vPriceESupplier = {}; //Price Work Each Supplier
  /*List Voucher On CheckOut*/
  static Map<int, String> voucherOnCheckOut = {}; //Vouchers On CheckOut
  static Map<String, bool> voucherOnSelect = {};
  static Map<int, bool> flagDisplayVoucher = {};
  /*Display Check Voucher Admin*/
  static Map<String, bool> vAdminDisplayCheck = {};
  /*Price Sum Total*/
  static double priceCartCheckOut = 0;
  static double priceSumTotal = 0;
  static double priceVoucherAdmin = 0;
  static double priceVoucherSupplier = 0;
  static double feeService = 0;
  /*Total Price CheckOut*/
  static double sumCheckOut = 0;

  /*Flag*/
  static bool flagVoucherAdmin = false;
  static bool flagDisplayVoucherAdmin = false;
  static bool flagSetAddress = false;
  static bool flagAddressCheckout = false;

  //Invoice
  static double userFeeServices = 0;
  static double totalDiscountV = 0;
  static double totalProducts = 0;
  static double totalRefund = 0;
  static double totalInvoiceDetails = 0;
}
