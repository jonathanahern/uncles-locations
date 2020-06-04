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
            let storeName = subArr[0].split("&")[0];
            let storeLink = subArr[0].split("&")[1];
            let aEle = document.createElement("a");
            aEle.href = storeLink;
            aEle.innerHTML = storeName;
            let newStr = ", QTY: " + subArr[1];
            let textnode = document.createTextNode(newStr);
            let qtyEle = document.createElement("li");
            qtyEle.appendChild(aEle);
            qtyEle.appendChild(textnode);
            containUL.appendChild(qtyEle);
        });
    }
}
