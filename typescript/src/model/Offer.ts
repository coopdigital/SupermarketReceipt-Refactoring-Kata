import {Product} from "./Product"
import {OfferType as OfferType} from "./OfferType"

export class Offer {

    public constructor(public readonly offerType: OfferType,
                       public readonly product: Product,
                       public readonly argument: number) {
    }

    getProduct(): Product {
        return this.product;
    }

}
