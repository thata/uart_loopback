module uart_loopback(
  input clk,
  input rst,
  input rx,
  output tx
);

  //------------------------
  // ワイヤ・レジスタの宣言
  //------------------------
  wire [7:0] data;
  wire flag;

  //------------------------
  // ネット宣言
  //------------------------

  //------------------------
  // 下位モジュール呼び出し
  //------------------------

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
