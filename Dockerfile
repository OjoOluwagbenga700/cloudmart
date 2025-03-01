FROM node:16-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:16-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/dist /app
ENV PORT=5001
ENV NODE_ENV=production
ENV VITE_API_BASE_URL=http://a3140d8d3036a47668f11cf9d160a4d3-43502068.us-east-1.elb.amazonaws.com:5000/api
EXPOSE 5001
CMD ["serve", "-s", ".", "-l", "5001"]
