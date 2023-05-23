view: sql_runner_query {
  derived_table: {
    sql: SELECT
          order_items.id  AS `order_items.id`,
          order_items.order_id  AS `order_items.order_id`,
          order_items.sale_price * 100 AS `order_items.sale_price`,
          COUNT(*) AS `order_items.count`
      FROM demo_db.order_items  AS order_items
      GROUP BY
          1,
          2,
          3
      ORDER BY
          COUNT(*) DESC
       ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_id {
    type: number
    sql: ${TABLE}.`order_items.id` ;;
  }

  dimension: order_items_order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.`order_items.order_id` ;;
  }

  dimension: order_items_sale_price {
    type: number
    sql: ${TABLE}.`order_items.sale_price` ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.`order_items.count` ;;
  }

  set: detail {
    fields: [order_items_id, order_items_order_id, order_items_sale_price, order_items_count]
  }
}
