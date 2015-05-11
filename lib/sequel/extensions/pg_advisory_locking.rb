require 'sequel'

module Sequel
  module Postgres
    module PgAdvisoryLocking

      def with_advisory_lock(id, opts = {}, &block)
        exclusive = opts.fetch(:exclusive, true)
        lockfn = exclusive ? :pg_advisory_lock : :pg_advisory_lock_shared
        unlockfn = exclusive ? :pg_advisory_unlock : :pg_advisory_unlock_shared
        yield_with_advisory_lock(id, lockfn, unlockfn, &block)
      end

      def try_advisory_lock(id, opts = {}, &block)
        exclusive = opts.fetch(:exclusive, true)
        lockfn = exclusive ? :pg_try_advisory_lock : :pg_try_advisory_lock_shared
        unlockfn = exclusive ? :pg_advisory_unlock : :pg_advisory_unlock_shared
        yield_with_advisory_lock(id, lockfn, unlockfn, &block)
      end

      private

      def yield_with_advisory_lock(id, lockfn, unlockfn, &block)
        if get(Sequel.function(lockfn, id))
          begin
            yield
          ensure
            get(Sequel.function(unlockfn, id))
          end
        end
      end

    end
  end

  Database.register_extension(:pg_advisory_locking, Postgres::PgAdvisoryLocking)
end
