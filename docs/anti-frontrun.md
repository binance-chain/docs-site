# Anti Front-Running

Front-running means someone can get foreknowledge of transactions from other beneficial owners via technology or market advantage, so that they influence the price beforehand and result in economic gain, which usually brings loss or cost to others. It is a daunting question asked to both centralized exchanges and also other decentralized exchanges (DEX). Especially for some DEX, front-running actually often happens, e.g. via gas or timestamp manipulations, or slow match.

There are several design points in Binance DEX that makes front-running really hard.

## Fast Matching
Binance DEX matches orders in every block, while it blocks very fast. Fast matching leaves small room for front-runner to react before the orders get executed properly as it should it. This is one fundamental part making front-running difficult, especially for normal market participants.

## Decentralized, Transparent Match Engine
It is for sure hard to argue the exchange itself is not front-running if it has a centralized match engine. Binance DEX have decentralized match engines running on every block producers and full nodes. So that everyone can replay the match manually with the transactions in the latest block and the current order book, and can see the order matching in real-time if they run a full node.

(This is also actually make wash trading very observable!)

## Periodic Auction Matching
Periodic auction matching per block cuts the importance of speedy orders, i.e. not any more attractive for high frequency trading behaviors and so even several hundreds of milliseconds (which is "really long time" for traditional exchanges) doesn't bring any advantage.

Periodic auction also adds a layer of non-deterministic that no one can exactly know the next execution price unless he/she can exactly know all the below 3 things:

1. the matching logic
2. the current order book and trade price from the last match
3. all incoming orders for the next block

1) and 2) may be visible to participants, especially for validators and ones who closely watch the blockchain status, such as fast sync trading bots or full nodes. But 3) is very hard for normal market participant. Even they run powerful `accelerated node`, they still cannot know all the incoming orders for the next block. Without this knowledge, even someone can send order faster, they cannot do effective front-running.

So with the above, the usual traders and even trading bots cannot do much to front-run others.

You might point out, the validators, they have chance to get information of 3) when they are "proposers" for the next block, i.e. they would "propose" what transactions to add for the next block. But actually the Binance Chain consensus model adds some randomness to make it difficult:

Due to the fast matching, the bad validator have to prepare well with earlier information in order to front-run the price. However, he cannot be too fast, because he cannot be sure the execution price of the last block until the last block is concluded, and the last execution price has direct impact to the execution price according to the match logic. What is more, any validator ahead of the bad validator's proposer turn can have issues and increase the consensus round, which would ask for re-arrangement on the proposing sequence. This makes it very hard to pre-determine the exact proposal sequence, so the bad validator cannot be 100% sure when they can delay any others' transactions and make their own transactions to be blocked earlier. Besides all these, the bad validator cannot hold others transactions for too long: it either makes the bad behavior too observable on chain, or other validators would include the transactions anyway via P2P communication.

As a result, it is extremely hard even for validators to front-run anyone.



## Potential Improvement
With the above description, you may see that the front-running chance on Binance DEX is much less than centralized exchanges and most of decentralized ones. However, you may still argue that for a very powerful, sophisticated validator, there is still slim chance to front-run client orders (if they can do every hard things in a blink time).

In the future, deterministic randomness may be applied in selecting the next proposer among validators, and the match of orders proposed to block can be postponed into the next 2 block. These two enhancements can greatly destroy the prediction accuracy of trading price, which would push the chance of front-running to 0. The cost of this is some latency in matching.


