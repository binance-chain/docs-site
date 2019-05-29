# What exactly is Binance DEX matching logic?

Binance DEX uses periodic auction to match all available orders. Because the match happens at the
same time for all orders with the same price in every auction, so there is no concept of `Maker` or `Taker`.

## Match Candidates

Orders meet any of the below conditions would be considered as the candidates of next match round:
- New orders that come in just now and get confirmed by being accepted into the latest block
- Existing orders that come in the past blocks before the latest, and have not been filled or expired

## Match Time

Candidates would be matched right after one block is committed (except midnight block).

## Match Logic

The below matching logic would be applied on every listed token pairs.

- The match only happens when the best bid and ask prices are 'crossed', i.e. best bid > best ask.

- There would be only 1 price selected in one match round as the best prices among all the fillable
orders, to show the fairness.

- All the orders would be matched first by the price aggressiveness and then block height that they get accepted.

## Conclude Execution Price

The execution price would be selected as the below logic, in order to:

- Maximize the execution quantity
- Execute all orders or at least all orders on one side that are fillable against the selected price.
- Indicate the market pressure from either buy or sell and also consider to limit the max price movement

Please check [this article](match-examples.md) with detailed examples for this if you are interested.

**WARNING: For aggressive orders onto a not-so-liquid market, this match methodology would provide much worse average trade price, because all the trades would be marked with one final prices, instead of prices on all the waiting orders from the market.** If you want the same result as continuous match, the best effort you can do is to sweep the opposite side of the market one level after another.

## Order Matches
After the execution price is concluded. Order match would happen in sequence of the price and time, i.e.

- Orders with best bid price would match with order with best ask price;
- If the orders on one price cannot be fully filled by the opposite orders:
for the orders with the same price, the orders from the earlier blocks would be selected and filled first
- If the orders have the same price and block height, and cannot be fully filled, the execution
would be allocated to each order in proportion to their quantity (floored if the number has a partial lot).
If the allocation cannot be accurately divided, a deterministic algorithm would guarantee that no consistent
bias to any orders: according to a sorted sequence of a de facto random order ID.
