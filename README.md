# sequel-pg_advisory_locking

sequel-pg_advisory_locking is a Sequel extension that adds support for [PostgreSQL's advisory locks](http://www.postgresql.org/docs/9.4/static/explicit-locking.html#ADVISORY-LOCKS).


## Usage

This adds two methods to `Sequel::Database`.

Both methods require an integer key, which is passed directly to PostgreSQL's advisory locking functions.

`with_advisory_lock` will block and yield when it obtains the lock (pg_advisory_lock). It returns the value of the block. 

    DB.with_advisory_lock(1) do
        has_exclusive_lock()
    end`try_advisory_lock` will yield to the block if the lock is immediately available (pg_try_advisory_lock). It returns the value of the block, or nil if it was unable to obtain the lock.
Each method uses exclusive locks by default. They can be told to use shared locks (pg_advisory_lock_shared and pg_try_advisory_lock_shared) by passing a hash with an `exclusive` key set to false as the second argument:
    DB.with_advisory_lock(1, exclusive: false) do
        has_shared_lock()    end