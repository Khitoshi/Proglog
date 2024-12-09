# Proglog

# 起動方法
imageを作成
`$docker build -t proglog:latest .`

コンテナ起動&作成
`$docker run -it --name proglog -p 50051:50051 -v proglog-src:/app/src proglog bash`

コンテナ起動
`$docker start -ai proglog`
