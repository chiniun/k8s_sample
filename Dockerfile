# 构建阶段
FROM golang:1.21-alpine AS builder

# 设置工作目录
WORKDIR /app

# # 拷贝 go.mod 和 go.sum 文件
# COPY go.mod go.sum ./

# # 下载依赖
# RUN go mod download

# 拷贝源代码
COPY . .

# 编译应用程序
RUN go build -o myapp .

# 运行阶段
FROM alpine:latest

# 设置工作目录
WORKDIR /app

# 从构建阶段拷贝可执行文件
COPY --from=builder /app/myapp .

# 暴露应用程序端口
EXPOSE 9999

# 运行应用程序
CMD ["./myapp"]