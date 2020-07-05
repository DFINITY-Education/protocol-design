import actorInterface from "ic:idl/PaymentProcessor";

export default icHttpAgent.makeActorFactory(actorInterface)({
  canisterId: "ic:0E0D46FE1A07F05120",
});
