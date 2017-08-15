view: municipal_yoy_rank {
  derived_table: {
    sql_trigger_value: SELECT 1 ;;
    sql: SELECT
        source as source,
        municipal_requests_specific_dt_category as municipal_requests_specific_dt_category,
        municipal_requests_specific_dt_created_date_year as municipal_requests_specific_dt_created_date_year,
        municipal_requests_specific_dt_count as municipal_requests_specific_dt_count,
        RANK() OVER (PARTITION BY municipal_requests_specific_dt_created_date_year ORDER BY municipal_requests_specific_dt_count desc) as municipal_sf_yoy_rank




      FROM (

      WITH municipal_requests_specific_dt AS (SELECT

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
            WHERE (municipal_sf_requests.category <> 'MUNI Feedback' OR municipal_sf_requests.category IS NULL) AND ((((municipal_sf_requests.created_date ) >= (TIMESTAMP('2008-01-01 00:00:00')) AND (municipal_sf_requests.created_date ) < (TIMESTAMP('2017-12-31 23:59:59'))))) AND ((CASE
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
        "Municipal" AS source,
        municipal_requests_specific_dt.category  AS municipal_requests_specific_dt_category,
        EXTRACT(YEAR FROM municipal_requests_specific_dt.created_date ) AS municipal_requests_specific_dt_created_date_year,
        COUNT(*) AS municipal_requests_specific_dt_count
      FROM municipal_requests_specific_dt

      GROUP BY 1,2,3 ) municipal_rank_yoy

 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: municipal_requests_specific_dt_category {
    type: string
    sql: ${TABLE}.municipal_requests_specific_dt_category ;;
    html:
    <br>
    <font size="2"><b>{{ linked_value }}</b></font>;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: municipal_requests_specific_dt_created_date_year {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_created_date_year ;;
  }

  dimension: municipal_requests_specific_dt_count {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_count ;;
  }

  dimension: municipal_sf_yoy_rank {
    type: number
    sql: ${TABLE}.municipal_sf_yoy_rank ;;
  }

  measure: municipal_sf_rank {
    type: max
    sql: ${municipal_sf_yoy_rank} ;;
  }



  set: detail {
    fields: [municipal_requests_specific_dt_category, municipal_requests_specific_dt_created_date_year, municipal_requests_specific_dt_count, municipal_sf_yoy_rank]
  }
}
