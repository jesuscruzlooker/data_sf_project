view: municipal_sf_requests {
  sql_table_name: sf_thesis.municipal_sf_requests ;;

  dimension: agency_name {
    type: string
    sql: ${TABLE}.agency_name ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension_group: closed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CASE WHEN ${TABLE}.closed_date IS NULL THEN current_timestamp()
              ELSE ${TABLE}.closed_date END;;
  }

  dimension: complaint_type {
    type: string
    sql: ${TABLE}.complaint_type ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_date ;;
  }

  dimension: resolution_time_seconds {
    type: number
    sql: TIMESTAMP_DIFF(${closed_raw},${created_raw},SECOND) ;;
  }

  dimension: resolution_time_mins {
    type: number
    sql: ${resolution_time_seconds}/60 ;;
  }

  dimension: resolution_time_hours {
    type: number
    sql: ${resolution_time_seconds}/60/60  ;;
  }

  dimension: resolution_time_days {
    type: number
    sql: ${resolution_time_seconds}/60/60/24 ;;
  }

  measure: avg_res_mins {
    type: average
    sql: ${resolution_time_mins} ;;
    drill_fields: [agency_name]
  }

  measure: avg_res_hours {
    type: average
    sql: ${resolution_time_hours} ;;
    drill_fields: [agency_name]
  }

  measure: avg_res_days {
    type: average
    sql: ${resolution_time_days} ;;
    drill_fields: [agency_name]
  }

  measure: median_res_days {
    type: median
    sql: ${resolution_time_days} ;;
    drill_fields: [agency_name]
  }

  dimension: under_30mins {
    case: {
      when: {
        sql: ${resolution_time_days} <= .021 ;;
        label: "Under 30"
      }

      when: {
        sql: ${resolution_time_days} > .021 AND  ${resolution_time_days} < .042 ;;
        label: "30mins to 1 Hour"
      }

      else: "More than 1 hour"

    }
  }

  dimension: resolution_group {
    case: {
      when: {
        sql: ${resolution_time_seconds} <= 0 ;;
        label: "Data Entry Error"
      }

      when: {
        sql: ${resolution_time_seconds} > 0 AND ${closed_raw} <> current_timestamp() ;;
        label: "Closed Case"
      }

      when: {
        sql: ${resolution_time_seconds} > 0 AND ${closed_raw} = current_timestamp() ;;
        label: "Open Case"
      }

      else: "Unknown"
    }
  }

  dimension: descriptor {
    type: string
    sql: ${TABLE}.descriptor ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: municipal_location {
    type: location
    sql_latitude:  ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }


  dimension: media_url {
    type: string
    sql: ${TABLE}.media_url ;;
  }

  dimension: neighborhood {
    type: string
    sql: ${TABLE}.neighborhood ;;
  }

  dimension: police_district {
    type: string
    sql: ${TABLE}.police_district ;;
  }

  dimension_group: resolution_action_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.resolution_action_updated_date ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: status_notes {
    hidden: yes
    type: string
    sql: ${TABLE}.status_notes ;;
  }

  dimension: supervisor_district {
    hidden: yes
    type: number
    sql: ${TABLE}.supervisor_district ;;
  }

  dimension: unique_key {
    hidden: yes
    type: number
    sql: ${TABLE}.unique_key ;;
  }

  dimension: incident_address {
    hidden: yes
    type: string
    sql: ${TABLE}.incident_address ;;
  }

  measure: count {
    type: count
    drill_fields: [agency_name]
  }



}
