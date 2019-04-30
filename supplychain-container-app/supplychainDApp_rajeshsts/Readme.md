The objective of this project is to streamline the process of Supply chain management with the better tracking mechanism.

# Functionality:

Application has 3 access levels.
1.	Owner: has access to create the Handlers
2.	Handlers: has an access to add the product, update the status of the product
3.	Guest : has access to check the product status 

Owner and Handler have to create the sign the transaction with their private key (With Metamask) and Guest can view the transactions.

# Techstack:
1.	JavaScript
2.	Truffle
3.	Web3.js
4.	Solidity

# Pre-requisites:
1.	Remix IDE
2.	Code editor
3.	npm package lite-server
4.	Metamask & configure Eleven01 RPC (ex: http://40.78.48.235:8083/api/node/rpc)

# Process of Execute:
1.	Clone the project
2.	Create package.json file by using the command “npm init”
3.	Install npm pakage by using the command “npm install”
4.	Install lite server by using the command “npm install lite-server”
5.	Copy the Contract code & Open Remix IDE, Paste the Contract code
6.	Select the compiler version as per the contract & select the Environment as Web3 Provider and click deploy
7.	Copy the contract address and replace in Index.html file
8.	Copy the contract ABI and replace in Index.html file
9.	Save the Index.html file
10.	Open terminal & type the command “npm run dev” to start the development server
11.	We are all set to go! 

<!-- # Screenshot:

# 1. Register Handler
![registerhandler](https://user-images.githubusercontent.com/46481618/52408360-c660cf00-2af8-11e9-81bd-8660559ec1d2.PNG)

# 2. Register Product
![registerproduct](https://user-images.githubusercontent.com/46481618/52408467-fa3bf480-2af8-11e9-9522-f9441813eba9.PNG)

# 3. Add checkpoint / Update State
![addcheckpoint](https://user-images.githubusercontent.com/46481618/52408514-00ca6c00-2af9-11e9-865b-a1360add9d89.PNG)

# 4. Track Product (1/2)
![trackproduct1](https://user-images.githubusercontent.com/46481618/52408544-12137880-2af9-11e9-94f8-b8ed87ba9574.PNG)

# 5. Track Product (2/2)
![track product2](https://user-images.githubusercontent.com/46481618/52408564-1dff3a80-2af9-11e9-91d4-79796399fb13.PNG)

# 6. Ger Handler Information
![gethandlerinfo](https://user-images.githubusercontent.com/46481618/52408582-28213900-2af9-11e9-85e3-ce3691e501ce.PNG)

# 7. List All Handers (1/2)
![listallhandlers1](https://user-images.githubusercontent.com/46481618/52408587-2ce5ed00-2af9-11e9-87bb-84be48c0f7e8.PNG)

# 8. List All Handers (2/2)
![listallhandlers2](https://user-images.githubusercontent.com/46481618/52408591-32433780-2af9-11e9-875a-69702a10a61e.PNG)

# 9. All Product Information (1/2)
![allproductinfo](https://user-images.githubusercontent.com/46481618/52408695-6e769800-2af9-11e9-8055-0447c77561b1.PNG)

# 10. All Product Information (2/2)
![all handlers info2](https://user-images.githubusercontent.com/46481618/52408714-7cc4b400-2af9-11e9-8219-172bbb6f4aee.PNG) -->
