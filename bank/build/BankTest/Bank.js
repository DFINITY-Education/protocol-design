import actorInterface from "ic:idl/BankTest";

export default icHttpAgent.makeActorFactory(actorInterface)({
  canisterId: "ic:3FDCA11B46B579811C",
});
