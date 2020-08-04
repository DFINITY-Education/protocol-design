# Module 1: Intro to Protocols, the Internet, and the Internet Computer

_Note: Images are rough placeholders. Some may stay, but would likely be best to re-create them._

### What is a Protocol?

Imagine that you want to communicate a message to your friend in another room. What steps must you take to successfully relay this message and verify that it was received? Chances are, you first need to get their attention, then speak a language that they understand, and finally wait for a response. Similarly, computers and applications use a related process to send and receive messages through the use of a **protocol**.

A **protocol** is a set of rules that establish how electronic devices communicate with each other. Think of a protocol like a human language; devices must use the same protocol, or speak the same language, to successfully communicate. By employing the same protocol, devices created by separate manufacturers or containing different underlying architectures can effectively send and receive data.

### Packets
As with any form of communication, there is a chance that the data being transmitted gets lost in the process. To increase the reliability and efficiency of data transfer, protocols divide each “message” into smaller pieces of data called **packets**. Each packet has a header, which contains information about the source and destination (akin to a postal address), and body, containing the data itself. If one packet is lost in the process, the device can just resend that one packet instead of resending the entire message. The receiving device reassembles the packets into the original message using the instructions provided by the protocol. 

<img align=“center” src=images/packets.jpg />

_Create a graphic to show (abstractly) how this works with a sender and receiver_
[Sample graphic from https://afteracademy.com/blog/what-is-stop-and-wait-protocol]

## What is the Internet?

### The Internet Protocol Suite
The Internet as we know it, and the applications that sit on top of it, are formed by a variety of protocols that together dictate how information should be sent and received. Each protocol manages a small part of the process, and these protocols are layered to form a complete **protocol stack**.

<p align=“center”>
  <img src=images/internet-layering.png />
</p>

[Image Source](https://en.wikipedia.org/wiki/Communication_protocol)

The Internet protocol suite is composed of four stacked layers that together specify how data should be addressed, packaged, and received. The **application layer** resides at the top of the suite, providing data exchange for applications such as email, web browsing, text messages, etc. The **transport layer** establishes a connection between hosts and splits the data to be sent into packets. It is responsible for ensuring that packets arrive without error and in the correct order. The **Internet layer** directs each packet provided by the transport layer from one address to another. The bottom layer is the **link layer**, which maintains communications that reside on a single network segment (think devices physically connected via ethernet within a home).

Each layer has several possible protocols that can be used. We’ll focus on the two most prominent ones: Transmission Control Protocol (TCP) and the Internet Protocol (IP), often referred to as TCP/IP as shorthand for “TCP over IP” (shown in the Internet Protocol Suite diagram).

### TCP/IP
TCP resides in the transport layer of the Internet protocol suite, where it establishes connections between hosts and packages data into packets. TCP creates packets by dividing the message into smaller pieces of data and adding a TCP header. Each packet is given a number, allowing the receiving device to assemble messages in the correct order. TCP also performs error checking to ensure that each packet is delivered. Once the receiver receives a packet, it must send back an acknowledgment message to the sender. If the sender doesn’t receive an acknowledgment within a reasonable time, the sender assumes the message was lost or corrupted and resends the packet.

In the Internet layer, IP takes the packet, which now contains the TCP header and data payload, and applies its own IP header. This header mainly contains the IP address of the source and destination in addition to specifying which transport protocol (often TCP) was used to send the packet. IP is responsible for delivering the packet based on its stated destination address.

The transport layer is like the post office, responsible for packaging items, addressing them, and ensuring they arrive at their destination. The Internet layer is like the actual mail truck, transporting each package along the specified route. 

_[Maybe create a quick graphic with sender and receiver demonstrating how TCP handles missing packets]_

On the receiving side of the connection, the packet passes through the four layers of the Internet protocol suite in reverse order (from link to application). In each layer, the header is removed and interpreted before being passed to the next layer.

<p align=“center”>
  <img src=images/packet-headers.gif />
</p>

[Image Source](http://web.deu.edu.tr/doc/oreily/networking/firewall/ch06_03.htm)

## Internet Computer Protocol

### The Impetus
The centralized nature of the current internet stack results in several large companies controlling the primary cloud computing and networking servers. Furthermore, application development and deployment within the current legacy IT stack is tedious and expensive.

### What is the Internet Computer Protocol?
The Internet Protocol suite revolutionized communication and application deployment; the **Internet Computer Protocol** (ICP) aims to do the same for the current IT stack.

At its core, ICP is a protocol that allows decentralized datacenters to virtually form a large, infinitely scalable, resilient and fault-tolerant Internet-scale computer. 

The goal is to enable all of the data centers around the world to act as a single computer by using ICP. Fundamentally, a computer must read and write data to access stored memory and record new events. On a single computer, managing this process is relatively easy. However, if you have multiple users spanning the world reading and writing to the same computer, how do you manage such requests?

The basis of ICP is a **Peer-to-Peer** (P2P) and **consensus** algorithm. Each time one computer (datacenter) receives a read/write request, that computer must make the other computers aware that an event is being committed to the IC. P2P ensures that every event gets “gossiped”, or broadcast, to all other computers in the IC network.

Additionally, the order in which events are registered in the network matters immensely. Take, for example, a situation where a user wants to simultaneously purchase a car and a boat using money from her bank account that is stored on the IC. For each transaction, two separate computers on opposite sides of the world might check the balance in her account and conclude that she has enough money to individually purchase them. However, once the transactions are processed, the network might realize that she didn’t actually have enough money to purchase both. To resolve this issue, we need consensus. 

_[Maybe insert graphic of nodes and requests]_

Consensus ensures that the read and write events that are gossiped to all computers will be ordered consistently on each computer. If computers start in the same state and execute the same sequence of read/write events, then we have proof that all computers will eventually hold the same final state. 
