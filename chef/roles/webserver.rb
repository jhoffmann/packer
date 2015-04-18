name "webserver"

run_list(
  "recipe[iapps-setup::php]",
  "recipe[iapps-setup::apache]"
)

