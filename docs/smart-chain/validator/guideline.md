# How to join Binance Smart Chain as Validator?

## What is Binance Smart Chain?

Binance Smart Chain is an innovative solution to bring programmability and interoperability to Binance Chain. Binance Smart Chain relies on a system of 21 validators with Proof of Staked Authority (PoSA) consensus that can support short block time and lower fees. The most bonded validator candidates of staking will become validators and produce blocks. The double-sign detection and other slashing logic guarantee security, stability, and chain finality.

## What is Validator?

It powers the blockchain network by processing transactions and signing blocks.

## What are the Benefits of being a validator?

Validators and delegators will earn rewards from transaction fees: dApp usages

## What are the requirements of validators?

* High uptime

* Secure your own keys

**Hardware Requirements**

* running BSC software in VPS Servers (both with firewall):

	* **DigitalOcean**: [CPU optimized droplet](https://www.digitalocean.com/docs/droplets/resources/choose-plan/)

	* **Amazon EC2**: [C5 instance](https://aws.amazon.com/ec2/instance-types/c5/)

	* **Google Cloud Engine**: [General-purpose (N1)](https://cloud.google.com/compute/docs/machine-types)

*  Memory: 16 GB of RAM

*  Disk space: 500 GB of SSD storage (no normal hard disk or network hard disk)

*  CPU: 64-bit

*  Network: 1GB fiber

*  HSM(recomended)

*If you are running a node in Testnet, 4CPU/8GB of RAM is sufficient*

## What is a VPS?

VPS stands for Virtual Private Server. A VPS runs its own copy of an operating system (OS), and customers may have [superuser](https://en.wikipedia.org/wiki/Superuser)-level access to that operating system instance, so they can install almost any software that runs on that OS.

## Why is a VPS highly recommended for validators?

A VPS is recommended (and often required) for validator node setups, as you will need a dedicated static IP and 99.9% uptime to provide a stable and efficient node for the network. Unlike your home or office PC, a validator VPS serves one purpose, to securely and efficiently run a validator node. A VPS is online 24/7 and provides dedicated resources for the project’s decentralized network.

## How to Be a Validator Candidate

Workflow:

1. Configure your VPSnetwork ports, ssl, firewall
2. Install BSC [fullnode](../developer/fullnode.md)
3. create your wallets
4. Download history snapshot(optional)
5. Start your fullnode
6. Check sync status
7. Stake on BC

To learn ahout details [here](candidate.md)

## Best Practice

### Store your BNB with a hardware wallet

The most valuable assets of a validator are two keys: one for signing transactions and another for signing blocks.

* Account Private keys：

To protect your BNB, do not share your 24 words with anyone. The only person who should ever need to know them is you. In short, HSMs are affordable, performant and portable pieces of hardware that help to securely generate, store and manage your private keys. Malware attacks and remote extraction of private keys are much more difficult when an HSM is configured properly.

### Software Vulnerabilities
To protect your BNB, you should only download software directly from official sources, and make sure that you're always using the latest, most secure version

### Sentry Nodes (DDOS Protection)

Validators are responsible for ensuring that the network can sustain denial of service attacks.One recommended way to mitigate these risks is for validators to carefully structure their network topology in a so-called sentry node architecture.
Sentry nodes can be quickly spun up or change their IP addresses. Because the links to the sentry nodes are in private IP space, an internet based attacked cannot disturb them directly. This will ensure validator block proposals and votes always make it to the rest of the network.

To setup your sentry node architecture you can follow the instructions below:

1. Build a private network and setup trusted private connections between validator node and it sentry

2. Set sentry as Trusted node for validator node

3. Set validator as static node for sentry


   <img src="https://lh3.googleusercontent.com/w6notWcdyEXayM592WuI5xcpysFqgkwwBSX3sBZFIc34SHrKewZYlNMBMyGBPs375ez78i4gZmbnMyMn3Ry5s6Z6qTejatPYdDXL67moRhGmAQsjNNVF0CRZz10yznx13U34fKSc" alt="img" style="zoom:33%;" />