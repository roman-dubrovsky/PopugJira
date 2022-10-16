require 'omniauth/keepa'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :keepa, "pFUSMOuIxuK21X_3ZadEYNTTdYqjaNDn9EG2LVsCtww", "VVNG5M4PX51tkA3_tVf7ei4puHFbPUAhfgjQAAqbBjQ", scope: "internal"
end