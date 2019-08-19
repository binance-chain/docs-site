# User Guide of Threshold Signature Scheme (TSS) in Binance Chain

## Introduction

Binance TSS is based on P2P network framework, and can be deployed in WAN/LAN with centralized Bootstrap or Relay server or without. In the first release of Binance TSS, It will support running in the LAN firstly.

TSS includes two major processes:

- n quorum participants can jointly create secret shares of private key through the Keygen CLI.
- Any t+1 of n required participants can sign the transactions using their secret shares through the Sign CLI

## Architecture

Below diagram demonstrate 1-3 deployment, i.e., 3 participants for the key gen and any 2 of these participants can do the signing, and one signature will be broadcast to the Binance Chain Successfully.

**![img](https://lh3.googleusercontent.com/JmrMjUgE6P13PUl89mnqlB9XtybQWdbUJFdBoTEkkflF7XAQC3KrlLKqXzr3Jdm4Uq9uGsYFz_ylHEbwvkYCR16fqva5ovOepMkPuieV5ApRyGuagMy6eQssBNS9UfA2G053aRKL)**

Each party are the p2p peers, and setup up connection through the bootstrap process.

Each party has its own home directory to save the encrypted private key shares and p2p configs.

##  Where can I download the Binance TSS CLI?

- You can download tss client from: [https://github.com/binance-chain/tss-binary](https://github.com/binance-chain/node-binary)
- You can download Binance Chain CLI release tbnbcli/bnbcli from: https://github.com/binance-chain/node-binary

## How to Use

Basically, any one of n participants in the same LAN can initiate the keygen with the valut policy, i.e., t - n.

Any one of participants can invite other >t participants to join the signing.

Annotation Note

Red text: user input

Grey text: user password input, will be hidden

Warning:

The secrets are generated in home directory, e.g., ./tss, and are stored in the encrypted keystore. The passphrase should be carefully maintained.



## TSS Init

Create home directory of a new tss setup, generate p2p key pair.



Example:

|                            | A                                                            | B                                                            | C                                                            |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| command                    | ./tss init                                                   | ./tss init                                                   | ./tss init                                                   |
| Interactive input          | > please set moniker of this party: tss1> please set vault of this party:vault1> please set password of this vault:1234qwerasdf> please input again:1234qwerasdf | > please set moniker of this party: tss2> please set vault of this party:vault1> please set password of this vault:asdfqwer1234> please input again:asdfqwer1234 | > please set moniker of this party: tss3> please set vault of this party:vault1> please set password of this vault:qwer1234asdf> please input again:qwer1234asdf |
| output                     | Local party has been initialized under: ~/.tss/vault1        | Local party has been initialized under: ~/.tss/vault1        | Local party has been initialized under: ~/.tss/vault1        |
| Files touched or generated | ~/.tss/vault1/config.json~/.tss/vault1/node_key              | ~/.tss/vault1/config.json~/.tss/vault1/node_key              | ~/.tss/vault1/config.json~/.tss/vault1/node_key              |

## Generate bootstrap channel id (./tss channel):



Example:

|                            | A                                                          | B    | C    |
| -------------------------- | ---------------------------------------------------------- | ---- | ---- |
| command                    | ./tss channel                                              | N/A  | N/A  |
| Interactive input          | > please set expire time in minutes, (default: 30):[Enter] | N/A  | N/A  |
| output                     | channel id: **3085D3EC76D**                                | N/A  | N/A  |
| Files touched or generated | N/A                                                        | N/A  | N/A  |

## Keygen (tss keygen)



### Example

|                            | A                                                            | B                                                            | C                                                            |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| command                    | ./tss keygen --vault_name vault1                             | ./tss keygen --vault_name vault1                             | ./tss keygen --vault_name vault1                             |
| Interactive input          | > Password to sign with this vault:1234qwerasdf> Do you like re-bootstrap again?[y/N]: [Enter] > please set total parties(n): 3> please set threshold(t), at least t + 1 parties  need participant signing: 1> please set channel id of this session3085D3EC76Dplease input password (AGREED offline with peers) of this session:123456789Password of this tss vault: 1234qwerasdf | > Password to sign with this vault:asdfqwer1234> Do you like re-bootstrap again?[y/N]: [Enter] > please set total parties(n): 3> please set threshold(t), at least t + 1 parties need participant signing: 1> please set channel id of this session3085D3EC76Dplease input password (AGREED offline with peers) of this session: 123456789Password of this tss vault: asdfqwer1234 | > Password to sign with this vault:qwer1234asdf> Do you like re-bootstrap again?[y/N]: [Enter] > please set total parties(n): 3> please set threshold(t), at least t + 1 parties need participant signing: 1> please set channel id of this session3085D3EC76Dplease input password (AGREED offline with peers) of this session: 123456789Password of this tss vault: qwer1234asdf |
| output                     | 18:00:09.777  INFO    tss-lib: party {0,tss1}: keygen finished! party.go:11318:00:09.777  INFO        tss: [tss1] received save data client.go:30418:00:09.777  INFO        tss: [tss1] bech32 address is: tbnb1mcn0tl9rtf03ke7g2a6nedqtrd470e8l8035jp client.go:309Password of this tss vault:NAME:   TYPE:   ADDRESS:                                                PUBKEY:tss_tss1_vault1        tss     tbnb19277gzv934ayctxeg5k9zdwnx3j48u6tydjv9p     bnbp1addwnpepqwazk6d3f6e3f5rjev6z0ufqxk8znq8z89ax2tgnwmzreaq8nu7sx2u4jcc | 18:00:09.777  INFO    tss-lib: party {1,tss2}: keygen finished! party.go:11318:00:09.777  INFO        tss: [tss2] received save data client.go:30418:00:09.777  INFO        tss: [tss2] bech32 address is: tbnb1mcn0tl9rtf03ke7g2a6nedqtrd470e8l8035jp client.go:309Password of this tss vault:NAME:   TYPE:   ADDRESS:                                                PUBKEY:tss_tss2_vault1       tss     tbnb19277gzv934ayctxeg5k9zdwnx3j48u6tydjv9p     bnbp1addwnpepqwazk6d3f6e3f5rjev6z0ufqxk8znq8z89ax2tgnwmzreaq8nu7sx2u4jcc | 18:00:09.773  INFO    tss-lib: party {2,tss3}: keygen finished! party.go:11318:00:09.773  INFO        tss: [tss3] received save data client.go:30418:00:09.773  INFO        tss: [tss3] bech32 address is: tbnb1mcn0tl9rtf03ke7g2a6nedqtrd470e8l8035jp client.go:309Password of this tss vault:NAME:   TYPE:   ADDRESS:                                                PUBKEY:tss_tss3_vault1        tss     tbnb19277gzv934ayctxeg5k9zdwnx3j48u6tydjv9p     bnbp1addwnpepqwazk6d3f6e3f5rjev6z0ufqxk8znq8z89ax2tgnwmzreaq8nu7sx2u4jcc |
| Files touched or generated | ~/.tss/vault1/pk.json~/.tss/vault1/sk.json~/.tss/vault1/config.json | ~/.tss/vault1/pk.json~/.tss/vault1/sk.json~/.tss/vault1/config.json | ~/.tss/vault1/pk.json~/.tss/vault1/sk.json~/.tss/vault1/config.json |

## Sign (with bnbcli)

The minimal required (t+1) participants can sign the transaction.

Example:

Table 1:

Generate a channel id and channel password, share face to face

|                   | A                           | B    | C    |
| ----------------- | --------------------------- | ---- | ---- |
| command           | ./tss channel               | N/A  | N/A  |
| Interactive input | N/A                         | N/A  | N/A  |
| output            | channel id: **5185D3EF597** | N/A  | N/A  |

Table 2:

Sign with A and B

|                            | A                                                            | B                                                            | C    |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---- |
| command                    | tbnbcli send --amount 1000000:BNB --to tbnb1mh3w2kxmdmnvctt7t5nu7hhz9jnp422edqdw2d --from tss_tss1_vault1 --chain-id Binance-Chain-Nile --node https://data-seed-pre-0-s1.binance.org:443 --trust-node | tbnbcli send --amount 1000000:BNB --to tbnb1mh3w2kxmdmnvctt7t5nu7hhz9jnp422edqdw2d --from tss_tss2_vault1 --chain-id Binance-Chain-Nile --node https://data-seed-pre-0-s1.binance.org:443 --trust-node | NA   |
| Interactive input          | Password to sign with tss_tss1_vault1:1234qwerasdf> Channel id:5185D3EF597please input password (AGREED offline with peers) of this session: 987654321 | Password to sign with tss_tss2_vault1:asdfqwer1234> Channel id:5185D3EF597please input password (AGREED offline with peers) of this session: 987654321 | N/A  |
| output                     | Committed at block 33600477 (tx hash: 4FB8096A93D545612A3B5DCE520622608C299C7742103A6BE34C444829BD83A5 | ERROR: broadcast_tx_commit: Response error: RPC error -32603 - Internal error: Error on broadcastTxCommit: Tx already exists in cache | N/A  |
| Files touched or generated | N/A                                                          | N/A                                                          | N/A  |

Note:

1. Please make sure you didn’t change ./tss ./tbnbcli ./bnbcli file name and they are in same directory and all have “executable” linux file flag
2. Only one client will successfully broadcast the transaction (the first client in above table).

## Sign (without bnbcli):

The minimal required (t+1) participants can sign the transaction. Currently this subcommand used for signing a fake message (won’t broadcast transaction to blockchain). It can be used to check whether keygen result in working shares which can get the same signature in a sign session.



Example:

Table 1:

Generate a channel id and channel password, share face to face

|                   | A                           | B    | C    |
| ----------------- | --------------------------- | ---- | ---- |
| command           | ./tss channel               | N/A  | N/A  |
| Interactive input | N/A                         | N/A  | N/A  |
| output            | channel id: **5185D3EF597** | N/A  | N/A  |

Table 2:

Sign with A and B

|                            | A                                                            | B                                                            | C    |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---- |
| command                    | ./tss sign                                                   | ./tss sign                                                   | NA   |
| Interactive input          | > please set vault of this party:1234qwerasdf> please set channel id of this session5185D3EF597> please input password (AGREED offline with peers) of this session: 987654321 | > please set vault of this party:asdfqwer1234> please set channel id of this session5185D3EF597> please input password (AGREED offline with peers) of this session: 987654321 | N/A  |
| output                     | INFO    tss-lib: party {0,tss1}: sign finished!              | INFO    tss-lib: party {1,tss2}: sign finished!              | N/A  |
| Files touched or generated | N/A                                                          | N/A                                                          | N/A  |

## Regroup (TSS regroup)



Example:

### Refresh all parties secret share and configs (we recommend doing this periodically, say once a month)

Table1: preparation of regroup, generate a new channel id, and n - t - 1 parties need init a temporal new share folder

|                   | A                           | B    | C                                                            |
| ----------------- | --------------------------- | ---- | ------------------------------------------------------------ |
| command           | ./tss channel               | N/A  | ./tss init                                                   |
| Interactive input | N/A                         | N/A  | > please set moniker of this party: tss3> please set vault of this party:vault1_tmp> please set password of this vault:qwer1234asdf> please input again:qwer1234asdf |
| output            | channel id: **3415D3FBE00** | N/A  | Local party has been initialized under: ~/.tss/vault1_tmp    |

Table2: regroup

|                            | A                                                            | B                                                            | C (doesn’t participant in signing, manual init and replace)  |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| command                    | ./tss regroup                                                | ./tss regroup                                                | ./tss regroup                                                |
| Interactive input          | > please set vault of this party:vault1> Password to sign with this vault:1234qwerasdf> Participant as a new committee? [Y/n]:Y> please set new total parties(n): 3> please set new threshold(t), at least t + 1 parties   participant signing: 1> Channel id:3415D3FBE00please input password (AGREED offline with peers) of this session: 123456789 | > please set vault of this party:vault1> Password to sign with this vault:asdfqwer1234> Participant as a new committee? [Y/n]:Y> please set new total parties(n): 3> please set new threshold(t), at least t + 1 parties need participant signing: 1> Channel id:3415D3FBE00please input password (AGREED offline with peers) of this session: 123456789 | > please set vault of this party:vault1> Password to sign with this vault:qwer1234asdf> please set old total parties(n) (default: 3):3> please set old threshold(t), at least t + 1 parties needs participant signing (default: 1):1> please set new total parties(n): 3> please set new threshold(t), at least t + 1 parties needs participant signing: 1> Channel id:3415D3FBE00please input password (AGREED offline with peers) of this session: 123456789 |
| post execution command     |                                                              |                                                              | mv ~/.tss/vault1_tmp ~/.tss/vault1                           |
| output                     | INFO        tss: [tss1] bech32 address is: tbnb1mcn0tl9rtf03ke7g2a6nedqtrd470e8l8035jp | INFO        tss: [tss2] bech32 address is: tbnb1mcn0tl9rtf03ke7g2a6nedqtrd470e8l8035jp | INFO        tss: [tss3] bech32 address is: tbnb1mcn0tl9rtf03ke7g2a6nedqtrd470e8l8035jp |
| Files touched or generated | ~/.tss/vault1/config.json~/.tss/vault1/pk.json~/.tss/vault1/sk.json~/.tss/vault1/node_key | ~/.tss/vault1/config.json~/.tss/vault1/pk.json~/.tss/vault1/sk.json~/.tss/vault1/node_key | ~/.tss/vault1/config.json~/.tss/vault1/pk.json~/.tss/vault1/sk.json~/.tss/vault1/node_key |

### New committee having different t-n from old committee

1. Change 1-3 into 2-4 scheme.
2.  old parties (A, B) join new committee
3. new parties (D, E) are newly-joined

Table 1:

Init profiles for 2 new parties (D and E)

|                   | D                                                            | E                                                            |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| command           | ./tss init  --vault_name vault1                              | ./tss init  --vault_name vault1                              |
| Interactive input | > please set moniker of this party: tss4> please set password for key share:7890uiopjkl;> please intput again:7890uiopjkl | > please set moniker of this party: tss5> please set password for key share:uiopjkl;7890> please input again:uiopjkl;7890 |
| output            | Local party has been initialized under: ~/.tss/vault1        | Local party has been initialized under: ~/.tss/vault1        |

Table 2:

Regroup from 1-3 to 2-4, with 2 old parties (A and B) and 2 new parties (D and E)

|                            | A (old&new committee)                                        | B (old&new committee)                                        | D (new committee)                                            | E (new committee)                                            |
| -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| command                    | ./tss regroup/ --vault_name vault1                           | ./tss regroup  --vault_name vault1                           | ./tss regroup  --vault_name vault1                           | ./tss regroup  --vault_name vault1                           |
| Interactive input          | > please input password:1234qwerasdf> Participant as a new commitee? [Y/n]:Y> please set NEW total parties(n): 4> please set NEW threshold(t), at least t + 1 parties   participant signing: 2> Channel id:3415D3FBE00> please input password (AGREED offline with peers) of this session:123456789 | > please input password:asdfqwer1234> Participant as a new committee? [Y/n]:Y> please set NEW total parties(n): 4> please set NEW threshold(t), at least t + 1 parties need participant signing: 2> Channel id:3415D3FBE00> please input password (AGREED offline with peers) of this session:123456789 | > please input password:7890uiopjkl;> please set Old total parties(n): 3> please set Old threshold(t), at least t + 1 parties need participant signing: 1> please set NEW total parties(n): 4> please set NEW threshold(t), at least t + 1 parties need participant signing: 2> Channel id:3415D3FBE00> please input password (AGREED offline with peers) of this session:123456789 | > please input password:uiopjkl;7890> please set Old total parties(n): 3> please set Old threshold(t), at least t + 1 parties need participant signing: 1> please set NEW total parties(n): 4> please set NEW threshold(t), at least t + 1 parties need participant signing: 2> Channel id:3415D3FBE00> please input password (AGREED offline with peers) of this session:123456789 |
| output                     |                                                              |                                                              |                                                              |                                                              |
| Files touched or generated | ~/.tss/vault1/config.json~/.tss/vault1/pk.json~/.tss/vault1/sk.json | ~/.tss/vault1/config.json~/.tss/vault1/pk.json~/.tss/vault1/sk.json | ~/.tss/vault1/config.json~/.tss/vault1/pk.json~/.tss/vault1/sk.json | ~/.tss/payment/config.json~/.tss/payment/pk.json~/.tss/vault1/sk.json |

# Security Guideline

## Vault Policy Guideline

- Your quorum groups should have more participants than the required minimum number for approval. This setup allows replacing a participant or restoring one participant,. For example, your group has 2 participants required for signing, and it has 3 participants. A participant loses his shared key, and the remaining 2 can reactivate the participant by regroup process.
- Validate the correctness of keygen: sign several small transactions using different combinations of different parties to ensure the correctness of the encrypted shares. Only after the validation is done, transfer funds to this address.
- To avoid any potential leakage, regularly regroup (e.g., monthly) are recommended.
- After the regroup, the existing key shares including backup should be removed permanently.

## Shared Key Backup and Restore

- The encrypted file with shared keys should be stored in a very secured place and backup (remember to delete the old backup after regroup) as well.
- Creating some participants only for key regeneration and regroup. Their secret shares should be safely stored offline, e.g., no internet access.

Offline insurance:

- Monikers should be distinct
- Channel password should be discussed each time a new session (keygen, sign, regroup) is going to be established
- No other tss process (with same channel) is running at the same time one vault is running

# Troubleshooting

TBD
# User Guide of Threshold Signature Scheme (TSS) in Binance Chain

Binance TSS is based on P2P network framework, and can be deployed in WAN/LAN with centralized Bootstrap or Relay server or without. In the first release of Binance TSS, It will support running in the LAN firstly.

TSS includes two major processes:
* n quorum participants can jointly create secret shares of private key through the Keygen CLI.
* Any t+1 of n required participants can sign the transactions using their secret shares through the Sign CLI


## Play in localhost
Please note, "--password" option should only be used in testing. Without this option, the cli would ask interactive input and confirm

## Init P2P Channel

init 3 parties
```
./tss init --home ~/.test1 --vault_name "default" --moniker "test1" --password "123456789"
./tss init --home ~/.test2 --vault_name "default" --moniker "test2" --password "123456789"
./tss init --home ~/.test3 --vault_name "default" --moniker "test3" --password "123456789"
```

## Generate Bootstrap Channel
generate channel id replace value of "--channel_id" for following commands with generated one
```
./tss channel --channel_expire 30
```

## Keygen for testnet

```
./tss keygen --home ~/.test1 --vault_name "default" --parties 3 --threshold 1 --password "123456789" --channel_password "123456789"  --address_prefix tbnb --channel_id "3725D5527F8"
./tss keygen --home ~/.test2 --vault_name "default" --parties 3 --threshold 1 --password "123456789" --channel_password "123456789" --address_prefix tbnb --channel_id "3725D5527F8"
./tss keygen --home ~/.test3 --vault_name "default" --parties 3 --threshold 1 --password "123456789" --channel_password "123456789" --address_prefix tbnb --channel_id "3725D5527F8"
```
Output:
```
t17:10:26.170  INFO        tss: [test1] initialized localParty: id: {2,test1}, round: 1 client.go:184
17:10:26.173  INFO      trans: waiting peers connection... p2p_transporter.go:187
17:10:27.195  INFO      trans: Connected to: 12D3KooWPSXSxTCoDFzFKVYFyvWp6KyajsJvEy2FsXpifvkQky65(/tss/party/0.0.1) p2p_transporter.go:283
17:10:27.195  INFO      trans: Connected to: 12D3KooWCVtzyXWkZzqB3VEeYky2AbQ3RsyRg86rYCbMg6GrrcRC(/tss/party/0.0.1) p2p_transporter.go:283
17:10:27.203  INFO    tss-lib: party {2,test1}: keygen round 1 starting local_party.go:121
17:10:27.417  INFO        tss: [test1] received message: Type: KGRound1CommitMessage, From: {0,test3}, To: all client.go:252
17:10:27.565  INFO        tss: [test1] received message: Type: KGRound1CommitMessage, From: {1,test2}, To: all client.go:252
17:10:27.565  INFO    tss-lib: party {2,test1}: keygen round 2 started party.go:105
17:10:27.565  INFO        tss: [test1] received message: Type: KGRound2VssMessage, From: {1,test2}, To: [{2,test1}] client.go:252
17:10:27.565  INFO        tss: [test1] received message: Type: KGRound2DeCommitMessage, From: {1,test2}, To: all client.go:252
17:10:27.565  INFO        tss: [test1] received message: Type: KGRound2VssMessage, From: {0,test3}, To: [{2,test1}] client.go:252
17:10:27.565  INFO        tss: [test1] received message: Type: KGRound2DeCommitMessage, From: {0,test3}, To: all client.go:252
17:10:27.617  INFO    tss-lib: party {2,test1}: keygen round 3 started party.go:105
17:10:27.617  INFO        tss: [test1] received message: Type: KGRound3PaillierProveMessage, From: {0,test3}, To: all client.go:252
17:10:27.619  INFO        tss: [test1] received message: Type: KGRound3PaillierProveMessage, From: {1,test2}, To: all client.go:252
17:10:27.690  INFO    tss-lib: party {2,test1}: keygen round 4 started party.go:105
17:10:27.690  INFO    tss-lib: party {2,test1}: keygen finished! party.go:113
17:10:27.690  INFO        tss: [test1] received save data client.go:294
17:10:27.690  INFO        tss: [test1] bech32 address is: tbnb1r9q9zpnpnsl742kdm4nzvw6aj0a3xg0nrld7xd client.go:299
17:10:29.052  INFO        tss: trying to add the key to bnbcli's default keystore... keygen.go:164
NAME:	TYPE:	ADDRESS:				PUBKEY:
tss_test1_default	tss	tbnb1r9q9zpnpnsl742kdm4nzvw6aj0a3xg0nrld7xd	bnbp1addwnpepqgeu7xgsefx2xnn8sg5w6rn6vnfme7ls0cztahmd4ewwxvuvkq7lv04y46a
17:10:30.307  INFO        tss: added tss_test1_default to bnbcli's default keystore keygen.go:227
```
* Verify the new key
```
./tbnbcli keys list
NAME:	TYPE:	ADDRESS:				PUBKEY:
tss_test1_default	tss	tbnb1r9q9zpnpnsl742kdm4nzvw6aj0a3xg0nrld7xd	bnbp1addwnpepqgeu7xgsefx2xnn8sg5w6rn6vnfme7ls0cztahmd4ewwxvuvkq7lv04y46a
tss_test2_default	tss	tbnb1r9q9zpnpnsl742kdm4nzvw6aj0a3xg0nrld7xd	bnbp1addwnpepqgeu7xgsefx2xnn8sg5w6rn6vnfme7ls0cztahmd4ewwxvuvkq7lv04y46a
tss_test3_default	tss	tbnb1r9q9zpnpnsl742kdm4nzvw6aj0a3xg0nrld7xd	bnbp1addwnpepqgeu7xgsefx2xnn8sg5w6rn6vnfme7ls0cztahmd4ewwxvuvkq7lv04y46a
```

* Send issue transaction

From the first terminal:
```
./tbnbcli token issue --token-name "New TSS " --total-supply 100000000000000000 --symbol TSS --mintable --from  tss_test1_default --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80 --trust-node
```
From the second terminal:
```
./tbnbcli token issue --token-name "New TSS " --total-supply 100000000000000000 --symbol TSS --mintable --from  tss_test2_default --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80 --trust-node
```

Please note that you must put the right channel-id

Wait for the messages:
```
17:25:19.697  INFO      trans: waiting peers connection... p2p_transporter.go:187
17:25:26.790  INFO      trans: Connected to: 12D3KooWASTTFXQBdjxNn12r6nzpUR5Ggam9md9yYyZZNM8HSdEB(/tss/bootstrap/0.0.1) p2p_transporter.go:293
17:25:26.790  INFO      trans: local addr in message: /ip4/0.0.0.0/tcp/53260 p2p_transporter.go:298
17:25:27.718  INFO      trans: Closing p2ptransporter p2p_transporter.go:253
17:25:28.202  INFO        tss: [test2] public key: 0233CF1910CA4CA34E678228ED0E7A64D3BCFBF07E04BEDF6DAE5CE3338CB03DF6
 client.go:188
17:25:28.204  INFO      trans: waiting peers connection... p2p_transporter.go:187
17:25:29.296  INFO      trans: Connected to: 12D3KooWASTTFXQBdjxNn12r6nzpUR5Ggam9md9yYyZZNM8HSdEB(/tss/party/0.0.1) p2p_transporter.go:283
17:25:29.307  INFO        tss: [test2] message to be signed: 33823093859395187352907287615777225132638601044446195572390473043797905548022
 keys.go:43
17:25:29.307  INFO        tss: [test2] initialized localParty: id: {0,test2}, round: 1 keys.go:45
17:25:29.307  INFO    tss-lib: party {0,test2}: signing round preparing local_party.go:158
17:25:29.307  INFO    tss-lib: party {0,test2}: signing round 1 starting local_party.go:162
17:25:29.391  INFO        tss: [test2] received message: Type: SignRound1MtAInitMessage, From: {1,test1}, To: [{0,test2}] client.go:252
17:25:29.392  INFO        tss: [test2] received message: Type: SignRound1CommitMessage, From: {1,test1}, To: all client.go:252
17:25:29.536  INFO    tss-lib: party {0,test2}: sign round 2 started party.go:105
17:25:29.538  INFO        tss: [test2] received message: Type: SignRound2MtAMidMessage, From: {1,test1}, To: [{0,test2}] client.go:252
17:25:29.636  INFO    tss-lib: party {0,test2}: sign round 3 started party.go:105
17:25:29.643  INFO        tss: [test2] received message: Type: SignRound3Message, From: {1,test1}, To: all client.go:252
17:25:29.643  INFO    tss-lib: party {0,test2}: sign round 4 started party.go:105
17:25:29.643  INFO        tss: [test2] received message: Type: SignRound4DecommitMessage, From: {1,test1}, To: all client.go:252
17:25:29.644  INFO    tss-lib: party {0,test2}: sign round 5 started party.go:105
17:25:29.644  INFO        tss: [test2] received message: Type: SignRound5CommitmentMessage, From: {1,test1}, To: all client.go:252
17:25:29.644  INFO    tss-lib: party {0,test2}: sign round 6 started party.go:105
17:25:29.644  INFO        tss: [test2] received message: Type: SignRound6DecommitmentMessage, From: {1,test1}, To: all client.go:252
17:25:29.646  INFO    tss-lib: party {0,test2}: sign round 7 started party.go:105
17:25:29.646  INFO        tss: [test2] received message: Type: SignRound7CommitMessage, From: {1,test1}, To: all client.go:252
17:25:29.646  INFO    tss-lib: party {0,test2}: sign round 8 started party.go:105
17:25:29.646  INFO        tss: [test2] received message: Type: SignRound8DecommitMessage, From: {1,test1}, To: all client.go:252
17:25:29.646  INFO    tss-lib: party {0,test2}: sign round 9 started party.go:105
17:25:29.646  INFO        tss: [test2] received message: Type: SignRound9SignatureMessage, From: {1,test1}, To: all client.go:252
17:25:29.646  INFO    tss-lib: party {0,test2}: sign round 10 started party.go:105
17:25:29.646  INFO    tss-lib: party {0,test2}: sign finished! party.go:113
Committed at block 33757693 (tx hash: A40AAB97C7D6674FD14B7E6327929C9187C2723B33F4D290125D9EAED1579CC5, response: {Code:0 Data:[123 34 110 97 109 101 34 58 34 78 101 119 32 84 83 83 32 34 44 34 115 121 109 98 111 108 34 58 34 84 83 83 45 65 52 48 34 44 34 111 114 105 103 105 110 97 108 95 115 121 109 98 111 108 34 58 34 84 83 83 34 44 34 116 111 116 97 108 95 115 117 112 112 108 121 34 58 34 49 48 48 48 48 48 48 48 48 48 46 48 48 48 48 48 48 48 48 34 44 34 111 119 110 101 114 34 58 34 116 98 110 98 49 114 57 113 57 122 112 110 112 110 115 108 55 52 50 107 100 109 52 110 122 118 119 54 97 106 48 97 51 120 103 48 110 114 108 100 55 120 100 34 44 34 109 105 110 116 97 98 108 101 34 58 116 114 117 101 125] Log:Msg 0: Issued TSS-A40 Info: GasWanted:0 GasUsed:0 Tags:[{Key:[97 99 116 105 111 110] Value:[105 115 115 117 101 77 115 103] XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0}] Codespace: XXX_NoUnkeyedLiteral:{} XXX_unrecognized:[] XXX_sizecache:0})
```

One party will send out the transaction successfully and the other party will fail:
```
17:25:29.647  INFO    tss-lib: party {1,test1}: sign finished! party.go:113
ERROR: broadcast_tx_commit: Response error: RPC error -32603 - Internal error: Error on broadcastTxCommit: Tx already exists in cache
```

This is totally normal and random.

* Send submit proposal transaction
```
./tbnbcli gov submit-list-proposal --from tss_test1_default --deposit 200000000:BNB --base-asset-symbol TSS-A40  --quote-asset-symbol BNB --init-price 100000000 --title "list TSS-A40/BNB" --description "list TSS-A40/BNB" --expire-time 1565961508 --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80 --json --voting-period 3600
```

```
./tbnbcli gov submit-list-proposal --from tss_test3_default --deposit 200000000:BNB --base-asset-symbol TSS-A40  --quote-asset-symbol BNB --init-price 100000000 --title "list TSS-A40/BNB" --description "list TSS-A40/BNB" --expire-time 1565961508 --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80 --json --voting-period 3600
```

* Add deposit
```
./tbnbcli gov deposit --from tss_test2_default --proposal-id 901 --deposit 200000000000:BNB --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80
```

```
./tbnbcli gov deposit --from tss_test3_default --proposal-id 901 --deposit 200000000000:BNB --chain-id=Binance-Chain-Nile --node=data-seed-pre-2-s1.binance.org:80
```
