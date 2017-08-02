view: sfpd_unique_incidents {
  derived_table: {
    sql_trigger_value: SELECT 1 ;;
    sql: SELECT distinct
        unique_key,
        category,
        dayofweek,
        pddistrict,
        resolution,
        longitude,
        latitude,
        location,
        MIN(timestamp) as timestamp
      FROM `thesis-173800.sf_thesis.sfpd_incidents`
      GROUP BY 1,2,3,4,5,6,7,8
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

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: dayofweek {
    type: string
    sql: ${TABLE}.dayofweek ;;
  }

  dimension: pddistrict {
    type: string
    sql: ${TABLE}.pddistrict ;;
  }

  dimension: resolution {
    type: string
    sql: ${TABLE}.resolution ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
  }

  set: detail {
    fields: [
      unique_key,
      category,
      dayofweek,
      pddistrict,
      resolution,
      longitude,
      latitude,
      location,
      timestamp_time
    ]
  }
}
