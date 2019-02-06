if Rails.env.development? && ENV['BYEBUG_SERVER_FOR_POW'] == 'enable'
  require 'byebug/core'
  Byebug.start_server 'localhost', ENV.fetch('BYEBUG_SERVER_PORT', 1048).to_i
  # run `byebug -R localhost:1048` to attach debug
end
