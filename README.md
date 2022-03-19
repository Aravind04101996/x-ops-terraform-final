# 
Operations Task
## Practical case: Deployable development environment

### Premise

Provided are two simplified parts of the same application environment: A database dump and an API service. Your task is to automate setting up the development environment in a reliable and testable manner using "infrastructure as code" principles.

The goal is to end up with a limited set of commands that would install the different environments and run them using containers. You can use any software that you find suitable for the task. 

The configuration file `rates/config.py` has some defaults that will most likely change depending on the solution. It would be beneficial to have a way to more dynamically pass in config values.
### Running the database

There’s an SQL dump in `db/rates.sql` that needs to be loaded into a PostgreSQL 13.5 database.

After installing the database, the data can be imported through:

```
createdb rates
psql -h localhost -U postgres < db/rates.sql
```

You can verify that the database is running through:

```
psql -h localhost -U postgres -c "SELECT 'alive'"
```

The output should be something like:

```
 ?column?
----------
 alive
(1 row)
```

### Running the API service

Start from the `rates` folder.

#### 1. Install prerequisites

```
DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y python3-pip
pip install -U gunicorn
pip install -Ur requirements.txt
```

#### 2. Run the application
```
gunicorn -b :3000 wsgi
```

The API should now be running on [http://localhost:3000](http://localhost:3000).

#### 3. Test the application

Get average rates between ports:
```
curl "http://127.0.0.1:3000/rates?date_from=2021-01-01&date_to=2021-01-31&orig_code=CNGGZ&dest_code=EETLL"
```

The output should be something like this:
```
{
   "rates" : [
      {
         "count" : 3,
         "day" : "2021-01-31",
         "price" : 1154.33333333333
      },
      {
         "count" : 3,
         "day" : "2021-01-30",
         "price" : 1154.33333333333
      },
      ...
   ]
}
```

### Implementation
```
Note: Refer `Implementation Details.docx` for more details about implementation.
``` 
