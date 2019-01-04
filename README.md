# uart_loopback
UARTの練習がてら作成した、RXから受信したデータをTXへ送信するだけのループバック回路。

本体は uart_loopback.v で、

```
module uart_loopback(
  input clk,
  input rst,
  input rx,
  output tx
);
  wire [7:0] data;
  wire flag;

  uart #(
    .baud_rate(9600),                 // default is 9600
    .sys_clk_freq(50000000)           // default is 100000000
  )
  instance_name(
    .clk(clk),                        // The master clock for this module
    .rst(rst),                        // Synchronous reset
    .rx(rx),                          // Incoming serial line
    .tx(tx),                          // Outgoing serial line
    // transmitがtrueにセットされるとTXへの送信が開始される
    // 再度TXへ送信したい場合は一度falseに戻したのち再度trueをセットする必要がある
    .transmit(flag),                  // Signal to transmit
    .tx_byte(data),                   // Byte to transmit
    // RXからデータを受信した場合にtrueがセットされ、1クロックの間保持したのち、再度falseに戻る
    .received(flag),                  // Indicated that a byte has been received
    .rx_byte(data),                   // Byte received
    .is_receiving(),                  // Low when receive line is idle
    .is_transmitting(),               // Low when transmit line is idle
    .recv_error()                     // Indicates error in receiving packet.
  );

endmodule
```

それをトップのモジュール(DE10_LITE_Golden_Top.v)から呼び出している。

```
  ...

  uart_loopback loopback0 (
    .clk(MAX10_CLK1_50),
    .rst(),
    .rx(ARDUINO_IO[0]), // USBシリアル変換アダプタの TX と接続
    .tx(ARDUINO_IO[1])  // USBシリアル変換アダプタの RX と接続
  );

  ...
```
## 動作確認方法

Arduino IDEのシリアルモニタから文字列を入力して送信し、入力した文字列がそのまま返ってくればOK

## 使用した UART Core

Intel の UART Core を使おうと思ってたんだけど、University Program じゃないと使えないとのこと。

代わりに

https://hackaday.com/2018/09/06/fpga-pov-toy-gets-customized/

を参考にしながら

https://github.com/wd5gnr/max1000-tutorial/blob/master/cores/osdvu/uart.v

の UART Core を使用することにした。
