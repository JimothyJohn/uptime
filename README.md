# visuals

Visual sandbox for Uptime application.

### Quickstart

```bash
utils/Quickstart.sh
```

### Sample Query

```sql
WITH averaged_samples AS (
  SELECT
    BIN(time, 12m) AS time_bin,
    id,
    AVG(CAST(current AS BIGINT)) AS averageValue
  FROM "tableName".database 
  WHERE measure_name = 'a_rms'
  AND id in ('aaa', 'bbb')
  AND time >= ago(12h)
  GROUP BY BIN(time, 12m), id
)
SELECT 
  time_bin AS time,
  id,
  averageValue
FROM 
  averaged_samples
ORDER BY 
  time_bin, 
  id
```

## Examples

Day (dark mode)

![Day visuals](docs/dashboard.png)

### TODO

* Add tests