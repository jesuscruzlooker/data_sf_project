view: municiapl_rank_nbhd_comparison {
  derived_table: {
    sql_trigger_value: SELECT 1 ;;
    sql: SELECT *
      FROM (

      SELECT
          municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_category as category,
          municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_created_date_year as year,
          municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_neighborhood_group as neighborhood_group,
          municipal_neighborhood_yoy_rank_municipal_neighborhood_rank as rank


      FROM (
      SELECT *, DENSE_RANK() OVER (ORDER BY z___min_rank) as z___pivot_row_rank, RANK() OVER (PARTITION BY z__pivot_col_rank ORDER BY z___min_rank) as z__pivot_col_ordering FROM (
      SELECT *, MIN(z___rank) OVER (PARTITION BY municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_category,municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_created_date_year) as z___min_rank FROM (
      SELECT *, RANK() OVER (ORDER BY municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_category ASC, z__pivot_col_rank, municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_created_date_year) AS z___rank FROM (
      SELECT *, DENSE_RANK() OVER (ORDER BY CASE WHEN municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_neighborhood_group IS NULL THEN 1 ELSE 0 END, municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_neighborhood_group) AS z__pivot_col_rank FROM (
      SELECT
        municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category  AS municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_category,
        municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_created_date_year  AS municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_created_date_year,
        municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_neighborhood_group  AS municipal_neighborhood_yoy_rank_municipal_requests_specific_dt_neighborhood_group,
        MAX(municipal_neighborhood_yoy_rank.municipal_neighborhood_yoy_rank ) AS municipal_neighborhood_yoy_rank_municipal_neighborhood_rank
      FROM `thesis-173800.looker_scratch.LR_5MWSKCF70MF5LA69IM2JG_municipal_neighborhood_yoy_rank` AS municipal_neighborhood_yoy_rank

      WHERE (municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Street and Sidewalk Cleaning' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Graffiti' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Homeless Concerns' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Abandoned Vehicle' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Encampments' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Damaged Property' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Sewer Issues' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Street Defects' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Streetlights' OR municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_category = 'Illegal Postings') AND (municipal_neighborhood_yoy_rank.municipal_requests_specific_dt_created_date_year  = 2016)
      GROUP BY 1,2,3) ww
      ) bb WHERE z__pivot_col_rank <= 16384
      ) aa
      ) xx
      ) zz
       WHERE z___pivot_row_rank <= 500 OR z__pivot_col_ordering = 1 ORDER BY z___pivot_row_rank ) neighborhood

      UNION ALL

      SELECT *
      FROM (

      SELECT
          municipal_yoy_rank_municipal_requests_specific_dt_category as category,
          municipal_yoy_rank_municipal_requests_specific_dt_created_date_year as year,
          "a_City Wide" as neighborhood_group,
          municipal_yoy_rank_municipal_sf_rank as rank

      FROM (
      SELECT *, DENSE_RANK() OVER (ORDER BY z___min_rank) as z___pivot_row_rank, RANK() OVER (PARTITION BY z__pivot_col_rank ORDER BY z___min_rank) as z__pivot_col_ordering FROM (
      SELECT *, MIN(z___rank) OVER (PARTITION BY municipal_yoy_rank_municipal_requests_specific_dt_category) as z___min_rank FROM (
      SELECT *, RANK() OVER (ORDER BY CASE WHEN z__pivot_col_rank=1 THEN (CASE WHEN municipal_yoy_rank_municipal_sf_rank IS NOT NULL THEN 0 ELSE 1 END) ELSE 2 END, CASE WHEN z__pivot_col_rank=1 THEN municipal_yoy_rank_municipal_sf_rank ELSE NULL END ASC, municipal_yoy_rank_municipal_sf_rank ASC, z__pivot_col_rank, municipal_yoy_rank_municipal_requests_specific_dt_category) AS z___rank FROM (
      SELECT *, DENSE_RANK() OVER (ORDER BY CASE WHEN municipal_yoy_rank_municipal_requests_specific_dt_created_date_year IS NULL THEN 1 ELSE 0 END, municipal_yoy_rank_municipal_requests_specific_dt_created_date_year DESC) AS z__pivot_col_rank FROM (
      SELECT
        municipal_yoy_rank.municipal_requests_specific_dt_category  AS municipal_yoy_rank_municipal_requests_specific_dt_category,
        municipal_yoy_rank.municipal_requests_specific_dt_created_date_year  AS municipal_yoy_rank_municipal_requests_specific_dt_created_date_year,
        MAX(municipal_yoy_rank.municipal_sf_yoy_rank ) AS municipal_yoy_rank_municipal_sf_rank
      FROM `thesis-173800.looker_scratch.LR_5MCT0HZEJDNFKBKIGGYOH_municipal_yoy_rank` AS municipal_yoy_rank

      WHERE
        (municipal_yoy_rank.municipal_requests_specific_dt_created_date_year  = 2016)
      GROUP BY 1,2) ww
      ) bb WHERE z__pivot_col_rank <= 16384
      ) aa
      ) xx
      ) zz
       WHERE z___pivot_row_rank <= 10 OR z__pivot_col_ordering = 1 ORDER BY z___pivot_row_rank ) citywide
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: neighborhood_group {
    type: string
    sql: ${TABLE}.neighborhood_group ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  measure: rank_comparison {
    type: max
    sql: ${rank} ;;
  }

  set: detail {
    fields: [category, year, neighborhood_group, rank]
  }
}
