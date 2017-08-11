view: sffd_specific_dt_beta {
  derived_table: {
    sql: SELECT
        call_number as call_number,
        incident_number as incident_number,
        call_type as call_type,
        call_date as call_date,
        zipcode_of_incident as zipcode_of_incident,
        zipcode_neighborhood_grp.neighborhood_group AS neighborhood_group,
        priority as priority,
        final_priority as final_priority,
        location as location,
        latitude as latitude,
        longitude as longitude,
        "SFFD" as source,
        unit_sequence_in_call_dispatch as total_units_on_scene,
        received_timestamp as received_timestamp,
        available_timestamp as available_timestamp,
        EXTRACT(YEAR from received_timestamp) as received_timestamp_year,
        EXTRACT(MONTH from received_timestamp) as received_timestamp_month,
        EXTRACT(HOUR from received_timestamp) + 1 as received_timestamp_hour

      FROM sf_thesis.sffd_service_calls  AS sffd_service_calls
      LEFT JOIN sf_thesis.zipcode_neighborhood_grp  AS zipcode_neighborhood_grp ON sffd_service_calls.zipcode_of_incident = zipcode_neighborhood_grp.zipcode

      WHERE ((((sffd_service_calls.call_date ) >= (DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP('2008-01-01 00:00:00') AS TIMESTAMP), DAY))) AND (sffd_service_calls.call_date ) < (DATE(TIMESTAMP_TRUNC(CAST(TIMESTAMP('2016-12-31 00:00:00') AS TIMESTAMP), DAY)))))) AND ((sffd_service_calls.zipcode_of_incident IS NOT NULL AND LENGTH(sffd_service_calls.zipcode_of_incident ) <> 0 ))
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
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

  dimension: neighborhood_group {
    type: string
    sql: ${TABLE}.neighborhood_group ;;
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

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
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

  dimension: received_timestamp_year_beta {
    type: number
    sql: ${TABLE}.received_timestamp_year ;;
  }

  dimension: received_timestamp_month_beta  {
    type: number
    sql: ${TABLE}.received_timestamp_month ;;
  }

  dimension: received_timestamp_hour_beta  {
    type: number
    sql: ${TABLE}.received_timestamp_hour ;;
  }

  set: detail {
    fields: [
      call_number,
      incident_number,
      call_type,
      call_date,
      zipcode_of_incident,
      neighborhood_group,
      priority,
      final_priority,
      location,
      latitude,
      longitude,
      source,
      total_units_on_scene,
      received_timestamp_time,
      available_timestamp_time,
      received_timestamp_year,
      received_timestamp_month,
      received_timestamp_hour
    ]
  }
}
