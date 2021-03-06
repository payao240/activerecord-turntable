require "active_record/associations/preloader/association"

module ActiveRecord::Turntable
  module ActiveRecordExt
    module AssociationPreloader
      include ShardingCondition

      # @note Override to add sharding condition on preload
      def records_for(ids)
        returning_scope = super
        if should_use_shard_key?
          returning_scope = returning_scope.where(klass.turntable_shard_key => owners.map(&foreign_shard_key.to_sym).uniq)
        end
        returning_scope
      end
    end
  end
end
