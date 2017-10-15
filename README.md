ruby main.rb

http://localhost:4567/

openssl genrsa -out key.rsa 2048

openssl rsa -in key.rsa -pubout > key.rsa.pub