# Module 2: Starting off Simple with DNS
Implement a simplified DNS protocol in Motoko, as seen in the example below:
```bash
> dfx canister call Resolver resolve '("www.dfinity.org")'
("104.17.224.20")
```

## Background
Computers use an **Internet Protocol** (IP) address to locate and distinguish websites, but it isn’t exactly convenient for humans to memorize a long string of digits to access their desired websites. Instead, we simply type in the website’s address to our browser and let the computer take care of the rest. **Domain Name System** (DNS) is a protocol that translates domain names - like [www.example.com](w) - into their corresponding IP addresses. In essence, think of DNS as a phonebook for the Internet; in this analogy, contact names are to web domains as phone numbers are to IP addresses.

### DNS Resolution
When a DNS query is conducted, a DNS Resolver splits the domain name from right to left at the "." delimiter. For example, the domain "[www.subdomain.example.com](http://www.example.com/)" is split into three parts: ".com", ".example", and ".subdomain". Each of these domain labels are used as stepping stones to help determine the ultimate IP address of the original query.

### DNS Caching
The resolver begins by checking for the queried domain name in its local cache. This cache stores recently accessed domains and their corresponding IP addresses, drastically increasing lookup speed for frequently searched websites. If the domain is not found in the cache, then the following steps are carried out in the DNS lookup process.

### DNS Lookup Process
1. The initial **DNS query** is made after a user enters a domain name into the browser. This domain is sent to the **DNS Resolver**, which splits the domain into its component labels and finds the corresponding IP address.
2. The Resolver reaches out to the **DNS Root Name Server**, which returns a relevant **Top Level Domain (TLD) Name Server**. The TLD Name Server corresponds to the top level domain in the query, like ".com".
3. The TLD Name Server refers the Resolver to an **Authoritative Name Server**, which holds details for the main domain name, like ".example".
4. The Authoritative Name Server returns the IP address for the full domain (in this case www.example.com) to the DNS Resolver, which allows the user to connect to that server using the IP address.

<p align="center">
  <img src="https://miro.medium.com/max/1400/1*20lOJctutX1PTdWzYUbbZQ.png" height="300"/>
</p>

<p align="center"> <i> Source: <a href="https://medium.com/@openmohan/dns-basics-and-building-simple-dns-server-in-go-6cb8e1cfe461"> Mohan Prasath, Medium</a></i></p>

## Your Task
In this exercise, you will implement a simplified version of the DNS protocol described above using the Internet Computer. Given a URL, the canister will follow the basic steps outlined in the **DNS Lookup Process** to determine the corresponding IP address. We will use distinct canisters to represent the Root, TLD, and Authoritative servers, each of which must be queried successively to find the next corresponding server.  You’ll need to use your understanding of the DNS protocol to decide what calls the resolver should make to which server.

### Code Understanding
After navigating to the [dns/](./dns) directory, let’s take a look at the code in _src/resolver/Main.mo_. The `cache` is our HashMap used to store recently looked-up `domain`s and their corresponding `Principle`. In the Internet Computer, a Principle is a unique identifier - like an IP address - for a canister. As such, our program will return a Principle for a given domain instead of an IP address.

The `ask` function queries the specified `server` for a `domain`. For example, if you query the `Root` server for the `com` subdomain, the `Root` server will return the Principle of the TLD server corresponding with `com`.  If, however, you call the authoritative name server with the main domain `dfinity` (in our example of dfinity.com),  `ask` will return the final Principle that you’re looking for.  In this way, `ask` can be used to query all of the servers described in the **DNS Lookup Process** section for their respective subdomains.

The `parseDomain` function splits a given `domain` into its component parts on the "." delimiter.  _For simplicity, assume that all domains will not include the typical "www" prefix._ The `resolve` function is left for you to implement.

### Specification
**Task**: Complete the implementation of the `resolve` method, which acts the part of a resolver by taking in a `domain` and returning the corresponding `Principle`. 

**Things to consider:**
* You must first check if the given `domain` is contained in the `cache`. If so, you can just return the stored `Principle`; otherwise, you must parse the `domain` into its component domain labels (separated by "."s) and use these to determine the correct IP address. You will find `parseDomain`  helpful in this task.
* You should verify that your parsed domain actually contains values. If it is `null`, you should return the `#addressNotFound` error.
* After parsing the `url`, you must use the resulting domain labels to call the corresponding servers in the correct order. 
* Note that a `domain` doesn’t contain a set number of domain labels. While most URLs, such as example.com, have two domain labels, some may contain subdomains like subdomain.example.com. _Additionally, assume that all domains will not include the typical "www" prefix._

### Testing
The following test should run to completion:
```bash
> dfx deploy
Deploying all canisters.
All canisters have already been created.
Building canisters...
Installing canisters...
Upgrading code for canister Resolver, with canister_id ABCDEFGHIJKLMNOPQR
Upgrading code for canister Root, with canister_id ABCDEFGHIJKLMNOPQR
Upgrading code for canister Test, with canister_id ABCDEFGHIJKLMNOPQR
Deployed canisters.
```
Please read Instructor notes in nameServer.mo for the following methods to produce the following results:
```bash
> dfx canister call Resolver resolve '("dfinity.org")'
("104.17.224.20")
```
```bash
> dfx canister call Resolver isCached '("dfinity.org")'
(true)
```
