class Cart {
  final int id;
  final String name;
  final String notes;
  final double price;
  final String image_url;
  int quantity;
  final dynamic addExtras;
  double totalPrice;
  final dynamic removeIngredient;

  Cart(this.id, this.name, this.notes, this.price, this.quantity,
      this.addExtras, this.totalPrice, this.removeIngredient, this.image_url);

  Map toJson() => {
    'name': name,
    'id': id,
    'notes': notes,
    'price': price,
    'quantity': quantity,
    'addExtras': addExtras,
    'totalPrice': totalPrice,
    'removeIngredient': removeIngredient,
    'image_url': image_url,

  };

// [{"id": 1, "name": "Number 7", "notes": null, "price": "34", "quantity": 1, "addExtras": [], "totalPrice": "34", "removeIngredient": []}, {"id": 2, "name": "number 2", "notes": "", "price": "45", "quantity": 1, "addExtras": [], "totalPrice": "45", "removeIngredient": []}]
}
