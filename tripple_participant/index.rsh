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
        ...Transaction
    })
    init()

    Bidder.only(()=>{
        const price = declassify(interact.seePrice())
    })
    Bidder.publish(price);
    commit();

    Buyer.only(()=>{
        const description = declassify(interact.getDescription(10))
    })
    Buyer.publish(description);
    commit();
    
    const result = description

    // each([Bidder, Buyer], () => {
    //     interact.seePrice()
    // });

})