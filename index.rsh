'reach 0.1';

const Members = {
  getChallenge: Fun([], UInt),
  seeResult: Fun([UInt], Null),
}

export const main = Reach.App(() => {

  const Pat = Participant('Pat', {
    ...Members
  });

  const Vanna = Participant('Vanna', {
    ...Members
  });

  init();

  Pat.only(() => {
    const challengePat = declassify(interact.getChallenge())
  })
  Pat.publish(challengePat);
  commit();

  Vanna.only(() => {
    const challengeVanna = declassify(interact.getChallenge())
  })
  Vanna.publish(challengeVanna);

  const outcome = (challengePat + (4 - challengeVanna)) % 3;
  commit();

  each([Pat, Vanna], () => {
    interact.seeResult(outcome);
  });

});
