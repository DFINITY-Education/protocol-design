import actorInterface from "ic:idl/PaymentProcessorTest";

export default icHttpAgent.makeActorFactory(actorInterface)({
  canisterId: "ic:6A268F0242D72EEAB7",
});
