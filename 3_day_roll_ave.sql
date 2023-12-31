WITH daily_totals AS (
  SELECT
    DATE(transaction_time) AS transaction_date,
    SUM(transaction_amount) AS total_amount
  FROM
    transactions
  GROUP BY
    DATE(transaction_time)
),
rolling_averages AS (
  SELECT
    transaction_date,
    AVG(total_amount) OVER (
      ORDER BY transaction_date
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_average
  FROM
    daily_totals
)

SELECT
  transaction_date,
  rolling_average
FROM
  rolling_averages
WHERE
  transaction_date = '2021-01-31'
