import {FakeCatalog} from "./FakeCatalog"
import {Product} from "../src/model/Product"
import {SupermarketCatalog} from "../src/model/SupermarketCatalog"
import {Receipt} from "../src/model/Receipt"
import {ShoppingCart} from "../src/model/ShoppingCart"
import {Checkout} from "../src/model/Checkout"
import {OfferType} from "../src/model/OfferType"
import {ProductUnit} from "../src/model/ProductUnit"
import {assert} from "chai";

describe('Supermarket', () => {
    describe('Special offers', () => {
        it('should not apply to non-discounted items', () => {
            // ARRANGE
            const catalog: SupermarketCatalog = new FakeCatalog();
            const toothbrush: Product = new Product("toothbrush", ProductUnit.Each);
            catalog.addProduct(toothbrush, 0.99);
            const apples: Product = new Product("apples", ProductUnit.Kilo);
            catalog.addProduct(apples, 1.99);
    
            const checkout: Checkout = new Checkout(catalog);
            checkout.addSpecialOffer(OfferType.TenPercentDiscount, toothbrush, 10.0);
    
            const cart: ShoppingCart = new ShoppingCart();
            cart.addItemQuantity(apples, 2.5);
    
            // ACT
            const receipt: Receipt = checkout.checksOutArticlesFrom(cart);
    
            // ASSERT
            assert.approximately(receipt.getTotalPrice(), 4.975, 0.01);
            assert.isEmpty(receipt.getDiscounts());
            assert.equal(receipt.getItems().length, 1);
            const receiptItem = receipt.getItems()[0];
            assert.equal(receiptItem.product, apples);
            assert.equal(receiptItem.price, 1.99);
            assert.approximately(receiptItem.totalPrice, 2.5*1.99, 0.01);
            assert.equal(receiptItem.quantity, 2.5);
        });
    })
});
