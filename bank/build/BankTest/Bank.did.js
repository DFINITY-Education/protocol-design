export default ({ IDL }) => {
 return IDL.Service({'run': IDL.Func([], [], ['oneway']),
  'runAccountExistsAndGetBalanceTest': IDL.Func([], [], []),
  'setup': IDL.Func([], [], ['oneway'])});
};
