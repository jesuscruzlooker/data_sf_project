connection: "bq_thesis"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: municipal_sf_requests {}

explore: neighborhood_pd {}

explore: neighborhood_zip {}

explore: sffd_service_calls {}

explore: sfpd_incidents {}
