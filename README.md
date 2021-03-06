# アプリについて
これはスタジオ管理アプリのリポジトリです。<br>
私の所属するバンドサークル向けに作成しました。<br>
使用した言語・技術は、HTML, CSS, JS(jQuery), Ruby,  Ruby on Rails, LINE Messaging API, Heroku になります。<br>

# 開発背景
私の所属するバンドサークルでは、部室の利用を1時間30分毎の枠に区切っています。<br>
そして、その枠をバンドや個人が予約を入れて利用します。<br>
しかし、予約は部室内に置いてあるホワイトボードで運用しており、様々な問題や不便な点がありました。<br>
具体的な問題は次のようなものです。<br>

* 最新の情報が分からないため、バンドメンバーで予定を合わせて予約しに行くと既に枠が埋まっていた。
* 突然の予約キャンセルに対応できず、無駄に枠が消化される<br>
(ドラムは部室でしか練習できない人が多いため、1枠1枠が貴重)
* バンド練習をド忘れしてしまう人がいる<br>
* 個人練習で予約をしているのに来ない人がいる<br>
* 練習が多く入ってる人は予定管理が難しい<br>

オンラインでの予約確認と予約、自分の予定確認、他の人の予定の閲覧など、これらが出来ればより便利に、そしてサークルが活発になると思い開発に着手しました。<br>

# 機能
このアプリには以下の機能があります。<br>
* ログイン・ログアウト機能
* 一目で一週間分の予約が確認できる予約表<br>(3週間先まで予約可能で、自動で日付が更新)
* マイリスト機能で自身に関連する予約、興味のある予約を記録可能
* 予約表では、自身に関連する予約が違う色で表示されるため、関連予約が一目で確認可能
* 予約詳細で、誰が予約をマイリストしているか確認可能
* 予約を削除すると、自動でLINEグループに全体連絡<br>メッセージにはすぐに予約できるよう予約URLが記載
* 自分と他人の予約・マイリストを確認できるため、予定管理も楽々
* レスポンシブ対応のためPC・スマートフォンどちらでも快適に利用可能
* 自作のハンバーガーメニュー(SPのみ)とモーダル

予約状況が常に分かり、誰がどの時間に居るかも分かるため、よりコミュニケーションが活発になる効果も期待できます。<br>
具体的には互いにご飯に誘いあったり、楽器を先輩後輩で教え合うなどです。<br>
結果、サークルがより一層活気付くことが想定されます。

# 開発で意識した点
「気が向いた時にすぐ快適に利用できるアプリ」を念頭に置いて開発しました。<br>

ユーザの1回毎のアプリ利用時間は、基本的に短いと考えられます。<br>
予約の確認をする、予約をする、自分の予定を確認するなど、1つの目的のためだけにアプリを利用するからです。<br>
そのため、いかに手軽に利用できるかに焦点を当て、ユーザビリティが高いように開発しました。<br>

具体的に次のようなことを意識しました。<br>
* ログイン情報をクッキーに記憶し、次回アクセス時はすぐに利用可能
* UIは1目で分かるものを採用し、色合いもデザインもシンプルに
* 画面遷移を想定した戻るボタンの配置
* インクルーシブデザインへの拘り
* フレンドリーフォワーディング

# 開発で苦労した点
Ruby on Railsで開発したのが初めてだったので、全体的に正解が分からず苦労しました。<br>

一番苦労した点は、予約削除時の全体連絡をどのように行うかです。<br>
初めは全員にメール送信をしようとしました。<br>
そこで、HerokuのアドオンのSendGridを利用しようとしたのですが、非同期処理にしないとレスポンスが遅くなることが懸念されました。<br>
その上、ユーザからはLINEなら見るけどメールなら見ないと言われました。<br>
<br>
そのため、LINE BOTでどうにか通知を送れないか模索し、APIを利用する事に決めました。<br>
結果、LINEグループに1通メッセージを送れば良くなったので処理は高速になり、予約削除で時間がかかることはなくなりました。<br>