part of 'shared.dart';

class LocalStorage {
  static const String TABLE_CART = "cart";
  static const String id = "id";
  static const String productName = 'productName';
  static const String urlPreview = 'urlPreview';
  static const String price = 'price';
  static const String qty = 'qty';
  static const String idMerchant = 'idMerchant';
  static const String merchantName = 'merchantName';
  static const String merchantLogo = 'merchantLogo';

  LocalStorage._();
  static final LocalStorage db = LocalStorage._();

  Database _database;

  Future<Database> get database async {
    print('database get call');

    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    var dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'cart.db'), version: 1,
        onCreate: (Database database, int version) async {
      print('Creating Cart Table');
      await database.execute(
        "CREATE TABLE $TABLE_CART ("
        "$id INTEGER PRIMARY KEY,"
        "$productName TEXT,"
        "$urlPreview TEXT,"
        "$price TEXT,"
        "$qty TEXT,"
        "$idMerchant TEXT,"
        "$merchantName TEXT,"
        "$merchantLogo TEXT"
        ")",
      );
    });
  }


  Future<List<Cart>> getCart() async {
    final db = await database;
    var cart = await db.query(TABLE_CART, columns: [
      id,
      productName,
      urlPreview,
      price,
      qty,
      idMerchant,
      merchantName,
      merchantLogo,
    ]);

    List<Cart> cartList = List<Cart>();

    cart.forEach((currentCart) {
      Cart cart = Cart.fromMap(currentCart);

      cartList.add(cart);
    });

    return cartList;
  }

  Future<Cart> insert(Cart cart) async {
    final db = await database;

    cart.id = await db.insert(TABLE_CART, cart.toMap());
    print(cart.id);
    return cart;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(TABLE_CART, where: "id = ?", whereArgs: [id]);
  }
}