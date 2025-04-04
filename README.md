# Minimal Console Bitcoin Wallet

[![Build Status](https://github.com/NelielShander/console-bitcoin-wallet/actions/workflows/rspec.yml/badge.svg)](https://github.com/NelielShander/example_1/actions/workflows/rspec.yml)

При локальном запуске требуется версия Ruby не ниже 3.0. 

После клонирования репозитория выполнить `bundle install`.

### Запуск
Запуск консоли можно осуществить в командной сnроке:
```console
bin/console
```
или в docker'e:
```console
docker conpose up app
docker compose exec app bin/console
```

### Настройка
Выбрать сеть Bitcoin можно выполнив к консоли:
```console
Wallet.config.network = :mainnet
```
варианты
* :mainnet
* :signet
* :testnet

по умолчанию :signet

### Консольные команды
Для создания приватного ключа и получения информации о кошельке.
```console
Wallet.details
```
В папке /lib/wallet/storage появится файл [private_key](lib/wallet/storage/private_key)

Для того чтобы отправить сумму на другой адрес, необходимо выполнить

```console
pay_to = 'mvaZsDH2yRWvamXw6PkdtJinPcYrDYv9Ec' # адрес кошелька
amount = 100000 # сумма в Sats
fee    = 1000 # коммисия брокерам, по умолчанию 1000

Wallet.sendamount(pay_to:, amount:, fee:)
```
### Тестирование
Для запуска тестов выполнить в командной строке
```console
bin/rspec
```
