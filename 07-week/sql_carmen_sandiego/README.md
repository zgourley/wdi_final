#Party on Stuctured Query Language!

## Learning Objectives:
- What is SQL?
- How do we use it?
- Why is knowing SQL important?

## Setup
##### 1. Create a database from the console:
  ```
  $ createdb world
  ```

##### 2. Import our sample database, which has the cities, countries, and languages of the world:
  ```
  psql world -f ./world.sql
  ```

##### 3. Use psql to open up our database:
  ```
  psql world
  ```

##### 4. Let's look at all our tables:
  ```
  \dt
  ```

##### 5. How to quit psql:
  ```
  \q
  ```

## Selecting

**Note: Only single quotes work. If you get an error, make sure you're using single quotes.**

###### select everything from this table
```SQL
SELECT * FROM city;
```

###### select just certain columns
```SQL
SELECT code, name, continent, population FROM country;
```

###### find one row, based on a country code
```SQL
SELECT code, name, continent, population FROM country WHERE code='ARG';
```

###### find any rows that are similar
```SQL
SELECT code, name, continent, population FROM country WHERE code LIKE 'AR%';
```

###### find all countries where there's a population of at least 100 million people
```SQL
SELECT code, name, continent, population FROM country WHERE population >= 100000000;
```

###### return only the first record from the previous query
```SQL
SELECT code, name, continent, population FROM country WHERE population >= 100000000 LIMIT 1;
```

###### find only European countries whose population is more than 40 million
```SQL
SELECT code, name, continent, population FROM country WHERE continent='Europe' AND population > 40000000;
```

###### sort those countries by population, from most to least
```SQL
SELECT code, name, continent, population FROM country WHERE continent='Europe' AND population > 40000000 ORDER BY population DESC;
```
