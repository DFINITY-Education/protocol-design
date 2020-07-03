# DNS Documentation 
## Introduction
_Do we want some sort of continuity from the first module? I.e. directly referencing it?_

When you want to visit a website, you enter its address, or domain, into a web browser. However, computers can’t directly use this domain name to route you to the web server. Instead, they use an Internet Protocol (IP) address to locate and distinguish websites. **Domain Name System** (DNS) is a protocol that translates domain names - like ww.example.com - into their corresponding IP addresses. In essence, think of DNS as a phonebook for the Internet; in this analogy, contact names are to web domains as phone numbers are to IP addresses.

## DNS Resolution
When a DNS query is conducted, a DNS Resolver splits the domain name from right to left at the “.” delimiter. For example, the domain “ [www.subdomain.example.com](http://www.example.com/) ” is split into three parts: “.com”, “.example”, and “.subdomain”. Each of these domain labels are used as stepping stones to help determine the ultimate IP address of the original query.

## DNS Caching 
The resolver begins by checking for the queried domain name in its local cache. This cache stores recently accessed domains and their corresponding IP addresses, drastically increasing lookup speed for frequently searched websites. If the domain is not found in the cache, then the following steps are carried out in the DNS lookup process.

## DNS Lookup Process
1. The initial **DNS query**is made after a user enters a domain name into the browser. This domain is sent to the **DNS Resolver**, which splits the domain into its component labels and finds ultimately finds the corresponding IP address.
2. The Resolver reaches out to the **DNS Root Name Server**, which returns a relevant **Top Level Domain (TLD) Name Server**. The TLD Name Server corresponds to the top level domain in the query, like “.com”.
3. The TLD Name Server refers the Resolver to an **Authoritative Name Server**, which holds details for the main domain name, like “.example”.
4. The Authoritative Name Server returns the IP address for the full domain (in this case www.example.com) to the DNS Resolver, which allows the user to connect to that server using the IP address.