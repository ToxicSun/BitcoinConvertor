Bitcoin to EUR currency converter
===============

A simple Bitcoin to EUR currency converter app. App is fetching historical data from Bitcoin index through the following [endpoint] (https://api.coindesk.com/v1/bpi/historical/close.json)


Application
----------

The application is written in Swift and uses a MVP architecture. Project itself is simple and simple MVP design satisfies it's needs.

No 3rd party library is used. Every class is following protocol oriented approach, nothing is depended on the concrete implementation (DI) except of ViewModel because it uses associative type.

