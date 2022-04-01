
# 概要

書籍「プロを目指す人のためのRuby入門 改訂2版（2021年12月発売）」のサンプルコードを、自分なりに変更してみていきます。

## 参考

<https://github.com/JunichiIto/ruby-book-codes-v2>

<https://github.com/minitest-reporters/minitest-reporters>

<https://qiita.com/jnchito/items/60ea1389d00e72b729e7>

## mermaid で書いた例

### シーケンス図

```mermaid
%%  {init: {'securityLevel': 'loose', 'theme':'base'}} 
%%{init: {'theme': 'base', 'themeVariables': { 'primaryColor': '#888888', 'textColor': '#88aaaa'}}}%%

sequenceDiagram

participant A as 乗客
participant G1 as 駅<br/>(umeda)
participant G2 as 駅<br/>(mikuni)
participant T as チケット<br/>(Ticket)

A->>T: 購入
A->>G1: enter()
G1->>T: stamp()

A->>G2: exit()
G2->> + T: fare()
T-->> - G2: 金額
G2->> + T: stamped_at()
T-->> - G2: 乗車駅
G2-->>G2: 乗車駅からの運賃を計算する。

G2-->>A: 運賃 <= 金額 なら true<br/>そうでなければ false
```

### チケットの状態遷移図

```mermaid
%%  {init: {'securityLevel': 'loose', 'theme':'base'}} 
%%{init: {'theme': 'base', 'themeVariables': { 'primaryColor': '#888888', 'textColor': '#88aaaa', 'lineColor':'#ff8800'}}}%%

stateDiagram-v2
    [*] --> Unused : new<br/>(購入)
    Unused --> Entering : enter
    Entering --> Used : exit
    Used --> [*]
    Error --> [*]

    Unused --> Error : exit
    Entering --> Error : enter
    Used --> Error : enter
    Used --> Error : exit
```
