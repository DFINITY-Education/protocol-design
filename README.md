# Table of Contents
- [Module 1: Intro to Protocols, the Internet, and the Internet Computer](module-1.md)
- [Module 2: Starting off Simple with DNS](./dns)
- [Module 3: Banking as a Protocol](./bank)
- [Module 4: Building on Top of a Protocol](./bank#module-4-building-on-top-of-a-protocol)

# About
In this course, students will learn about the basics of protocols, understand how they create the Internet as we know it, and develop a high-level conception of the Internet Computer Protocol. Using this knowledge, students will implement their own version of DNS and a basic banking application on the Internet Computer. Module 1 serves as an intro to this unit, providing context for protocol design that will then be leveraged in Modules 2-4 to implement several applications on the Internet Computer.

# TODO
* DNS
  * New features:
    * Cache validation
    * Server ownership
  * Add tests
* Bank
  * Squash "static expression" bug
  * More ergonomic actor-related usage in tests
  * Write `CreditProvider` canister
  * Write `Shop` canister
  * Add more tests
* Other
  * Some back-reference to maintain continuity from the _Module 1_