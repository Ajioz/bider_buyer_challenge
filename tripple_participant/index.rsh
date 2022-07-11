'reach 0.1';

const Transaction = {
    seePrice: Fun([], UInt),
    getDescription: Fun([UInt], Bytes(128)),
}

export const main = Reach.App(()=>{

    const Creator = Participant('Creator', {
        ...Transaction
    })

    const Bidder = Participant('Bidder', {
        ...Transaction
    })

    const Buyer = Participant('Buyer', {
        ...Transaction,
        payment: UInt
    })
    init()

    Bidder.only(()=>{
        const price = declassify(interact.seePrice())
    })
    Bidder.publish(price);
    commit();

    Buyer.only(()=>{
        payment = declassify(interact.payment)
        const description = declassify(interact.getDescription(10))
    })
    Buyer.publish(payment, description).pay(payment);
    commit();
})