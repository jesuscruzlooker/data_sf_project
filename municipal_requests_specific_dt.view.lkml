view: municipal_requests_specific_dt {
  derived_table: {
    sql: SELECT

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
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: unique_key {
    type: number
    sql: ${TABLE}.unique_key ;;
  }

  dimension_group: created_date {
    type: time
    sql: ${TABLE}.created_date ;;
  }

  dimension_group: closed_date {
    type: time
    sql: ${TABLE}.closed_date ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: agency_name {
    type: string
    sql: ${TABLE}.agency_name ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: complaint_type {
    type: string
    sql: ${TABLE}.complaint_type ;;
  }

  dimension: descriptor {
    type: string
    sql: ${TABLE}.descriptor ;;
  }

  dimension: neighborhood {
    type: string
    sql: ${TABLE}.neighborhood ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: media_url {
    type: string
    sql: ${TABLE}.media_url ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: police_district {
    type: string
    sql: ${TABLE}.police_district ;;
  }

  dimension: neighborhood_group {
    type: string
    sql: ${TABLE}.neighborhood_group ;;
  }

  dimension: zipcode {
    type: string
    sql: ${TABLE}.zipcode ;;
  }

  set: detail {
    fields: [
      unique_key,
      created_date_time,
      closed_date_time,
      status,
      agency_name,
      category,
      complaint_type,
      descriptor,
      neighborhood,
      location,
      source,
      media_url,
      latitude,
      longitude,
      police_district,
      neighborhood_group,
      zipcode
    ]
  }
}
