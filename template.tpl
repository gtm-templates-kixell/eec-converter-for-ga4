___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "EEC converter for GA4.",
  "categories": ["ANALYTICS","UTILITY","TAG_MANAGEMENT"],
  "description": "This template helps to set up e-commerce tracking for GA4.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "kType",
    "displayName": "Ecommerce dataLayer source",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "event",
        "displayValue": "GA4 Event name"
      },
      {
        "value": "items",
        "displayValue": "GA4 Items"
      }
    ],
    "simpleValueType": true,
    "alwaysInSummary": true,
    "defaultValue": "event_name",
    "help": "\u003cb\u003eGA4 Event name :\u003c/b\u003e used to create the variable for the configuration of the Event tag at the event name level.\u003cbr /\u003e\n\u003cb\u003eGA4 Items\u003c/b\u003e used to create the variable for the configuration of the Event tag at the level of the event parameters."
  },
  {
    "type": "GROUP",
    "name": "kCurrency",
    "displayName": "Default currency",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "TEXT",
        "name": "kCurrencyValue",
        "displayName": "Default currency value",
        "simpleValueType": true,
        "defaultValue": "EUR",
        "help": "Specify the default currency used. If your dataLayer does not contain this value or is incorrectly set, it can be used and the data will be correctly collected."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "Checkout",
    "displayName": "Checkout",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "LABEL",
        "name": "Description",
        "displayName": "Fill in the steps of your order funnel.\u003cbr /\u003e\u003cb\u003eFor example:\u003c/b\u003e\u003cbr /\u003e Checkout step number \u003d 1 and Event name \u003d view_cart\u003cbr /\u003eCheckout step number \u003d 2 and Event name \u003d begin_checkout\u003cbr /\u003eCheckout step number \u003d 3 and Event name \u003d add_shipping_info\u003cbr /\u003eCheckout step number \u003d 4 and Event name \u003d add_payment_info\u003cbr /\u003e\n\u003ci\u003e(i.e. there is no step for purchase, this collected and converted automatically by this template) \u003c/i\u003e"
      },
      {
        "type": "PARAM_TABLE",
        "name": "kCheckout",
        "displayName": "Settings",
        "paramTableColumns": [
          {
            "param": {
              "type": "SELECT",
              "name": "stepNumber",
              "displayName": "Checkout step number",
              "macrosInSelect": false,
              "selectItems": [
                {
                  "value": 1,
                  "displayValue": "1"
                },
                {
                  "value": 2,
                  "displayValue": "2"
                },
                {
                  "value": 3,
                  "displayValue": "3"
                },
                {
                  "value": 4,
                  "displayValue": "4"
                },
                {
                  "value": 5,
                  "displayValue": "5"
                },
                {
                  "value": 6,
                  "displayValue": "6"
                },
                {
                  "value": 7,
                  "displayValue": "7"
                },
                {
                  "value": 8,
                  "displayValue": "8"
                },
                {
                  "value": 9,
                  "displayValue": "9"
                }
              ],
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "SELECT",
              "name": "eventType",
              "displayName": "Event name",
              "macrosInSelect": false,
              "selectItems": [
                {
                  "value": "add_payment_info",
                  "displayValue": "add_payment_info"
                },
                {
                  "value": "add_shipping_info",
                  "displayValue": "add_shipping_info"
                },
                {
                  "value": "add_to_cart",
                  "displayValue": "add_to_cart"
                },
                {
                  "value": "add_to_wishlist",
                  "displayValue": "add_to_wishlist"
                },
                {
                  "value": "begin_checkout",
                  "displayValue": "begin_checkout"
                },
                {
                  "value": "generate_lead",
                  "displayValue": "generate_lead"
                },
                {
                  "value": "purchase",
                  "displayValue": "purchase"
                },
                {
                  "value": "refund",
                  "displayValue": "refund"
                },
                {
                  "value": "remove_from_cart",
                  "displayValue": "remove_from_cart"
                },
                {
                  "value": "select_item",
                  "displayValue": "select_item"
                },
                {
                  "value": "select_promotion",
                  "displayValue": "select_promotion"
                },
                {
                  "value": "view_cart",
                  "displayValue": "view_cart"
                },
                {
                  "value": "view_item",
                  "displayValue": "view_item"
                },
                {
                  "value": "view_item_list",
                  "displayValue": "view_item_list"
                },
                {
                  "value": "view_promotion",
                  "displayValue": "view_promotion"
                }
              ],
              "simpleValueType": true
            },
            "isUnique": false
          }
        ],
        "newRowButtonText": "Add new setting"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "kType",
        "paramValue": "event",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const dataLayer = require('copyFromDataLayer');
const makeInteger = require('makeInteger');

// Copy ecommerce object from the dataLayer otherwise stop
const dle = dataLayer('ecommerce', 1);
if(dle === undefined){return undefined;}

const kco = data.kCheckout;

// If as already items in dataLayer, meaning already GA4 implemented on the page
let kt = data.kType;
if(kt === 'items'){
  if(dle.hasOwnProperty('items')){return dle.items;}
  else if(dle.hasOwnProperty('purchase') && dle.purchase.hasOwnProperty('items')){return dle.purchase.items;} 
}
else if(kt === 'event'){
  if(dle.hasOwnProperty('items') || (dle.hasOwnProperty('purchase') && dle.purchase.hasOwnProperty('items'))){
    return dataLayer('event', 2);
  }
}

// Event name mapping
const ena = {};
ena.impressions = 'view_item_list';
ena.click = 'select_item';
ena.detail = 'view_item';
ena.add = 'add_to_cart';
ena.remove = 'remove_from_cart';
ena.purchase = 'purchase';
ena.refund = 'refund';
ena.promoView = 'view_promotion';
ena.promoClick = 'select_promotion';

// Get dimensions and metrics
const getDM = function(r,n){
    for(var i in r) {if(r.hasOwnProperty(i)&&i.match("^dimension[0-9]+"))(n[i]=r[i]);}
    for(var t in r){if(r.hasOwnProperty(t)&&t.match("^metric[0-9]+")) (n[t]=r[t]);}
    return n;};

// Variables :
let cv, // Currency Value
    en, // Event Name
    kc = data.kCurrency;

// Set currency value
cv = (dle.hasOwnProperty('currencyCode') ? dle.currencyCode : kc);

const fi = function(i){ // Fill item
    let p = {
        'item_id':i.hasOwnProperty('id') ? i.id : undefined,
        'item_name': i.hasOwnProperty('name') ? i.name : undefined,
        'item_variant': i.hasOwnProperty('variant') ? i.variant : undefined,
        'item_brand': i.hasOwnProperty('brand') ? i.brand : undefined,
        'quantity': i.hasOwnProperty('quantity') ? i.quantity : '1',
        'price': i.price,
        'item_category': (i.category && i.category.split('/')[0]) ? i.category.split('/')[0] : undefined,
        'item_category2': (i.category && i.category.split('/')[1]) ? i.category.split('/')[1] : undefined,
        'item_category3': (i.category && i.category.split('/')[2]) ? i.category.split('/')[2] : undefined,
        'item_category4': (i.category && i.category.split('/')[3]) ? i.category.split('/')[3] : undefined,
        'item_category5': (i.category && i.category.split('/')[4]) ? i.category.split('/')[4] : undefined,
        'item_list_name': i.hasOwnProperty('list') ? i.list : undefined,
        'index': i.hasOwnProperty('position') ? makeInteger(i.position) : undefined,
        'coupon': i.hasOwnProperty('coupon') ? i.coupon : undefined,
    };
  return p;
};

const items = [];
// Impressions
if (dle.impressions) {
  en = ena.impressions;
  if (kt === 'items') {
    for (let i=0, l=dle.impressions.length; i<l; i++) {
      let item = dle.impressions[i];
      let p = fi(item);
      p = getDM(item, p);
      items.push(p);
    }
  }  
}

// Click
if (dle.click) {
  en = ena.click;
  if (kt === 'items') {  
    for (let i=0, l=dle.click.products.length; i<l; i++) {
      let item = dle.click.products[i];
      let p = fi(item);
      if (dle.click.hasOwnProperty('actionField') && dle.click.actionField.hasOwnProperty('list')) {
        p.item_list_id = dle.click.actionField.list;
      }
      p = getDM(item, p);
      items.push(p);
    }
  }
}

// Detail
if (dle.detail) {
  en = ena.detail;
  if (kt === 'items') {
    for (let i=0, l=dle.detail.products.length; i<l; i++) {
      let item = dle.detail.products[i];
      let p = fi(item);
      p = getDM(item, p);
      items.push(p);
    }
  }
}

// Add
if (dle.add) {
  en = ena.add;
  if (kt === 'items') {
    for (let i=0, l=dle.add.products.length; i<l; i++) {
      let item = dle.add.products[i];
      let p = fi(item);
      p = getDM(item, p);
      items.push(p);
    }
  }  
}

// Remove
if (dle.remove) {
  en = ena.remove;
  if (kt === 'items') {
    for (let i=0, l=dle.remove.products.length; i<l; i++) {
      let item = dle.remove.products[i];
      let p = fi(item);
      p = getDM(item, p);
      items.push(p);
    }
  }
}

// Refund
if (dle.refund) { 
  en = ena.refund;
  if (kt === 'items') {
    for (let i=0, l=dle.refund.products.length; i<l; i++) {
      let item = dle.refund.products[i];
      let p = {
        'item_id': item.hasOwnProperty('id') ? item.id : undefined,
        'quantity': item.hasOwnProperty('quantity') ? item.quantity : 1,
        'currency': cv
      };
      p = getDM(item, p);
      items.push(p);
    }
  }
}

// Promos
if (dle.promoView) { 
  en = ena.promoView;
  if (kt === 'items') {
    for (let i=0, l=dle.promoView.promotions.length; i<l; i++) {
      let item = dle.promoView.promotions[i];
      let p = {
        'promotion_name': item.hasOwnProperty('name') ? item.name : undefined,
        'promotion_id': item.id,
        'creative_name': item.hasOwnProperty('creative') ? item.creative : undefined,
        'creative_slot': item.hasOwnProperty('position') ? item.position : undefined,
      };      
      p = getDM(item, p);
      items.push(p);
    }
  }
}

// Promos
if (dle.promoClick) { 
  en = ena.promoClick;
  if (kt === 'items') {
    for (let i=0, l=dle.promoClick.promotions.length; i<l; i++) {
      let item = dle.promoClick.promotions[i];
      let p = {
        'promotion_name': item.hasOwnProperty('name') ? item.name : undefined,
        'promotion_id': item.id,
        'creative_name': item.hasOwnProperty('creative') ? item.creative : undefined,
        'creative_slot': item.hasOwnProperty('position') ? item.position : undefined,
      };
      p = getDM(item, p);
      items.push(p);
    }
  }
}

// Checkout
if (dle.checkout) { 
  if(kco && kt == 'event'){
    let step = makeInteger(dle.checkout.actionField.step);
    kco.forEach((kcoi) => {
      if (makeInteger(kcoi.stepNumber) === step) {
        en = kcoi.eventType;
      }
    });
  }
  if (kt === 'items') {
    for (let i=0, l=dle.checkout.products.length; i<l; i++) {
      let item = dle.checkout.products[i];
      let p = fi(item);
      p = getDM(item, p);
      items.push(p);
    }
  }
}

// Purchase
if (dle.purchase) { 
  en = ena.purchase;
  if (kt === 'items') {
    for (let i=0, l=dle.purchase.products.length; i<l; i++) {
      let item = dle.purchase.products[i];
      let p = fi(item);
      p = getDM(item, p);
      items.push(p);
    }
  }
}

if(kt == 'items'){
  return items;
}
else if(kt == 'event'){
  if(en === undefined || en === ''){
    return undefined;
  }
  return en;
}
else{
  return undefined;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ecommerce.*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 23/04/2021, 18:09:42


