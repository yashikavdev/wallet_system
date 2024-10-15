Wallet System API

This is a Rails API application for managing wallets and transactions. The application manages different wallet types for users, teams, and stocks. It also includes custom authentication using has_secure_password for users.
Features

    User Authentication: Custom sign-in and sign-out system using sessions.
    Wallets: Wallets are managed for users, teams, and stocks with corresponding transactions.
    Transactions: Supports credit and debit transactions between wallets.
    RapidAPI Integration: Fetches data from external services using the RapidAPI.

Getting Started
Prerequisites

    Ruby 3.0+
    Rails 7.0+
    PostgreSQL or any other supported database
    Bundler (install it with: gem install bundler)

Installation

    Clone the repository: git clone https://github.com/yashikavdev/wallet_system.git
    bundle install
    rails db:create
    rails db:migrate
    rails db:seed
    rails server

API Documentation

The API endpoints are organized in a Postman collection, which is available with the project. You can import the collection into Postman for testing the API.

    Postman Collection: Wallet Transaction System.postman_collection.json
