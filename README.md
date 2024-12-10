# Proglog

# 起動方法
imageを作成\n
`$docker build -t proglog:latest .`

コンテナ起動&作成\n
`$docker run -it --name proglog -p 50051:50051 -v proglog-src:/app/src proglog bash`

コンテナ起動\n
`$docker start -ai proglog`
