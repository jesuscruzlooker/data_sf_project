connection: "bq_thesis"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"


# Municipal 311 Requests PDT (Select 1) with preset filters
# Remove Data Entry Errors, Certain Categories, and limit scope of data to 2008 - 2016 (~2017)

explore: municipal_requests_specific_dt {}


# Municipal 311 YOY RANK Requests PDT (Select 1) with preset filters
# Remove Data Entry Errors, Certain Categories, and limit scope of data to 2008 - 2016 (~2017)

explore: municipal_yoy_rank {}


# Municipal 311 Neighborhood YOY RANK Requests PDT (Select 1) with preset filters
# Remove Data Entry Errors, Certain Categories, and limit scope of data to 2008 - 2016 (~2017)

explore: municipal_neighborhood_yoy_rank {}

# Municipal 311 Request Seasonlity by Calendar Month PDT (Select 1) with preset filters
# Remove Data Entry Errors, Certain Categories, and limit scope of data to 2008 - 2016 (~2017)

explore: municpal_seasonality {}


explore: sffd_unique_incidents {
  join: zipcode_neighborhood_grp {
    relationship: many_to_one
    sql_on: ${sffd_unique_incidents.zipcode_of_incident} = ${zipcode_neighborhood_grp.zipcode} ;;
  }
}
explore: sfpd_unique_incidents {}
