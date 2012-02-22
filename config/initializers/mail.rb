ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => "app695661@heroku.com",
  :password       => "m8eetf55",
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp


ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true