view: municipal_neighborhood_yoy_rank {
  derived_table: {
    sql_trigger_value: SELECT 1 ;;
    sql: SELECT
        municipal_requests_specific_dt_neighborhood_group as municipal_requests_specific_dt_neighborhood_group,
        municipal_requests_specific_dt_category as municipal_requests_specific_dt_category,
        municipal_requests_specific_dt_created_date_year as municipal_requests_specific_dt_created_date_year,
        municipal_requests_specific_dt_count as municipal_requests_specific_dt_count,
        RANK() OVER (PARTITION BY municipal_requests_specific_dt_neighborhood_group, municipal_requests_specific_dt_created_date_year ORDER BY municipal_requests_specific_dt_count desc) as municipal_neighborhood_yoy_rank




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
        municipal_requests_specific_dt.neighborhood_group  AS municipal_requests_specific_dt_neighborhood_group,
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

  dimension: municipal_requests_specific_dt_neighborhood_group {
    type: string
    sql: ${TABLE}.municipal_requests_specific_dt_neighborhood_group ;;

  }

  dimension: municipal_requests_specific_dt_category {
    type: string
    sql: ${TABLE}.municipal_requests_specific_dt_category ;;
    html:<font size="3"><b>{{ linked_value }}</b></font> ;;
    link: {
      label:"Test"
      url: "https://dcl.dev.looker.com/explore/data_sf_project/municipal_neighborhood_yoy_rank?fields=municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category,municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_created_date_year,municipal_neighborhood_yoy_rank.municipal_neighborhood_rank&pivots=municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_created_date_year&f[municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_neighborhood_group]={{ _filters['municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_neighborhood_group'] | url_encode }}&sorts=municipal_neighborhood_yoy_rank.municipal_neighborhood_rank+8,municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_created_date_year+0&limit=10&column_limit=50&vis=%7B%22stacking%22%3A%22%22%2C%22show_value_labels%22%3Afalse%2C%22label_density%22%3A24%2C%22legend_position%22%3A%22center%22%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Atrue%2C%22limit_displayed_rows%22%3Afalse%2C%22y_axis_combined%22%3Atrue%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22x_axis_scale%22%3A%22ordinal%22%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22show_null_points%22%3Atrue%2C%22point_style%22%3A%22circle%22%2C%22interpolation%22%3A%22linear%22%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Afalse%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_line%22%2C%22show_row_numbers%22%3Atrue%2C%22truncate_column_names%22%3Afalse%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22table_theme%22%3A%22editable%22%2C%22enable_conditional_formatting%22%3Afalse%2C%22conditional_formatting_ignored_fields%22%3A%5B%5D%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%2C%22series_types%22%3A%7B%7D%2C%22swap_axes%22%3Atrue%2C%22hidden_series%22%3A%5B%222009%22%2C%222010%22%2C%222011%22%2C%222012%22%2C%222013%22%2C%222015%22%5D%2C%22y_axis_reversed%22%3Afalse%2C%22y_axes%22%3A%5B%7B%22label%22%3A%22%22%2C%22maxValue%22%3Anull%2C%22minValue%22%3Anull%2C%22orientation%22%3A%22left%22%2C%22showLabels%22%3Atrue%2C%22showValues%22%3Atrue%2C%22tickDensity%22%3A%22default%22%2C%22tickDensityCustom%22%3A13%2C%22type%22%3A%22linear%22%2C%22unpinAxis%22%3Atrue%2C%22valueFormat%22%3Anull%2C%22series%22%3A%5B%7B%22id%22%3A%222008%22%2C%22name%22%3A%222008%22%7D%2C%7B%22id%22%3A%222009%22%2C%22name%22%3A%222009%22%7D%2C%7B%22id%22%3A%222010%22%2C%22name%22%3A%222010%22%7D%2C%7B%22id%22%3A%222011%22%2C%22name%22%3A%222011%22%7D%2C%7B%22id%22%3A%222012%22%2C%22name%22%3A%222012%22%7D%2C%7B%22id%22%3A%222013%22%2C%22name%22%3A%222013%22%7D%2C%7B%22id%22%3A%222014%22%2C%22name%22%3A%222014%22%7D%2C%7B%22id%22%3A%222015%22%2C%22name%22%3A%222015%22%7D%2C%7B%22id%22%3A%222016%22%2C%22name%22%3A%222016%22%7D%5D%7D%5D%2C%22x_axis_reversed%22%3Afalse%2C%22colors%22%3A%5B%22palette%3A+Green+to+Red%22%5D%2C%22series_colors%22%3A%7B%222016+-+municipal_neighborhood_yoy_rank.municipal_neighborhood_rank%22%3A%22%23f52d12%22%7D%7D&filter_config=%7B%22municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_neighborhood_group%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ _filters['municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_neighborhood_group'] | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%5D&origin=share-expanded"
      }
  }

  dimension: municipal_requests_specific_dt_created_date_year {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_created_date_year ;;
  }

  dimension: municipal_requests_specific_dt_count {
    type: number
    sql: ${TABLE}.municipal_requests_specific_dt_count ;;
  }

  dimension: municipal_neighborhood_yoy_rank {
    type: number
    sql: ${TABLE}.municipal_neighborhood_yoy_rank ;;
  }

  measure: municipal_neighborhood_rank {
    type: max
    sql: ${municipal_neighborhood_yoy_rank} ;;
  }


  set: detail {
    fields: [municipal_requests_specific_dt_neighborhood_group, municipal_requests_specific_dt_category, municipal_requests_specific_dt_created_date_year, municipal_requests_specific_dt_count, municipal_neighborhood_yoy_rank]
  }
}
