# README

The terms "e-commerce" and "online shopping" are sometimes used interchangeably, although at its heart, e-commerce encompasses a concept for conducting business online and includes many different services, such as allowing users to signup and signin, creating different products, adding products to carts, allowing users to comment on different products, applying coupons, and making payments online etc.

* System dependencies
  * Ruby version : 2.6.8p205

  * Rails version : 5.2.7

* Configuration
    Cloudinary
        * Add your cloudinary.yml in config/

      Postgres and Google smtp credentials
        ```bash
          $ EDITOR="code --wait" bin/rails credentials:edit
        ```
      Google smtp crdentials
          Add your credentials as
          ```bash
          google_smtp:
            email: your_smtp_app__email
            password: google_smtp_app_password_generated_for_app
          ```
      Postgres crdentials
        For postgres in development
        ```bash
          postgres:
            username: postgres_username
            password: postgres_username_password
        ```

* Database creation
  ```bash
  rails db:migrate
  ```

* Deployment instructions
  * Add postgres add on if using heroku

  * Environment Variables
    * Set RAILS_MASTER_KEY to config/master.key

* Assumptions
  * A guest can enter products to cart which will then be assigned to the user on signin
  * A user can edit or delete own products
  * A user can not add own product to cart
  * A user can not comment on own product
  * A user can edit/delete own product
  * Discount will be applied on Stripe after which the order will be placed and shown once saved

* Use cases
  * User signin/singup
  * Product feature
  * Line_items feature
  * Cart feature
  * Checkout feature
  * Order feature
