options = {
  scope: 'email, profile'
}

unless Rails.env.production?
  options.merge!({
      client_options: {
        ssl: {
          ca_file: '/usr/local/etc/openssl/certs/ca-bundle.crt',
          ca_path: '/usr/local/etc/openssl/certs'
        }
      }
    })
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:google_oauth2, Settings.google_client_id, Settings.google_client_secret, options)
end
