var url = window.location.href;
var shop = window.location.host;
var locations = {};

if (url.includes('/products/') && url.includes('794764016345')) {
    console.log("this works at least");

    let prodID = meta.product.id;
    let varID = meta.product.variants[0].id;

    fetch(`https://${shop}/apps/uncles-locations/app_proxy?prodID=${prodID}&varID=${varID}&shop=${shop}`, {
        method: "GET"
    })
        .then(res => res.json())
        .then(resp => {
            if ('Inventory' in resp) {
                fillInInventory(resp["Inventory"]);
            }
        })

    function fillInInventory(arr){
        console.log(arr);
        containUL = document.getElementById("quantities_container");
        containUL.innerHTML = "";
        arr.forEach(subArr => {
            let newStr = subArr[0] + ", QTY: " + subArr[1];
            let qtyEle = document.createElement("li");
            qtyEle.innerHTML = newStr;
            containUL.appendChild(qtyEle);
        });
    }
}
