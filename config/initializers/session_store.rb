# Be sure to restart your server when you modify this file.

domain = Rails.env == "test" ? ".lvh.me" : "sharpplan.com"

GestionDesempeno::Application.config.session_store :cookie_store, :key => '_gestion_desempeno_session', :domain => domain

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# GestionDesempeno::Application.config.session_store :active_record_store
