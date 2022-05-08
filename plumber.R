# plumber.R

#* @apiTitle Cointel Finance API

#* @preempt __first__
#* @get /
function(req, res) {
  res$status <- 302
  res$setHeader("Location", "./__docs__/")
  res$body <- "Redirecting..."
  res
}

#* CoinGecko Categories
#* @get /categories
function(){
  log_name <- paste0("logs/categories/",Sys.time(),".json")
  jsonlite::write_json("1",log_name)
  rm(log_name)
  jsonlite::fromJSON("https://api.coingecko.com/api/v3/coins/categories/list")
}

#* CoinGecko Category Info
#* @get /category_info
function(){
  log_name <- paste0("logs/category_info",as.numeric(Sys.time()),".json")
  jsonlite::write_json(jsonlite::toJSON("1"),log_name)
  rm(log_name)
  jsonlite::fromJSON("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=1000&page=1&sparkline=false")
}

#* Covalant Wallet Transactions
#* @param wallet_address 
#* @get /wallet_transactions
function(wallet_address = ""){
  log_name <- paste0("logs/wallet_transactions",as.numeric(Sys.time()),".json")
  jsonlite::write_json(jsonlite::toJSON("1"),log_name)
  rm(log_name)
  query_string <- paste0("https://api.covalenthq.com/v1/43114/address/",wallet_address,"/balances_v2/?quote-currency=USD&format=JSON&nft=false&no-nft-fetch=false&key=ckey_41d020c4ec2c4d7b9781a57b4ba")
  fromJSON(query_string)$data$items
}

#* Cointel API Requests Count
#* @param api_call 
#* @get /request_count
function(api_call = ""){
  log_path <- paste0("logs/",api_call)
  length(list.files(log_path))
}

#* Cointel API Requests Logs
#* @get /request_logs
function(api_call = ""){
  log_path <- paste0("logs/",api_call)
  list.files(log_path) %>% toJSON()
}
