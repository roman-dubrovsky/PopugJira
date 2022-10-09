require 'omniauth/keepa'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :keepa, "yBD0-NmQHFM0UuekY3pGZHA9bmbJVWg5aVR-53HSwe4", "4vqjn_q3bBrkZPzYiSPKAamXtuWiY5R1lchkdTR8kIo", scope: "internal"
end