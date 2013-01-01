JsRoutes.setup do |config|
  config.namespace = 'condor3.routes'
  if Rails.env == 'development'
    config.prefix = '/condor3/'
  end
end
