# Deploying a Chatbot with CX as Code (WIP)

This is a very rough draft of a blueprint that deploys a chat bot using CX as Code.  The Chat Bot includes a data action using a lambda.

This is still being heavily developed and should not be considered production ready

Still to do:
   Need to write a Widgets CX as Code resource
   Need to write a web messaging CX as Code resource

Interesting Example:
   https://github.com/aws/aws-lambda-go
   https://github.com/MhmdRyhn/lambda-function-in-golang
   https://medium.com/craftsmenltd/aws-lambda-function-in-golang-eb0a3fa5f1b9    

To build: GOOS=linux go build -o bin/main orderstatus/cmd/main.go