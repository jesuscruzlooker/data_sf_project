view: municpal_seasonality {
  derived_table: {
    sql_trigger_value: SELECT 1 ;;
    sql: WITH municipal_requests_specific_dt AS (SELECT

              unique_key as unique_key,
              created_date as created_date,
              closed_date as closed_date,
              status as status,
              agency_name as agency_name,
              category as category,
              complaint_type as complaint_type,
              descriptor as descriptor,
              municipal_sf_requests.neighborhood as neighborhood,
              location as location,
              source as source,
              media_url as media_url,
              latitude as latitude,
              longitude as longitude,
              police_district as police_district,
              neighborhood_group as neighborhood_group,
              zipcode as zipcode



            FROM sf_thesis.municipal_sf_requests  AS municipal_sf_requests
            LEFT JOIN sf_thesis.neighborhood_zip  AS neighborhood_zip ON municipal_sf_requests.neighborhood = neighborhood_zip.neighborhood
            WHERE (municipal_sf_requests.category <> 'MUNI Feedback' OR municipal_sf_requests.category IS NULL) AND ((((municipal_sf_requests.created_date ) >= (TIMESTAMP('2008-01-01 00:00:00')) AND (municipal_sf_requests.created_date ) < (TIMESTAMP('2016-12-31 23:59:59'))))) AND ((CASE
            WHEN (TIMESTAMP_DIFF((CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END),municipal_sf_requests.created_date,SECOND)) <= 0  THEN 'Data Entry Error'
            WHEN (TIMESTAMP_DIFF((CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END),municipal_sf_requests.created_date,SECOND)) > 0 AND (CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END) <> current_timestamp()  THEN 'Closed Case'
            WHEN (TIMESTAMP_DIFF((CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END),municipal_sf_requests.created_date,SECOND)) > 0 AND (CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END) = current_timestamp()  THEN 'Open Case'
            ELSE 'Unknown'
            END <> 'Data Entry Error' OR CASE
            WHEN (TIMESTAMP_DIFF((CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END),municipal_sf_requests.created_date,SECOND)) <= 0  THEN 'Data Entry Error'
            WHEN (TIMESTAMP_DIFF((CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END),municipal_sf_requests.created_date,SECOND)) > 0 AND (CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END) <> current_timestamp()  THEN 'Closed Case'
            WHEN (TIMESTAMP_DIFF((CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END),municipal_sf_requests.created_date,SECOND)) > 0 AND (CASE WHEN municipal_sf_requests.closed_date IS NULL THEN current_timestamp()
                          ELSE municipal_sf_requests.closed_date END) = current_timestamp()  THEN 'Open Case'
            ELSE 'Unknown'
            END IS NULL)) AND ((municipal_sf_requests.neighborhood IS NOT NULL AND LENGTH(municipal_sf_requests.neighborhood ) <> 0 ))
             )
      SELECT
        municipal_requests_specific_dt.category  AS municipal_requests_specific_dt_category,
        EXTRACT(YEAR FROM municipal_requests_specific_dt.created_date ) AS municipal_requests_specific_dt_created_date_year,
        EXTRACT(MONTH FROM municipal_requests_specific_dt.created_date ) AS municipal_requests_specific_dt_created_date_month,
        EXTRACT(HOUR FROM municipal_requests_specific_dt.created_date ) + 1 AS municipal_requests_specific_dt_created_date_hour,
        EXTRACT(DAYOFWEEK FROM municipal_requests_specific_dt.created_date ) AS municipal_requests_specific_dt_created_date_dow,
        COUNT(*) AS municipal_requests_specific_dt_count
      FROM municipal_requests_specific_dt

      GROUP BY 1,2,3,4,5
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: municipal_requests_specific_dt_category {
    type: string
    sql: ${TABLE}.municipal_requests_specific_dt_category ;;
  }

  dimension: municipal_requests_specific_dt_created_date_year {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_created_date_year ;;
  }

  dimension: municipal_requests_specific_dt_created_date_month {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_created_date_month ;;
  }

  dimension: municipal_requests_specific_dt_created_date_hour {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_created_date_hour ;;
  }

  dimension: municipal_requests_specific_dt_created_date_dayofweek {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_created_date_dow ;;
  }

  dimension: municipal_requests_specific_dt_count {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_count ;;
  }

  measure: municipal_requests_seasonal_average {
    type: average
    sql: ${municipal_requests_specific_dt_count} ;;
  }

  measure: municipal_requests_seasonal_sum {
    type: sum
    sql: ${municipal_requests_specific_dt_count} ;;
  }
  set: detail {
    fields: [municipal_requests_specific_dt_category, municipal_requests_specific_dt_created_date_year, municipal_requests_specific_dt_created_date_month, municipal_requests_specific_dt_count]
  }
}
