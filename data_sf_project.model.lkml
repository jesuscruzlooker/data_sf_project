connection: "bq_thesis"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: municipal_sf_requests {

  always_filter: {
    filters: {
      field: category
      value: "-MUNI Feedback"
    }

    filters: {
      field: neighborhood
      value: "-EMPTY"
    }
  }

  join: neighborhood_zip {
    relationship: many_to_one
    sql_on: ${municipal_sf_requests.neighborhood} = ${neighborhood_zip.neighborhood} ;;
  }
}

explore: neighborhood_pd {}

explore: neighborhood_zip {}

explore: sffd_service_calls {}

explore: sfpd_incidents {}
