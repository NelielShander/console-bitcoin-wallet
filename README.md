# Minimal Console Bitcoin Wallet
Для запуска требуется версия Ruby не ниже 3.0
После клонирования репозитория выполнить `bundle install`
### Запуск
Запуск можно осуществить в docker'е

```console
docker conpose up app
docker compose exec app bin/console
```

или в командной сроке командной строке

```console
bundle
bin/console
```
Выбрать сеть Bitcoin можно выполнив к консоли
```console
Wallet.config.network = :mainnet
```
варианты
* :mainnet
* :signet
* :testnet
по умолчанию :signet
### Консольные команды
* Для создания приватного ключа и получения информации о кошельке.
```console
Wallet.details
```
В папке /lib/wallet/storage появится файл [private_key](lib/wallet/storage/private_key)

* Для того, чтобы отправить сумму на другой адрес, необходимо выполнить
```console
pay_to = 'mvaZsDH2yRWvamXw6PkdtJinPcYrDYv9Ec' # адрес кошелька
amount = 100000 # сумма в Sats
fee = 1000 # коммисия брокерам, по умолчанию 1000

Wallet.sendamount(pay_to:, amount:, fee:)
```
Для запуска тестов выполнить в командной строке
```console
bin/rspec
```
