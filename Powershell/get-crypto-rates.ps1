<#
.SYNOPSIS
	Lists the latest crypto exchange rates
.DESCRIPTION
	This script lists the latest crypto exchange rates.
.EXAMPLE
	PS> ./get-crypto-rates
#>

function GetCryptoRate { param([string]$Symbol, [string]$Name)
	$Rates = (invoke-webRequest -uri "https://min-api.cryptocompare.com/data/price?fsym=$Symbol&tsyms=USD,EUR,GBP" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	new-object PSObject -property @{ 'Cryptocurrency' = "1 $Name ($Symbol) ="; 'USD' = "$($Rates.USD)"; 'EUR' = "$($Rates.EUR)"; 'GBP' = "$($Rates.GBP)" }
}

function GetCryptoRates 
{ 
	GetCryptoRate BTC "Bitcoin"
	GetCryptoRate ETH "Ethereum"
	GetCryptoRate ADA "Cardano"
	GetCryptoRate DOGE "Dogecoin"
	GetCryptoRate DOT "Polkadot"
	GetCryptoRate SOL "Solana"
	GetCryptoRate LTC "Litecoin"
}

try 
{
	""
	"Latest Crypto Exchange Rates from cryptocompare"
	"============================="
	GetCryptoRates | format-table -property @{e='Cryptocurrency';width=20},USD,EUR,GBP
	exit 0
} 
catch 
{
	"Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
