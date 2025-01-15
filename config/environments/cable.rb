Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.active_record.migration_error = :page_load

  config.log_level = :debug
end
