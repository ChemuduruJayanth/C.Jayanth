view: sql_runner_query {
  derived_table: {
    sql: SELECT
          inventory_items.id  AS `inventory_items.id`,
              (DATE(CONVERT_TZ(inventory_items.sold_at ,'UTC','Asia/Kolkata'))) AS `inventory_items.sold_date`,
          AVG(inventory_items.cost ) AS `inventory_items.average_cost`
      FROM demo_db.inventory_items  AS inventory_items
      GROUP BY
          1,
          2
      ORDER BY
          (DATE(CONVERT_TZ(inventory_items.sold_at ,'UTC','Asia/Kolkata'))) DESC
      LIMIT 100
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: inventory_items_id {
    type: number
    sql: ${TABLE}.`inventory_items.id` ;;
  }

  dimension: inventory_items_sold_date {
    type: date
    sql: ${TABLE}.`inventory_items.sold_date` ;;
  }

  dimension: inventory_items_average_cost {
    type: number
    sql: ${TABLE}.`inventory_items.average_cost` ;;
  }

  set: detail {
    fields: [inventory_items_id, inventory_items_sold_date, inventory_items_average_cost]
  }
}
