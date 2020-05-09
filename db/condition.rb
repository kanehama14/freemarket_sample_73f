# コンディションデータを全削除した上でデータ投入する
Condition.delete_all

# mysqlのautoincrementを初期化してid=1からデータを作成
ActiveRecord::Base.connection.execute "ALTER TABLE `conditions` auto_increment = 1"

Condition.create(name: "新品、未使用")
Condition.create(name: "未使用に近い")
Condition.create(name: "目立った傷や汚れなし")
Condition.create(name: "やや傷や汚れあり")
Condition.create(name: "傷や汚れあり")
Condition.create(name: "全体的に状態が悪い")
