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

    filters: {
      field: resolution_group
      value: "-Data Entry Error"
    }


    filters: {
      field: created_year
      value:"2008/01/01 00:00:00 to 2016/12/31 23:59:59"
    }

  }

  join: neighborhood_zip {
    relationship: many_to_one
    sql_on: ${municipal_sf_requests.neighborhood} = ${neighborhood_zip.neighborhood} ;;
  }
}

explore: neighborhood_pd {}

explore: neighborhood_zip {}

explore: sffd_service_calls {
  join: zipcode_neighborhood_grp {
    relationship: many_to_one
    sql_on: ${sffd_service_calls.zipcode_of_incident} = ${zipcode_neighborhood_grp.zipcode} ;;
  }
}

explore: sfpd_incidents {}
