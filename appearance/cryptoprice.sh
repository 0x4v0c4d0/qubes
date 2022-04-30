watch -tcn5  "curl -s https://api-pub.bitfinex.com/v2/ticker/tETHUSD | awk -F',' '{print \"ETH/USD: $\" \$7}'"
