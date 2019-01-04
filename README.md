# uart_loopback
UARTの練習がてら作成した、RXから受信したデータをTXへ送信するだけのループバック回路。

## 使用した UART Core

Intel の UART Core を使おうと思ってたんだけど、University Program じゃないと使えないとのこと。

代わりに

https://hackaday.com/2018/09/06/fpga-pov-toy-gets-customized/

を参考にしながら

https://github.com/wd5gnr/max1000-tutorial/blob/master/cores/osdvu/uart.v

の UART Core を使用することにした。
