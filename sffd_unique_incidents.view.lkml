view: sffd_unique_incidents {
  derived_table: {
    sql_trigger_value: SELECT 1 ;;
    sql: SELECT
        call_number,
        incident_number,
        call_type,
        call_date,
        zipcode_of_incident,
        priority,
        final_priority,
        location,
        latitude,
        longitude,
        MAX(unit_sequence_in_call_dispatch) as total_units_on_scene,
        MIN(received_timestamp) as received_timestamp,
        MAX(available_timestamp) as available_timestamp

      FROM `thesis-173800.sf_thesis.sffd_service_calls`
      GROUP BY 1,2,3,4,5,6,7,8,9,10
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: call_number {
    type: number
    sql: ${TABLE}.call_number ;;
  }

  dimension: incident_number {
    type: number
    sql: ${TABLE}.incident_number ;;
  }

  dimension: call_type {
    type: string
    sql: ${TABLE}.call_type ;;
  }

  dimension: call_date {
    type: date
    sql: ${TABLE}.call_date ;;
  }

  dimension: zipcode_of_incident {
    type: string
    sql: ${TABLE}.zipcode_of_incident ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.priority ;;
  }

  dimension: final_priority {
    type: number
    sql: ${TABLE}.final_priority ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: total_units_on_scene {
    type: number
    sql: ${TABLE}.total_units_on_scene ;;
  }

  dimension_group: received_timestamp {
    type: time
    sql: ${TABLE}.received_timestamp ;;
  }

  dimension_group: available_timestamp {
    type: time
    sql: ${TABLE}.available_timestamp ;;
  }

  set: detail {
    fields: [
      call_number,
      incident_number,
      call_type,
      call_date,
      zipcode_of_incident,
      priority,
      final_priority,
      location,
      latitude,
      longitude,
      total_units_on_scene,
      received_timestamp_time,
      available_timestamp_time
    ]
  }
}
