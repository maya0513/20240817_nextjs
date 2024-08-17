# ビルドステージ
FROM node:18-alpine AS build

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

# 本番ステージ
FROM node:18-alpine

# 作業ディレクトリを設定
WORKDIR /app

# ビルド結果をコピー
COPY --from=build /app/.next .next
COPY --from=build /app/public public
COPY --from=build /app/package*.json ./

# 依存関係をインストール（プロダクション用）
RUN npm install --only=production

# アプリケーションを起動
CMD ["npm", "start"]

# アプリケーションがリスンするポートを指定
EXPOSE 3000
