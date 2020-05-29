var url = window.location.href;
var shop = window.location.host;
var locations = {};

if (url.includes('/products/') && url.includes('794764016345')) {

    let prodID = meta.product.id;
    let varID = meta.product.variants[0].id;
    var location_inventory = {};

    fetch(`https://${shop}/admin/api/2020-04/locations.json`, {
        method: "GET",
    })
        .then(res => res.json())
        .then(resp => {
            console.log(resp);   
        })

}
