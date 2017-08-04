connection: "bq_thesis"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


explore: sffd_unique_incidents {
  join: zipcode_neighborhood_grp {
    relationship: many_to_one
    sql_on: ${sffd_unique_incidents.zipcode_of_incident} = ${zipcode_neighborhood_grp.zipcode} ;;
  }
}
explore: sfpd_unique_incidents {}

explore: municipal_requests_specific_dt {}
