#  -*- coding: utf-8 -*-
# 
#  Copyright 2012-2013 Ease Software, Inc. and Perry Smith
#  All Rights Reserved
# 
# Be sure to restart your server when you modify this file.

# Condor3::Application.config.session_store :cookie_store, key: '_condor3_session'

# From the Dalli Readme
Condor3::Application.config.session_store ActionDispatch::Session::CacheStore

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Condor3::Application.config.session_store :active_record_store
