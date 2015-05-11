# sequel-pg_advisory_locking

sequel-pg_advisory_locking is a Sequel extension that adds support for [PostgreSQL's advisory locks](http://www.postgresql.org/docs/9.4/static/explicit-locking.html#ADVISORY-LOCKS).


## Usage

This adds two methods to `Sequel::Database`.

Both methods require an integer key, which is passed directly to PostgreSQL's advisory locking functions.

`with_advisory_lock` will block and yield when it obtains the lock (pg_advisory_lock). It returns the value of the block. 

    DB.with_advisory_lock(1) do
        has_exclusive_lock()
    end


        has_shared_lock()