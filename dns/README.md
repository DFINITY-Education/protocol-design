# Module 2: Starting off Simple with DNS

Computers use an **Internet Protocol** (IP) address to locate and distinguish websites, but it isn’t exactly convenient for humans to memorize a long string of digits to access their desired websites. Instead, we simply type in the website’s address to our browser and let the computer take care of the rest. **Domain Name System** (DNS) is a protocol that translates domain names - like [www.example.com](w) - into their corresponding IP addresses. In essence, think of DNS as a phonebook for the Internet; in this analogy, contact names are to web domains as phone numbers are to IP addresses.

### DNS Resolution
When a DNS query is conducted, a DNS Resolver splits the domain name from right to left at the “.” delimiter. For example, the domain “ [www.subdomain.example.com](http://www.example.com/) ” is split into three parts: “.com”, “.example”, and “.subdomain”. Each of these domain labels are used as stepping stones to help determine the ultimate IP address of the original query.

### DNS Caching
The resolver begins by checking for the queried domain name in its local cache. This cache stores recently accessed domains and their corresponding IP addresses, drastically increasing lookup speed for frequently searched websites. If the domain is not found in the cache, then the following steps are carried out in the DNS lookup process.

### DNS Lookup Process
1. The initial **DNS query** is made after a user enters a domain name into the browser. This domain is sent to the **DNS Resolver**, which splits the domain into its component labels and finds the corresponding IP address.
2. The Resolver reaches out to the **DNS Root Name Server**, which returns a relevant **Top Level Domain (TLD) Name Server**. The TLD Name Server corresponds to the top level domain in the query, like “.com”.
3. The TLD Name Server refers the Resolver to an **Authoritative Name Server**, which holds details for the main domain name, like “.example”.
4. The Authoritative Name Server returns the IP address for the full domain (in this case www.example.com) to the DNS Resolver, which allows the user to connect to that server using the IP address.

## YOUR TASK
You will be implementing a simplified version of the DNS protocol described above. Read and digest the code in _src/resolver_ before starting! Complete the protocol by filling out the `resolveSearch(...)` method. You'll need to use your understanding of the DNS protocol to decide what calls the resolver should make to which server.

The following test should run to completion:
```bash
> dfx build
Building canisters...
> dfx canister install --all
Installing code for canister Bank, with canister_id ic:ABCDEFGHIJKLMNOPQR
Installing code for canister BankTest, with canister_id: ...
...
> dfx canister call Test run
()
```

Feel free to experiment with the canister through the CLI! Here are some ideas to get you started:
```bash
dfx canister call dns resolveSearch '("www.dfinity.org")'
```
```bash
dfx canister call dns isCached '("www.dfinity.org")'
```