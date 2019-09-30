class CheckoutServices {
  static getAllPrice(checkoutData){
    double tempAllPrice = 0;
    for (var i = 0; i < checkoutData.length; ++i) {
        tempAllPrice += checkoutData[i]['price'] * checkoutData[i]['count'];
    }
    return tempAllPrice;
  }
}