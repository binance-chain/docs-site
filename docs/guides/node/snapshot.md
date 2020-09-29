# Chain Data Snapshots

A snapshot is a recording of the state of Binance Chain at a particular block height.

Latest snapshot of Sep 1st: [download](https://s3.ap-northeast-1.amazonaws.com/dex-bin.bnbstatic.com/s3-witness-data-download/data_20200909.tgz?AWSAccessKeyId=AKIAYINE6SBQPUZDDRRO&Expires=1625569110&Signature=%2BotMZCFW7bRSaK4DdRW6Qe3a4bw%3D)

Size: 409 GB

sha256sum: 194cbad7e1adcaafc16df94576f0a3b4a26245e4019cef93c51a3183bef71d73

Latest snapshot of July 1st: [download](https://s3.ap-northeast-1.amazonaws.com/dex-bin.bnbstatic.com/s3-witness-data-download/data_20200717.tgz?AWSAccessKeyId=AKIAYINE6SBQPUZDDRRO&Expires=1621148533&Signature=BQCDLF9UwALesZwGiW6mCfK5Kiw%3D)

Size: 353 GB

Snapshot of June 1st: [download](https://s3.ap-northeast-1.amazonaws.com/dex-bin.bnbstatic.com/s3-witness-data-download/data_back_20200601.zip?AWSAccessKeyId=AKIAYINE6SBQLLLS7OXI&Signature=BQlfX3ATfs%2Fj55qwi5q75feqga4%3D&Expires=1617016400)

Size: 309 GB

sha256sum: c6ba5edbf1b424696eec670f4dad864e09ebbae46c3c127360e1d1f15e27d4df)

This snapshot can be used for jumpstarting a newly setup fullnode to avoid waiting a long time for getting all blocks. In Binance Chain, the average block time is less than a second. As a result, it will take several weeks to sync from genesis block.


!!! Note
	Ensure there is enough disk space for both the tar file AND its uncompressed contents. Double the space or more.


1. Download Archive
```

nohup curl -s https://s3.ap-northeast-1.amazonaws.com/dex-bin.bnbstatic.com/s3-witness-data-download/data_20200909.tgz\?AWSAccessKeyId=\AKIAYINE6SBQPUZDDRRO\&Expires=\1625569110\&Signature=\%2BotMZCFW7bRSaK4DdRW6Qe3a4bw%3D > data_20200909.tgz &

```

2. Extract File to replace the contents under data folder of home directory
```
tar -xzf data_20200909.tgz -d $HOME/data
```

3. Start your node
```
bnbchaind start
```
