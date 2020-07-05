import actorInterface from "ic:idl/Bank";

export default icHttpAgent.makeActorFactory(actorInterface)({
  canisterId: "ic:4BB72698E103F19EF6",
});
