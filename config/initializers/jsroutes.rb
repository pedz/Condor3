JsRoutes.setup do |config|
  if Rails.env == 'development'
    config.prefix = '/condor3/'
  end
end
