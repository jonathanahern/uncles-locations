var url = window.location.href;
var shop = window.location.host;
var locations = {};

if (url.includes('/products/') && url.includes('794764016345')) {

    let prodID = meta.product.id;
    let varID = meta.product.variants[0].id;
    var location_inventory = {};

    // fetch(`https://a998d12821c6.ngrok.io/api/v1/front_end/index`, {
    //     method: "GET"
    // })
    //     .then(res => res.json())
    //     .then(resp => {
    //         console.log(resp)
    //     })

    fetch(`https://${shop}/apps/uncles-locations/app_proxy?prodID=${prodID}&varID=${varID}&shop=${shop}`, {
        method: "GET"
    })
        .then(res => res.json())
        .then(resp => {
            console.log(resp)
        })

    // fetch(`https://${shop}/admin/api/2020-04/locations.json`, {
    //     method: "GET",
    // })
    //     .then(res => res.json())
    //     .then(resp => {
    //         console.log(resp);   
    //     })

}
