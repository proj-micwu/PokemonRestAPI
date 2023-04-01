# README

Run the following commands to setup and seed the database:
```
rails db:migrate
rails db:seed
```

Run this command to start the server
```
rails s
```

## CRUD Operations

### READ
To fetch pokemons (read), use the following endpoints. You can pass a *page* and *per_page* in the querystring to define the page number and page size. By default, they are gonna have a value of 1 and 10 respectively.

```
GET: http://localhost:3000/api/pokemons
GET: http://localhost:3000/api/pokemons?page=1
GET: http://localhost:3000/api/pokemons?page=1&per_page=10
```

### CREATE
To create a new pokemon, use the following endpoint. You need to provide mandatory fields for a pokemon (name, type1, hp, attack, defense, spatk, spdef, speed, generation, legendary). 

The type2 attribute isn't mandatory because a pokemon can have only one type. 

The total attribute isn't mandatory because it can be calculated by summing up all the other stats (attack, defense, special attack, etc.). 
```
POST: http://localhost:3000/api/pokemons
```

### UPDATE
To update an existing pokemon, use the following endpoint. You need to provide the id of the pokemon you want to update. If any of the pokemon stats are updated, the total attribute will also be updated automatically.

```
PUT: http://localhost:3000/api/pokemons/:id
```

### DELETE
To delete an existing pokemon, use the following endpoint. You need to provate the id of the pokemon you want to delete.
```
DELETE: http://localhost:3000/api/pokemons/:id
```

## Unit tests
I created unit tests for the controller that test the different endpoints.

Run this command to setup the test database
```
rails db:migrate RAILS_ENV=test
```

Run this command to execute the tests
```
rails test
```