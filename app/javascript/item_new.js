window.addEventListener('load', function(){

  // 要素取得
  const ele_item_price  = document.getElementById("item-price");    // 価格入力
  const ele_commission  = document.getElementById("add-tax-price"); // 販売手数料
  const ele_profit      = document.getElementById("profit");        // 販売利益

  // 販売手数料・販売利益表示
  ele_item_price.addEventListener('input', () => {
    // 変数宣言
    const commission_rate = 0.1;   // 販売手数料率
    // 販売手数料計算
    const commission_fee = Math.floor(ele_item_price.value * commission_rate);
    // 要素挿入
    ele_commission.innerHTML  = commission_fee;                         // 販売手数料挿入
    ele_profit.innerHTML      = ele_item_price.value - commission_fee;  // 販売利益挿入
  })

})