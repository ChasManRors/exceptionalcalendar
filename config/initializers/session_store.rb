# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_whencanyoumeet_session',
  :secret      => 'b203d8b3cc8924694baf1b6b3db7dd9960154cb8ee68787f52c45822e1db31446e5e107d8f8914f27917fab81885810e533b776dfa52964d2ea4d478cec6ac3b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
