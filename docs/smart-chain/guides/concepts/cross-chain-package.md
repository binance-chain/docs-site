# Cross Chain Package

## Package Structure

| Name           | Length         | Description                                              | 
| -------------- | -------------- | -------------------------------------------------------- |
| Package Type   | 1 byte         | 0: sync package, 1: ack package, 2: fail ack package     |
| Relay Fee      | 32 bytes       | bytes of big.Int, reward for relayer, token denom is BNB |
| Payload        | All rest bytes | RLP encoding of application data                         | 
 
## Handle Mechanism

### Sync Package

When users actively trigger cross chain applications, such as bind token or cross chain transfer, sync packages will be generated and the transaction senders will pay the relay fee. For some system applications, such as on-chain governance and staking, the relay fee in the sync packages will be paid by system reward. 

After the application layer processing the sync package, in most case, there is no ack package. However, in order to elegantly handle some application layer errors, some ack packages or fail ack packages will be generated, and relayed back to the opposite chain, the relay fee will be paid by system reward too. Taking cross chain transfer for example, if a cross chain transfer is failed for some known reasons, the asset should be refund to the sender, then an ack package will be generated. If the cross chain transfer is failed for some unknown reasons, such as wrong encoding format or application panic error, then a fail ack package will be generated. In the fail ack package, the payload is identical to the payload in sync package.
