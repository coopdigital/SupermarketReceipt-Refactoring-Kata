import {Product} from "./Product"

type DiscountDescription = string;

export class Discount {

    constructor(public readonly product: Product,
                public readonly description: DiscountDescription,
                public readonly discountAmount: number) {
    }
}
