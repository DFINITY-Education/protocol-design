export default ({ IDL }) => {
 return IDL.Service({'burnSupply': IDL.Func([IDL.Nat], [], []),
  'checkBalance': IDL.Func([IDL.Principal], [IDL.Nat], ['query']),
  'deposit': IDL.Func([IDL.Nat], [], []),
  'getTotalSupply': IDL.Func([], [IDL.Nat], ['query']),
  'grantAllowance': IDL.Func([IDL.Principal, IDL.Nat], [IDL.Bool], []),
  'mintSupply': IDL.Func([IDL.Nat], [], []),
  'spendAllowance':
   IDL.Func([IDL.Principal, IDL.Principal, IDL.Nat], [IDL.Bool], []),
  'transferAmount': IDL.Func([IDL.Principal, IDL.Nat], [IDL.Bool], []),
  'withdraw': IDL.Func([IDL.Nat], [IDL.Nat], [])});
};
