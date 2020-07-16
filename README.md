# rails-engine
## by [Alex Pariseau](https://github.com/arpariseau)

#### Built to work in conjunction with [rails-driver](https://github.com/turingschool-examples/rails_driver)
---

### API Endpoints
#### Merchant REST Endpoints
- GET api/v1/merchants - returns all merchants.
- GET api/v1/merchants/:id - returns a specific merchant.
- POST api/v1/merchants - posts a new merchant to the database, returns the new merchant data.
- DELETE api/v1/merchants/:id - deletes a merchant from the database, returns the deleted merchant data.
- PUT/PATCH api/v1/merchants/:id - edits a merchant in the database, returns the updated merchant data.

#### Item REST Endpoints
- GET api/v1/items - returns all items.
- GET api/v1/items/:id - returns a specific item.
- POST api/v1/items - posts a new item to the database, returns the new item data.
- DELETE api/v1/items/:id - deletes an item from the database, returns the deleted item data.
- PUT/PATCH api/v1/items/:id - edits an item in the database, returns the updated item data.

#### Relational Endpoints
- GET api/v1/merchants/:id/items - returns all items associated to a merchant.
- GET api/v1/items/:id/merchant - returns the merchant associated to the item.

#### Merchant Find Endpoints
- GET api/v1/merchants/find?(:attribute)=(:value) - returns a merchant that matches the attribute to the value. Can access all attributes of the merchant and multiple attributes at one time. Can return a string search even with only a piece of the full value.
- GET api/v1/merchants/find_all?(:attribute)=(:value) - returns all merchants that match the attribute to the value. Can access all attributes of the merchant and multiple attributes at one time. Can return a string search even with only a piece of the full value.

#### Item Find Endpoints
- GET api/v1/items/find?(:attribute)=(:value) - returns an item that matches the attribute to the value. Can access all attributes of the item and multiple attributes at one time. Can return a string search even with only a piece of the full value.
- GET api/v1/items/find?(:attribute)=(:value) - returns all items that match the attribute to the value. Can access all attributes of the item and multiple attributes at one time. Can return a string search even with only a piece of the full value.

#### Business Intelligence Endpoints
- GET /api/v1/merchants/most_revenue?quantity=(:number) - returns the top number of merchants, based on revenue in successful transactions. If no quantity parameter is passed, returns all merchants, sorted by revenue from top to bottom.
- GET /api/v1/merchants/most_items?quantity=(:number) - returns the top number of merchants, based on items sold in successful transactions. If no quantity parameter is passed, returns all merchants, sorted by items sold from top to bottom.
- GET /api/v1/revenue?start=(:start_date)&end=(:end_date) - returns total revenue earned by all merchants in successful transactions between the beginning and end dates.
- GET /api/v1/merchants/:id/revenue - returns revenue earned by a specific merchant in successful transactions.
