# ベースイメージとして Node.js を使用
FROM node:18

# 作業ディレクトリを設定
WORKDIR /app

# package.json と package-lock.json をコピー
COPY package*.json ./

# 依存関係をインストール
RUN npm install

# 残りのファイルをコピー
COPY . .

# ビルドを実行
RUN npm run build

# アプリケーションを起動
CMD ["npm", "start"]

# アプリケーションがリスンするポートを指定
EXPOSE 3000
